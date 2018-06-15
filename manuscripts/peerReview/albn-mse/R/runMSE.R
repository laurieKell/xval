library(FLCore)
library(ggplotFL)
library(FLash)
library(FLBRP)
library(mpb)

library(RSQLite)
library(DBI)

dirDat="/home/laurence/Desktop/sea++/xval/manuscripts/peerReview/albn-mse/data"

load(file.path(dirDat,"setup.RData"))

## MSE OMs to run
# Key to identify main effects to run from design
load(file.path(dirDat,"/omKey.RData"))

## OM
options=list(OM =rbind(data.frame(i=as.numeric(names(omKey)),ar=0.0),
                       data.frame(i=21,                      ar=0.5),
                       data.frame(i=21,                      ar=rep(0.0,2))))

## HCRs
options$HCR =expand.grid(ftar=c(.5,.75),blim=c(.3,.4),btrig=c(0.6,0.8))

## SA
options$SA =rbind(data.frame(p=1,prr=c("None","r","k","fmsy","bmsy"),stringsAsFactors=FALSE),
                                                                               data.frame(p=2,prr=c("None","r","k","fmsy"),       stringsAsFactors=FALSE))

## OEM for CPUE
options$OEM =data.frame(omega=c(rep(1,2),.75),qTrend=c(0,.02,0))

save(options,file=file.path(dirRes,"options.RData"))


# Missing runs for resubmission
load(paste(dirRes,"/newScen.RData",  sep=""))
newScen=data.frame(iOM=21,newScen)[,c(2,1,3:8)]
newScen=data.frame(newScen,options$OEM[c(rep(1,16),rep(2,16),rep(3,16)),])
names(newScen)[3]="iSA"
newScen=data.frame(newScen,iHCR=1:4)[,c(1:3,11,4:10)]
oldScen=data.frame(Var1=rep(1:16,8),Var2=rep(1:8,each=16))
oldScen=cbind(newScen[oldScen$Var1,-c(1:2,9)],options$OM[2:9,][oldScen$Var2,])
names(oldScen)[9]="iOM"
oldScen=oldScen[,c("iOM","iSA","iHCR","ftar","blim","btrig","qTrend","omega","ar")]

start=50; end=100; interval=3; rcvPeriod=3
nits =100; seed=7890 

set.seed(seed)
srDev=FLQuants("0"=exp(lh:::noise(nits, FLQuant(0,dimnames=list(year=1:(end+interval))),
                                  b=0,sd=.3)))

set.seed(seed)
srDev[["0.5"]]   =exp(lh:::noise(nits, FLQuant(0,dimnames=list(year=1:(end+interval))),
                                 b=0.3,sd=0.5))

uDev   =rlnorm(nits,FLQuant(0,dimnames=list(year=1:end)),0.3)

##OM with perfect management
mou=FLStocks(mlply(options$OM, function(i,ar)
  biodyn:::proj(OMs[[i]],BRPs[[i]],srDev[[ac(ar)]])))

save(mou,file=paste(dirRes,"mou.RData",sep="/"))

#dataPoorMSE=function(om,eql,srD,pr,
#                      start=50, end =100,interval=3,
#                      nits =100,seed=7890,
#                      uCV=0.3,
#                      omega =1,
#                      trendQ=FLQuant(1,dimnames=list(year=1:end)),
#                      db=NULL){

oms=list()
m_ply(oldScen[128-(15:0),],function(iOM,iSA,iHCR,ftar,blim,btrig,p,ar,omega,qTrend){
  
  tag=paste(iOM,ar,ftar)
  
  start=50; end=100; interval=3; rcvPeriod=3
  nits =100; seed=7890 
  
  eql=BRPs[[iOM]]
  srD=srDev[[ac(ar)]]
  
  #### OM
  if (tag%in%names(oms)){
    om=oms[[tag]]
  }else{
    om =OMs[[iOM]]
    if (dims(om)$maxyear < end+interval)
      om =fwdWindow(om,end=end+interval,eql)
    
    ## F in recovery period
    rcv.=seq(c(fbar(om)[,ac(start)]),c(FLBRP:::refpts(eql)["msy","harvest"])*ftar,length.out=rcvPeriod+1)
    rcv =FLQuant(rcv.,dimnames=dimnames(fbar(om)[,ac(start+0:rcvPeriod)]))
    om  =FLash:::fwd(om,f=rcv, sr=eql)
    
    ## F in longterm
    lgt =propagate(FLQuant(rcv.[rcvPeriod+1],dimnames=list(year=(start+rcvPeriod+1):(end+interval))),nits)
    om  =propagate(om,nits)
    om  =FLash:::fwd(om,f=lgt, sr=eql)
    
    ## Add stochastcity
    om =FLash:::fwd(om,f =rlnorm(nits,log(fbar(FLCore:::iter(om,1))[,ac(2:(end+interval))]),0.1),
                    sr=eql,
                    sr.residuals=srD)
    oms[[tag]]=om
  }
  
  ## save projection for comparison later
  mou=om
  trendQ=FLQuant(c(rep(1,start-1),cumprod(rep(1+qTrend,end-start+1))),
                 dimnames=list(year=1:end))
  
  #### MP
  ## SA Control
  ctrl=with(priors[iSA,],biodyn:::controlFn(r=r,k=k,p=p,b0=b0))
  if (options$SA[ iSA, "p"]==1) ctrl["p","val"]=1
  
  ## SA Priors
  prArg=data.frame(a=unlist(c(priors[iOM,])),b=unlist(c(priors[iOM,]))*0.5,weight=1)
  prArg=alply(prArg,1,cbind)
  names(prArg)=names(priors[iOM,-1])
  prs=do.call(priorFn,prArg[options$SA[iSA,2]])
  
  #### MSE
  res=do.call(mseBiodyn,
              list(om,eql=eql,srDev=srD,
                   control=ctrl,priors=prs,
                   start=start+rcvPeriod,end=end,interval=3,
                   ftar=ftar,blim=blim,btrig=btrig,
                   uDev  =uDev,
                   trendQ=trendQ,
                   omega =omega,
                   maxF  =1,
                   bndTac=c(0.8,1.2),                 
                   refB=FLBRP:::refpts(eql)["msy","biomass"]))
  
  #### Save results
  drv=dbDriver("SQLite")
  con=dbConnect(drv, dbname=db)
  
  mou=cbind(OM=iOM,SA=iSA,HCR=iHCR,omega=omega,qTrend=qTrend,biodyn:::tseries(res$mou,eql))
  om =cbind(OM=iOM,SA=iSA,HCR=iHCR,omega=omega,qTrend=qTrend,biodyn:::tseries(res$om, eql))
  mp =cbind(OM=iOM,SA=iSA,HCR=iHCR,omega=omega,qTrend=qTrend,res$mp)
  #oem=cbind(OM=iOM,SA=iSA,HCR=iHCR,model.frame(res$oem,drop=T))
  
  dbWriteTable(con, "mou", mou,append=TRUE)
  dbWriteTable(con, "om",  om, append=TRUE)
  dbWriteTable(con, "mp",  mp, append=TRUE)
  #dbWriteTable(con, "oem", oem,append=TRUE)
  
  dbDisconnect(con)})

drv=dbDriver("SQLite")
con=dbConnect(drv, dbname=db)
om =dbReadTable(con, "om")

db2="/home/laurie/Desktop/MEGA/papers/submitted/tuna-mse/resubmission/data/non21.db"
db3="/home/laurie/Desktop/MEGA/papers/submitted/tuna-mse/data/breakIt"
db4="/home/laurie/Desktop/MEGA/papers/submitted/tuna-mse/data/breakIt2"
db5="/home/laurie/Desktop/MEGA/papers/submitted/tuna-mse/data/breakIt6"

con2=dbConnect(drv, dbname=db2)
con3=dbConnect(drv, dbname=db3)
con4=dbConnect(drv, dbname=db4)
con5=dbConnect(drv, dbname=db5)

om2=dbReadTable(con2, "om")
om3=dbReadTable(con2, "om")
om4=dbReadTable(con2, "om")
om5=dbReadTable(con2, "om")
om=rbind(om2,om3,om4,om5)

ggplot(subset(om,year>55))+
  geom_boxplot(aes(x=factor(year),y=harvest))+
  facet_grid(HCR~SA)

ggplot(subset(om2,year>55&OM==5))+
  geom_boxplot(aes(x=factor(year),y=harvest))+
  facet_grid(HCR~SA)

ggplot(bc)+
  geom_boxplot(aes(x=factor(year),y=ssb))

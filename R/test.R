dirMy ="/home/laurence/Desktop/sea++/xval"
dirDat=file.path(dirMy,"data")
dirVpa=file.path(dirMy,"inputs/vpa")
dirTex=file.path(dirMy,"tex")

library(plyr)
library(dplyr)
library(reshape2)
library(ggplot2)
library(ggplotFL)
library(FLCore)
library(diags)
library(stringr)

source('~/Desktop/flr/diags/R/io.VPA2BoxV2.R')
source('~/Desktop/flr/diags/R/jackknife-vpa2box.R')
source('~/Desktop/flr/diags/R/read-VPA2Box-FLIndices.R')
source('~/Desktop/flr/diags/R/diags-2box.R')

nms       =c("FR_AER1","FR_AER2","JPN_LL1_NEA","JPN_LL2_NEA","JPN_LL_EastMed","MOR_POR_TP","MOR_SP_TP","SP_BB1","SP_BB2","WMED_LARV")
names(nms)=c("AS1",     "AS2",   "JPLL_EM",    "JPLL_NEA",   "LJPLL_NEA2",    "MOR1",      "MOR2",     "SpBB1", "SPBB2", "LS")
m=c(0.3800,0.3000,0.2400,0.2000,0.1800,0.1600,0.1400,0.1300,0.1200,0.1000)

dirs=c(file.path(dirVpa,"ebft/sims"),
       file.path(dirVpa,"ebft/sims/2016"),
       file.path(dirVpa,"ebft/sims/2015"),
       file.path(dirVpa,"ebft/sims/2014"),
       file.path(dirVpa,"ebft/sims/2013"),
       file.path(dirVpa,"ebft/sims/2012"),
       file.path(dirVpa,"ebft/sims/2011"))

#jkVpas[["2017"]]=perr.vpa2box(xfls[[1]],m=m)
file=xfls[2]

# tmp <- tempfile()
# sink(file=tmp)
# on.exit(sink(file=NULL))
# on.exit(file.remove(tmp),add=TRUE)

dirTmp= tempdir() 

path=getPath(file)
ctl =getFile(file)
where=getwd()
setwd(getPath(file))
fls =vpa2boxFiles(file)

#so can replace latter
dFl=paste(fls[1],"_",sep="")
file.copy(fls[1],dFl)

d  =scan(dFl,sep="\n",what=as.character("a"),quiet=TRUE)
ln =seq(length(d))[substr(d,1,2)=="-1"]
d1 =d[1:(ln[2])]
idx=d[(ln[2]+1):(ln[3])]
idx=idx[substr(idx,1,1)!="#"]
d2 =d[(ln[3]+1):length(d)][substr(idx,1,1)!="#"]

system(paste("wine vpa-2box.exe", ctl, ">tmp.txt"))
saveNF(   0,fls[5],dirTmp)
saveQ(    0,fls[3],dirTmp)

m_ply(data.frame(i=seq(length(idx)-1)), 
      function(i){
        cat(d1,     file=fls[1],sep="\n")
        cat(idx[-i],file=fls[1],sep="\n",append=TRUE)
        cat(d2,     file=fls[1],sep="\n",append=TRUE)
        system(paste("wine vpa-2box.exe", ctl, ">tmp.txt"))
        saveNF(   i,file.path(path,fls[5]),dirTmp)
        saveQ(    i,file.path(path,fls[3]),dirTmp)
      })

#file.remove(fls[1])
#file.copy(dFl,fls[1])
# file.remove(dFl)

yf=as.data.frame(maply(idx[-length(idx)],function(x) as.numeric(unlist(strsplit(x,"\t"))[1:2])))
names(yf)=c("name","year")
yf=rbind(data.frame(name=0,year=0),yf)
dimnames(yf)[[1]]=c(0,seq(dim(yf)[1]-1))

n  =read.table(file.path(dirTmp,"n.txt"))
n  =as.FLQuant(transmute(melt(n,id=c("V1","V2")),age=as.numeric(variable),data=value,year=V2,iter=V1))
f  =read.table(file.path(dirTmp,"f.txt"))
f  =as.FLQuant(transmute(melt(f,id=c("V1","V2")),age=as.numeric(variable),data=value,year=V2,iter=V1))

## catchability by fleet for leave-one-out point
nms=getFLindexNames(fls[1])
q  =read.table(file.path(dirTmp,"q.txt"))
names(q)=c("iter","name","q")
q  =subset(q,iter!=0)

## observations by fleet and year
obs=ldply(idx[-length(idx)],function(x) t(unlist(strsplit(x,"\t"))[1:2]))
names(obs)=c("index","year")
obs=transform(obs,name=nms[as.integer(ac(index))])
obs=cbind(obs,iter=seq(dim(obs)[1]))[,-1]

obs$name=ac(obs$name)
q$name=ac(q$name)

q=merge(obs,q,by=c("name","iter"))
q=q[order(as.integer(q$iter)),]
dimnames(q)[[1]]=q$iter
q$name=ac(q$name)

stk=readVPA2Box(file,m=m)

stock.n(stk)=n
harvest(stk)=f
units(harvest(stk))="f"

attributes(stk)[["iter.key"]]=yf[-1]

rf1=stk
stock.n(rf1)=stock.n(iter(stk,1))
harvest(rf1)=harvest(iter(stk,1))
dimnames(stock.n(rf1))$iter=1
dimnames(harvest(rf1))$iter=1

rfs=stk
rfs@stock.n=stock.n(iter(rfs,-1))
rfs@harvest=harvest(iter(rfs,-1))

setwd(where)

file.remove(file.path(dirTmp,"n.txt"))
file.remove(file.path(dirTmp,"f.txt"))
file.remove(file.path(dirTmp,"q.txt"))
file.remove(dirTmp)

press=list(stock=FLStocks("fit"=rf1,"jackknife"=rfs),"q"=q[,c("iter","name","year","q")])

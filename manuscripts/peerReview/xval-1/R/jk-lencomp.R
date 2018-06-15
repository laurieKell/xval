source('~/Desktop/flr/diags/R/tmpDir.R')

library(doParallel)
library(foreach)

registerDoParallel(4)

x="/home/laurence/Desktop/sea++/cie/greySnapper/inputs/jackknife/gray_snapper_dat.ss"

## process file


  dirNow=getwd()

  #get rid of comments in data file
  dfl =str_trim(scan(x,sep="\n",what=as.character()))
  dfl=dfl[substr(dfl,1,1)!="#"]
  dfl=dfl[nchar(dfl)!=0]

  # work out which rows data are in
  rw<-function(x) as.numeric(strsplit(x,"\\s")[[1]][1])
  
  nFlt=rw(dfl[6])
  nSry=rw(dfl[7])
  
  rCtc=seq(rw(dfl[17]))+17
  rU  =max(rwCtc)+1+nFlt+nSry+seq(rw(dfl[max(rwCtc)+1]))

  nDsc=rw(dfl[max(rwU)+1])
  rDsc=max(rU)+nDsc+(3):(nDsc+2+rw(dfl[max(rU)+2]))

  rLnc=max(rDsc)+9+seq(rw(dfl[max(rDsc)+9]))
  rLnc=(rLnc)[substr(dfl[rLnc],1,1)!="-"]
 
  key=NULL
  cnf=NULL
  ldb=NULL
  
  jkCNW<-foreach(i=rwLnc, 
               .combine=rbind,
               .multicombine=TRUE,
               .packages=c("FLCore")) %dopar%{
                 
    dirTmp=mkTmp()
    setwd(dirTmp)
                 
    dir=dirname(x)
    dat=substr(x,nchar(dir)+2,nchar(x))
                 
    system(paste("cp",file.path(dir,"*.*"),dirTmp))
                 
    source('~/Desktop/flr/ss3om/R/readSS3.R', echo=TRUE)
    source('~/Desktop/flr/ss3om/R/utilities.R', echo=TRUE)

    #leave out row
    t=dfl
    t[i]=paste("-",t[i],sep="")
    cat(t,sep="\n",file=file.path(dirTmp,dat))
  
    #run
    system2("./ss3_3.24z",args="-nohess",stdout=NULL)
  
    #get results
    res=try(SS_output(dirTmp,verbose=FALSE,printstats=FALSE))

    #clean  
    setwd(dirNow)
    rmTmp(dirTmp)
    
    #save results
    #key
    key_=c(i-min(rwLnc)+1,strsplit(dfl[i],"\\s")[[1]])
    names(key_)=c(c("i","year","season","fleet","sex","part","nsamp"),
                  paste("l",strsplit(dfl[min(rwLnc)-2],"\\s")[[1]],sep=""))
    key=rbind(key,as.data.frame(t(key_)))

    #lencomp hat
    ldb_=cbind(i-min(rwLnc)+1,res$lendbase[,c("Yr","Seas","Fleet","sex","Part","N","Bin","Obs","Exp","Pearson","Like","Lbin_mid")])
    names(ldb_)=c("i","year","season","fleet","sex","part","n","bin","obs","hat","pearson","like","binmid")
    
    subset(ldb_,year==key_["year"]&season==key_["season"]&fleet==key_["fleet"]&sex==key_["sex"]&part==key_["part"])

    ldb=rbind(ldb,ldb_)

    #N,F,C
    cnf=rbind(cnf,cbind("i"=i-min(rwLnc)+1,as.data.frame(FLQuants(readFLSss3Fn(res),"catch.n","stock.n","harvest"))))
    
    i-min(rwLnc)+1
    
    rtn=cbind("i"=i-min(rwLnc)+1,
                    rbind(cbind(qname="catch.wt",res$wtatage[,c("Yr","Fleet",0:21)]),
                          cbind(qname="catch.n", res$catage[, c("Yr","Fleet",0:21)])))

    cnf}


  
      

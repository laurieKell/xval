library(FLCore)
library(Flash)
library(FLBRP)

library(downloader)

library(foreach)
library(doParallel)

cl <- makeCluster(4)
registerDoParallel(cl)

download("https://github.com/laurieKell/albn/blob/master/data","key.RData")
download("https://github.com/laurieKell/albn/blob/master/data","oms.RData")
download("https://github.com/laurieKell/albn/blob/master/data","eqls.RData")
download("https://github.com/laurieKell/albn/blob/master/data","srDevs.RData")

fn<-function(i)
      fwd(fwdWindow(oms[[i]],end=2040,eqls[[i]]),
         f=FLQuant(c(refpts(eqls[[i]])["msy","harvest"]),dimnames=list(year=2012:2040)),
         sr.residuals=exp(srDevs[[i]]),sr=eqls[[i]])

omsFmsy<-
  foreach(i=seq(240), .combine='FLStocks', .multicombine=TRUE, .packages=c("FLCore","FLBRP","FLash")) %dopar%  
     fn(i)                 
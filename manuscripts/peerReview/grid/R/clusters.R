library(FLCore)
library(FLRP)
library(FLife)
library(plyr)
library(popbio)

source('~/Desktop/flr/FLife/R/refs.R')

##albio
load("/media/laurence/Seagate Backup Plus Drive/xfiles/oms/albio/om.RData")
rfs=refs(om)
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/albio/rfs.RData",compress="xz")

##albna
load("/media/laurence/Seagate Backup Plus Drive/xfiles/oms/albna/om.RData")
rfs=refs(window(om,start=1950))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/albna/rfs.RData",compress="xz")

##bfta
load("/media/laurence/Seagate Backup Plus Drive/xfiles/oms/bfta/om.RData")
rfs=refs(iter(om,1:500))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/bfta/rfs.RData",compress="xz")
rfs=rbind(rfs,refs(iter(om,501:1000)))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/bfta/rfs.RData",compress="xz")
rfs=rbind(rfs,refs(iter(om,1001:1500)))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/bfta/rfs.RData",compress="xz")
rfs=rbind(rfs,refs(iter(om,1501:2000)))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/bfta/rfs.RData",compress="xz")
rfs=rbind(rfs,refs(iter(om,2001:2196)))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/bfta/rfs.RData",compress="xz")

save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/bfta/rfs.RData",compress="xz")

##swon
load("/media/laurence/Seagate Backup Plus Drive/xfiles/oms/swon/om.RData")
rfs=refs(simplify(swon[,,,,,!is.na(c(rec(swon)[,"1951",2]))]))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/swon/rfs.RData",compress="xz")

##swoio
load("/media/laurence/Seagate Backup Plus Drive/xfiles/oms/swoio/om.RData")
rfs=refs(swoio)
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/swoio/rfs.RData",compress="xz")


rfs=transform(model.frame(rfs)[,-55],
              s=s.current/s.msy,
              f=f.current/f.msy,
              sh=s.msy/s.virgin,
              v=s.current/s.virgin)

cr=model.frame(rfs)[c("f.msy","s.msy","y.msy",
                      "r","sh",
                      "f.current","s.current","r.current",
                      "s","f","v")]

corrplot.mixed(cor(cr),order="hclust")

plot(princomp(cr,cor=TRUE))
biplot(princomp(cr,cor=TRUE),choices=1:2)
biplot(princomp(cr,cor=TRUE),choices=2:3)



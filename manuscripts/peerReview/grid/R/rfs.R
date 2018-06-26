library(FLCore)
library(FLRP)
library(FLife)
library(plyr)
library(popbio)

source('~/Desktop/flr/FLife/R/refs.R')

##albna
load("/media/laurence/Seagate Backup Plus Drive/xfiles/oms/albna/om.RData")
rfs=refs(window(om,start=1950))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/albna/rfs.RData",compress="xz")

##albio
load("/media/laurence/Seagate Backup Plus Drive/xfiles/oms/albio/om.RData")
rfs=refs(iter(om,1:500))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/albio/rfs.RData",compress="xz")
rfs=cbind(rfs,refs(iter(om,501:655)))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/albio/rfs.RData",compress="xz")

##bfta
load("/media/laurence/Seagate Backup Plus Drive/xfiles/oms/bfta/om.RData")
rfs=refs(iter(om,1:500))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/bfta/rfs.RData",compress="xz")
rfs=cbind(rfs,refs(iter(om,501:1000)))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/bfta/rfs.RData",compress="xz")
rfs=cbind(rfs,refs(iter(om,1001:1500)))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/bfta/rfs.RData",compress="xz")
rfs=cbind(rfs,refs(iter(om,1501:2000)))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/bfta/rfs.RData",compress="xz")
rfs=cbind(rfs,refs(iter(om,2001:2196)))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/bfta/rfs.RData",compress="xz")

##swon
load("/media/laurence/Seagate Backup Plus Drive/xfiles/oms/swon/om.RData")
rfs=refs(simplify(om[,,,,,!is.na(c(rec(om)[,"1951",2]))]))
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/swon/rfs.RData",compress="xz")


##swoio
load("/media/laurence/Seagate Backup Plus Drive/xfiles/oms/swoio/om.RData")
om=iter(om,seq(1003)[!c(is.na(rec(om)[,"1965"]))])
rf1=refs(iter(om,1:500))
rf2=refs(iter(om,501:1002))
rfs=cbind(rf1,rf2)
save(rfs,file="/media/laurence/Seagate Backup Plus Drive/xfiles/oms/swoio/rfs.RData",compress="xz")



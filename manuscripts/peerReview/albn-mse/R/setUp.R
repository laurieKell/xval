library(FLCore)
library(ggplotFL)
library(FLash)
library(FLBRP)
library(mpb)

dirDat="/home/laurence/Desktop/sea++/xval/manuscripts/peerReview/albn-mse/data"

##Data sets
# The design grid for all interactions to set up FLBRP
# FLBRPs and FLStocks based on design
load(file.path(dirDat,"om2040.RData"))
load(file.path(dirDat,"eqls.RData"))
load(file.path(dirDat,"saMfcl.RData"))
load(file.path(dirDat,"srDev.RData"))

load(file.path(dirDat,"saa.RData"))
saa=subset(saa,qname%in%unique(saa$qname)[c(1,7,10,12)])

load(file.path(dirDat,"dgs.RData"))  
ddply(dgs,.(name),with,round(min(time)))[c(1,7,10,12),]

load(file.path(dirDat,"dgs-bd.RData"))  
ddply(dgs,.(name),with, var(residual,na.rm=T)^0.5)

set.seed(12346)
uDevs=FLQuants(mlply(c(1981,1976,1999,1978), function(x) rlnorm(1000,FLQuant(0,dimnames=list(year=x:2040)),0.3)))

mp =sa80mfcl
om =om2040
eql=eqls

save(om,eql,mp,srDevs,uDevs,saa,file=file.path(dirDat,"setUp.RData"),compress="xz")

## Fmsy projection
ref=mlply(seq(length(om2040))[1], function(i) 
  fwd(om2040[[1]],f =FLQuant(c(fmsy(eqls[[i]])),dimnames=list(year=2012:2040)),
      sr=eqls[[i]],sr.residuals=exp(srDevs[[i]])))

plot(ref[[1]])
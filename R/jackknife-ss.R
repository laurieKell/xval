# JN.R - DESC
# bftatlmse/jackknife/JN.R

# Copyright European Union, 2017
# Author: Iago Mosqueira (EC JRC) <iago.mosqueira@ec.europa.eu>
#
# Distributed under the terms of the European Union Public Licence (EUPL) V.1.1.


library(bftatlmse)
library(r4ss)
library(doParallel)

registerDoParallel(225)

# LOAD files (change dir/filename as needed)
dat <- r4ss::SS_readdat('sa/simple3.dat', verbose=FALSE)
ctl <- r4ss::SS_readctl_3.24('sa/simple3.ctl', use_datlist=T, datlist=dat, verbose=FALSE)

rows <- seq(dim(dat$CPUE)[1])

# DELETE dropped CPUE data points
r1 <- rows[dat$CPUE$year > 0]

# DROP index in LAMBDA multipliers if value = 0 when like_comp = 1
if(nrow(ctl$lambdas) > 0) {
  r2 <- rows[!dat$CPUE$index %in%
               ctl$lambdas[ctl$lambdas$value == 0 & ctl$lambdas$like_comp == 1, "fleet/survey"]]
}

# MERGE
rows <- rows[rows %in% r1 & rows %in% r2]

cpues <- foreach (i=rows, .errorhandling = "remove") %dopar% {
  
  # COPY run folder
  ndir <- paste0("jn/run", i)
  dir.create(ndir)
  
  # COPY files
  file.copy("sa/simple3.ctl", paste0(ndir, "/simple3.ctl"))
  file.copy("sa/forecast.ss", paste0(ndir, "/forecast.ss"))
  file.copy("sa/starter.ss", paste0(ndir, "/starter.ss"))
  file.copy("sa/ss3.par", paste0(ndir, "/ss3.par"))
  
  # DELETE cpue row in dat
  dat$CPUE[i, "index"]  <- - dat$CPUE[i, "index"]
  
  r4ss::SS_writedat(dat, outfile=paste0(ndir, "/simple3.dat"), overwrite=TRUE)
  
  setwd(ndir)
  
  system("ss3 -nohess")
  
  setwd("../")
  
  out <- r4ss::SS_output(ndir, verbose=FALSE, hidewarn=TRUE, warn=FALSE,
                         printstats=FALSE, covar=FALSE,
                         forecast=FALSE)$cpue[, c("Fleet", "Name", "Yr", "Seas", "Obs", "Exp", "Use")]
  out
}

# MERGE cpues

cpues <- rbindlist(lapply(cpues, data.table), idcol="iter")

# LOAD JK

jk <- loadom(dirs=paste0('jn/run', rows))
resjk <- loadres(dirs=paste0('jn/run', rows))

# LOAD SA CPUE

sacpue <- r4ss::SS_output('sa', verbose=FALSE, hidewarn=TRUE, warn=FALSE,
                          printstats=FALSE, covar=FALSE,
                          forecast=FALSE)$cpue[, c("Fleet", "Name", "Yr", "Seas", "Obs", "Exp", "Use")]

save(jk, resjk, cpues, sacpue, file="jk_atl_bftSS3.RData")

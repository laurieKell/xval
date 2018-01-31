# JN.R - DESC
# bftatlmse/jackknife/JN.R

# Copyright European Union, 2017
# Author: Iago Mosqueira (EC JRC) <iago.mosqueira@ec.europa.eu>
#
# Distributed under the terms of the European Union Public Licence (EUPL) V.1.1.

library(r4ss)
library(data.table)
library(ss3om)

library(doParallel)
registerDoParallel(225)

# LOAD files - CHANGE dir/filenames as needed
dat <- r4ss::SS_readdat('run82/complex.dat', verbose=FALSE)
ctl <- ss3om::SS_readctl_3.24('run82/complex.ctl', use_datlist=T, datlist=dat, verbose=FALSE)

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
  file.copy("run82/complex.ctl", paste0(ndir, "/complex.ctl"))
  file.copy("run82/forecast.ss", paste0(ndir, "/forecast.ss"))
  file.copy("run82/starter.ss", paste0(ndir, "/starter.ss"))
  file.copy("run82/ss3.par", paste0(ndir, "/ss3.par"))

  # DELETE cpue row in dat
  dat$CPUE[i, "index"]  <- - dat$CPUE[i, "index"]

  r4ss::SS_writedat_3.24(dat, outfile=paste0(ndir, "/complex.dat"), overwrite=TRUE)

  setwd(ndir)

  system("ss3 -nohess")
  
  # PACK run
  packss3run(ndir)

  setwd("../")

  out <- r4ss::SS_output(ndir, verbose=FALSE, hidewarn=TRUE, warn=FALSE,
    printstats=FALSE, covar=FALSE, repfile="Report.sso.gz",
    compfile="CompReport.sso.gz", wtfile = "wtatage.ss_new.gz",
    forecast=FALSE)$cpue[, c("Fleet", "Name", "Yr", "Seas", "Obs", "Exp", "Use")]

  out
}

# CHECK out
length(cpues)

# MERGE cpues
cpues <- rbindlist(lapply(cpues, data.table), idcol="iter")

# LOAD JK
jk <- loadom(dir='jn', repfile="Report.sso.gz",
  compfile="CompReport.sso.gz", wtfile = "wtatage.ss_new.gz")
resjk <- loadres(dir='jn', repfile="Report.sso.gz", covarfile="covar.sso.gz")

# LOAD SA CPUE
sacpue <- r4ss::SS_output('run82', verbose=FALSE, hidewarn=TRUE, warn=FALSE,
    printstats=FALSE, covar=FALSE,
    forecast=FALSE)$cpue[, c("Fleet", "Name", "Yr", "Seas", "Obs", "Exp", "Use")]

# SAVE results
#   jk: Jackknifed FLStock
#   resjk: Jackknifed results, data.frame
#   cpues: Input CPUEs, data.table
#   sacpue: Base run CPUE

save(jk, resjk, cpues, sacpue, file="jk_atl_bftSS3.RData", compress="xz")


# ---

#Stats Computed for fits
###Jacknife fits

cpues$ss <- ((cpues$Obs - cpues$Exp)^2) * ifelse(cpues$Use == -1, 1, 0)
sum(cpues$ss, na.rm=TRUE)
var(cpues$ss, na.rm=TRUE)
sum(cpues$ss, na.rm=TRUE) / (max(cpues$iter, na.rm=TRUE) - 1)

####Fitted Model
rsacpue <- sacpue[!sacpue$Name %in% "SpBB",]
rsacpue$ss <- ((rsacpue$Obs - rsacpue$Exp)^2)
sum(rsacpue$ss, na.rm=TRUE) / (max(cpues$iter, na.rm=TRUE) - 1)

####Bias
names(cpues)
setwd("E:/BFTMSEICCATIAGO")
outfile  <- "jkBFT3.csv"
output2 = cpues
write.table(output2, file = outfile, append = TRUE, sep = ",", dec = ".", row.names = FALSE, col.names = FALSE)
outfile2<-"baseruncpue3.csv"
output2=sacpue
write.table(output2, file = outfile2, append = TRUE, sep = ",", dec = ".", row.names = FALSE, col.names = TRUE)

###plots of observed vs fitted
par(mfrow=c(1,2))
plot(rsacpue$Exp,(rsacpue$Obs - rsacpue$Exp),main="Assessment Model",xlab="Predicted",ylab="Error")
abline(h=0) 
cpuesplotjk<- cpues[!cpues$Use ==1,]
plot(cpuesplotjk$Exp,(cpuesplotjk$Obs - cpuesplotjk$Exp),main="Jacknife Model",xlab="predicted",ylab="Error")
abline(h=0)
 length(cpuesplotjk)
 
##Summary Plots
library(ggplotFL)
ggplot(ssb(jk), aes(date, data, colour=iter))+ geom_line()
ggplot(ssb(jk), aes(date, data, colour=iter))+ geom_line() + theme(legend.position="none")
res2<-resjk[!is.na(resjk$SSB_MSY),]
res2<-res2[!is.na(resjk$SPB_2015),]
idx <- res2$Convergence_Level < .001
ggplot(ssb(jk)[idx], aes(date, data, colour=iter))+ geom_line() + theme(legend.position="none")
ggplot(ssb(jk)[,,,,,idx], aes(date, data, colour=iter))+ geom_line()+theme(legend.position="none")

plot(jk)
###Problem for number of runs....Bug in code somewhere in jk
runno<-c(1:177)
#runno<-c(1:162)
resjk<-cbind(runno,res2)
attach(resjk)

par(mfrow=c(2,2))
plot(runno,TotBio_Unfished, ylim=c(0,max(TotBio_Unfished)), xlab="Run", ylab="Bzero")
plot(runno,SPB_1950, ylim=c(0,max(SPB_1950)), xlab="Run", ylab="Sp Bio 1950")
plot(runno,SPB_2015/SSB_MSY, ylim=c(0,max(SPB_2015/SSB_MSY)), xlab="Run", ylab="SPB_2015/SPB_MSY")
plot(runno,F_2015, ylim=c(0,max(F_2015)), xlab="Run", ylab="F_2015")



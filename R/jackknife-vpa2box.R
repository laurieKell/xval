skip.hash<-function(i,file){
  i <- i+1
  while (substr(scan(file,skip=i,nlines=1,what=("character"),quiet=TRUE)[1],1,1)=="#")
    i <- i+1
  
  return(i)}

skip.until.hash<-function(i,file){
  i <- i+1
  while (substr(scan(file,skip=i,nlines=1,what=("character"),quiet=TRUE)[1],1,1)!="#")
    i <- i+1
  
  return(i)
}

vpa2boxFiles<-function(file,print=FALSE){
  i <- skip.hash(0,file)
  j <- skip.until.hash(i,file)
  
  res <- gsub(" ","",gsub("'","",substr(scan(file,skip=i+1,nlines=j-i-1,
                                             quiet=TRUE,what=character(),sep="\n"),1,20)))
  
  if (print)  print(res)
  
  return(res)}

getPath <- function(file) {
  if (!grepl(.Platform$file.sep,file))
    res <- getwd()
  else
    res <- substr(file,1,max(gregexpr(.Platform$file.sep,file)[[1]])-1)
  return(res)}

getFile <- function(file) {
  res <- substr(file,max(gregexpr(.Platform$file.sep,file)[[1]])+1,
                nchar(file))
  return(res)}

saveNF<-function(i,spd,dir){
  tmp=str_trim(scan(spd,sep="\n",what=as.character("t")))
  spc=seq(length(tmp))[nchar(tmp)==0]
  F  =seq(length(tmp))[substr(tmp,1,1)=="F"]
  N  =seq(length(tmp))[substr(tmp,1,1)=="N"]
  
  N=read.table(spd,skip=N,nrows=spc[spc>N][1]-N-1)
  names(N)=c("year",0:5)
  F=read.table(spd,skip=F,nrows=spc[spc>F][1]-F-1)
  names(F)=c("year",0:5)
  
  write.table(cbind(iter=i,N),file=file.path(dir,"n.txt"),append=TRUE,row.names=FALSE,col.names=FALSE)
  write.table(cbind(iter=i,F),file=file.path(dir,"f.txt"),append=TRUE,row.names=FALSE,col.names=FALSE)   }

saveQ<-function(i,dgs,dir){
  res=diags.vpa2box(dgs)
  res=res[!duplicated(res$name),c("name","q")]
  
  write.table(cbind(iter=i,res),file=file.path(dir,"q.txt"),append=TRUE,row.names=FALSE,col.names=FALSE)
  }

saveDiags<-function(i,dgs,dir){
  res=diags.vpa2box(dgs)
  
  write.table(cbind(iter=i,res),file=file.path(dir,"diags.txt"),append=TRUE,row.names=FALSE,col.names=FALSE)
  }

jackknife.vpa2box<-function(file,m=0.2){
  
  sink("/dev/null")
  
  path=getPath(file)
  ctl =getFile(file)
  where=getwd()
  setwd(getPath(file))
  fls =vpa2boxFiles(file)
  
  #so can replace latter
  dFl=paste(fls[1],"_",sep="")
  file.copy(fls[1],dFl)
  
  ids=readVPA2BoxIndices(fls[1])
  
  ## index for observations
  obs=ldply(idx[-length(idx)],function(x) t(unlist(strsplit(x,"\t"))[1:2]))
  names(obs)=c("index","year")
  obs=cbind(iter=seq(dim(obs)[1]),obs)
  obs=transform(obs,name=unique(q$name)[index])
  
  d  =scan(dFl,sep="\n",what=as.character("a"))
  ln =seq(length(d))[substr(d,1,2)=="-1"]
  d1 =d[1:ln[2]]
  idx=d[(ln[2]+1):ln[3]]
  idx=idx[substr(idx,1,1)!="#"]
  d2 =d[(ln[3]+1):length(d)][substr(idx,1,1)!="#"]
  
  dirTmp= tempdir() 
  system(paste("wine vpa-2box.exe", ctl))
  saveNF(   0,fls[5],dirTmp)
  saveQ(    0,fls[3],dirTmp)
  
  m_ply(data.frame(i=seq(length(idx)-1)), function(i){
    cat(d1,     file=fls[1],sep="\n")
    cat(idx[-i],file=fls[1],sep="\n",append=TRUE)
    cat(d2,     file=fls[1],sep="\n",append=TRUE)
    system(paste("wine vpa-2box.exe", ctl))
    saveNF(   i,file.path(path,fls[5]),dirTmp)
    saveQ(    i,file.path(path,fls[3]),dirTmp)
    })
  
  nms=c("error","iter",names(diags.vpa2box(file.path(path,fls[3]))))
  
  file.remove(fls[1])
  file.copy(dFl,fls[1])
  file.remove(dFl)
  
  yf=as.data.frame(maply(idx[-length(idx)],function(x) as.numeric(unlist(strsplit(x,"\t"))[1:2])))
  names(yf)=c("name","year")
  yf=rbind(data.frame(name=0,year=0),yf)
  dimnames(yf)[[1]]=c(0,seq(dim(yf)[1]-1))
  
  n  =read.table(file.path(dirTmp,"n.txt"))
  n  =as.FLQuant(transmute(melt(n,id=c("V1","V2")),age=as.numeric(variable),data=value,year=V2,iter=V1))
  f  =read.table(file.path(dirTmp,"f.txt"))
  f  =as.FLQuant(transmute(melt(f,id=c("V1","V2")),age=as.numeric(variable),data=value,year=V2,iter=V1))

  ## index for observations
  obs=ldply(idx[-length(idx)],function(x) t(unlist(strsplit(x,"\t"))[1:2]))
  names(obs)=c("index","year")
  obs=cbind(iter=seq(dim(obs)[1]),obs)
  obs=transform(obs,name=unique(q$name)[index])[,-2]
 
  q  =read.table(file.path(dirTmp,"q.txt"))
  names(q)=c("iter","name","q")
  q=subset(q,iter!=0)
  q=merge(obs,q)
  q=q[order(q$iter),]

  file.remove(file.path(dirTmp,"n.txt"))
  file.remove(file.path(dirTmp,"f.txt"))
  file.remove(file.path(dirTmp,"q.txt"))
  file.remove(dirTmp)
  
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
  
  sink(NULL)
 
  return(list(stock=FLStocks("fit"=rf1,"jackknife"=rfs),q=q))}


run.vpa2box<-function(file,m=0.2){
  
  sink("/dev/null")
  
  path =getPath(file)
  ctl  =getFile(file)
  where=getwd()
  setwd(getPath(file))
  
  dirTmp= tempdir() 
  system(paste("wine vpa-2box.exe", ctl))
  res=readVPA2Box(file,m=m)
              
  setwd(where)
  
  sink(NULL)
  
  return(res)}



library(stringr)

dirBase="/home/laurence/Desktop/sea++/xval/inputs/ss/run59/base"
dirAspm="/home/laurence/Desktop/sea++/xval/inputs/ss/run59/aspm"

# base case selectivity parameters
parBase=scan(file.path(dirBase,"ss3_3.24z.par"),sep="\n",what=as.character())
parSel =parBase[seq(length(parBase))[substr(parBase,1,5)=="# sel"]+1][-90]

# ASPM control file
ctlAspm=str_trim(tolower(scan(file.path(dirBase,"complex.ctl"), sep="\n",what=as.character())))

# Postition of parameters 
pos=seq(length(ctlAspm))[substr(ctlAspm,1,5)=="# sel"]

selBase=(pos:length(ctlAspm))[substr(ctlAspm[pos:length(ctlAspm)],1,1)!="#"][seq(length(parSel))]

for (i in seq(length(selBase)-1)){
  tmp=strsplit(ctlAspm[selBase[i]]," +")[[1]]
  if (as.numeric(tmp[7])>0) tmp[7]=0
  tmp[3]=parSel[i]
  
  ctlAspm[selBase[i]]=paste(tmp,sep=" ",collapse=" ")
}

write(ctlAspm,file=file.path(dirAspm,"complex.ctl"))

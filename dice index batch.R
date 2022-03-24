library(oro.nifti)
options(fsl.path="/path/to/fsl")
library(fslr)
options=(fsl.path="/Applications/fsl/")

x=read.csv("name.csv",header = F)
y=as.character(x$V1)
result=c()
for (i in y){
  a=paste("/media/lym/My Passport/TCGA-LGG/TCGA-LGG/TCIA-LGG-T2-Radiomic/",i,sep="") #modify the workspace
  setwd(a)
  
  #read mask
  T2U=readNIfTI('T2U2.nii.gz',reorient = F)
  FlairU=readNIfTI('T2U3.nii.gz',reorient = F)
  a=sum(T2U)
  b=sum(FlairU)
  #overlap
  overlap=niftiarr(T2U,1)
  temp=T2U+FlairU
  is_in_mask=temp>1
  overlap[!is_in_mask]=0
  c=sum(overlap)
  dice=2*sum(overlap)/(sum(T2U)+sum(FlairU))
  d=c(i,a,b,c,dice)
  result=rbind(result,d)
  }

setwd("/media/lym/My Passport/TCGA-LGG/TCGA-LGG/TCIA-LGG-T2-Radiomic")
write.csv(result,file = "dice-T2-Flair.csv")

library(oro.nifti)
options(fsl.path="/path/to/fsl")
library(fslr)
options=(fsl.path="/Applications/fsl/")

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
print(dice)

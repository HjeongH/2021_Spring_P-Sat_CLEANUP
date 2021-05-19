###########################################
#### "선형대수학 클린업 3주차 코드(R)" ####
###########################################

#패키지 여는거부터 시작!===============================
library(tidyverse)
library(ISLR)
library(caret)
library(MLmetrics)
library(imager) 

# 주성분분석(PCA) =====================================

### 데이터불러오기!
data=mtcars
dim(data)
str(data)
sum(is.na(data)) #na는 없군

### pca ; scale을 해야 단위 차이가 없어짐
pca_dt <- prcomp(data,center = T, scale. = T) 

### pca summary
summary(pca_dt) #pc2부터도 80을 넘는군

### scree plot
screeplot(pca_dt, main = "", col = "green", type = "lines", pch = 1, npcs = length(pca_dt$sdev))

### 3차원으로 축소
PCA_df = as.matrix(data) %*% pca_dt$rotation[,1:3] 
dim(PCA_df) #32  3



# 특이값분석(SVD) ======================================

### 그림데이터를 불러오자
setwd("C:/Users/hjh05/Downloads")
im <- imager::load.image('picc.jpg') 

### 행렬화를 위해 흑백으로 변경
im <- grayscale(im) 
im.mat <- as.matrix(im) 

### 이미지확인
plot(im) 
save.image(im, 'im.jpg')

### svd모델링
svd <- svd(im.mat) 
str(svd)
svd$d #특이값확인

### 이미지 차원축소 : 저화질로 복원 
### 1. 특이값 50
U=svd$u[,1:50] 
D = diag(svd$d[1:50]) 
V = svd$v[,1:50] 
im_part = U%*%D%*%t(V) 
dim(im_part) 

im2 <- as.cimg(im_part) 
plot(im2) 
#save.image(im2, 'im2.jpg') 

### 2. 특이값 10
U=svd$u[,1:10] 
D = diag(svd$d[1:10]) 
V = svd$v[,1:10] 
im_part = U%*%D%*%t(V) 
im3 <- as.cimg(im_part) 
plot(im3)
#save.image(im3, 'im3.jpg')

### 3. 특이값 5
U=svd$u[,1:5] 
D = diag(svd$d[1:5]) 
V = svd$v[,1:5] 
im_part = U%*%D%*%t(V) 
im4 <- as.cimg(im_part) 

plot(im4)
#save.image(im4, 'im4.jpg')


# 잠재요인분석(LSA) ====================================

### 문서행렬만들기
library(quanteda)
txt <- c(d1 = "Shipment of gold damaged in a fire",
         d2 = "Delivery of silver arrived in a silver truck",
         d3 = "Shipment of gold arrived in a truck" )

mydfm <- dfm(txt)
mydfm

### lsa
library(quanteda.textmodels)
mylsa <- textmodel_lsa(mydfm)

### lsa 결과로 새로운 문장 처리하기
querydfm <- dfm(c("gold silver truck")) %>%
  dfm_match(features = featnames(mydfm))
querydfm

newq <- predict(mylsa, newdata = querydfm)
newq$docs_newspace[, 1:2]\
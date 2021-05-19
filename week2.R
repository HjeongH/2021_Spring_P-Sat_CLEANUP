###########################################
#### "선형대수학 클린업 2주차 코드(R)" ####
###########################################

# 행렬식 구하기=========================================
### 1~16까지 4x4 행렬을 만들고 det을 구해보자
x=matrix(1:16,nrow=4,byrow=T)
print(x)
det(x)

# 선형회귀모델 돌리기 ==================================
### Carseats 데이터를 이용해서 sales를 income,population, age, education으로 예측해보자!

### 일단 패키지 실행부터 시작!
library(tidyverse)
library(ISLR)
library(caret)
library(MLmetrics)

### 데이터 불러오기+확인
data=Carseats
data=data[,c(1,3,5,8,9)] #필요한 변수만 추출
head(data)
str(data)
sum(is.na(data)) #na는 없군

### 7:3으로 train, test 나누기
set.seed(1234)
n_index = createDataPartition(data$Sales, p=0.3)
train = data[-n_index$Resample1,]
test = data[n_index$Resample1,]


### 행렬계산으로 회귀계수를 구해보자!
x_tr = cbind(1,train[,-1]) %>% as.matrix
y_tr = train$Sales %>% as.matrix
b_hat=solve(t(x_tr) %*% x_tr) %*% t(x_tr) %*% y_tr
b_hat

### 잘 했나 확인해볼까?
#원래 회귀모델링은 train set의 x,y로 학습해서 trainset의 RMSE를 확인하지 않지만, 지금은 train의 x로만 계수를 찾았으니 train y를 이용해 정확도를 확인해보자
y_hat_tr = x_tr %*% b_hat
RMSE(y_hat_tr, y_tr) #2.70189

### train에 적용해보자
x_te = cbind(1,test[,-1]) %>% as.matrix
y_te = test$Sales %>% as.matrix

y_hat_te = x_te %*% b_hat
RMSE(y_hat_te, y_te) #2.746303

### 원래는 어떻게 회귀 모델링 하냐고?
model = lm(Sales~., data=train)

### 계수비교
model$coefficients
b_hat

### test RMSE끼리 비교
pred=predict(model, as.data.frame(x_te)) 
RMSE(pred, y_te) #2.746303


# Carseats의 Sales와 Age를 이용해 가중선형회귀도 돌려보자!
### train set만들기
x_tr=x_tr[1:5,c(1,4)]
y_tr=y_tr[1:5,]
w_mat = diag(c(2,2,2,1,1)) #가중치행렬
b_hat=solve(t(w_mat %*% x_tr) %*% (w_mat %*% x_tr)) %*% t(w_mat %*% x_tr) %*% (w_mat %*% y_tr)
b_hat
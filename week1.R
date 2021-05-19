#########################################
#### 선형대수학 클린업 1주차 코드(R) ####
#########################################

# 벡터뿌시기!==========================================

### 원소를 1,2,3으로 하는 벡터를 만들어 봅시다.
x1 = c(1,2,3)
print(x1)

### 원소를 1~9로 하는 벡터를 만들어 봅시다.
x2= 1:9
print(x2)

### 원소의 데이터 타입으로 a정수, b실수, c문자열을 부여해봅시다.
print(as.integer(x1)) #정수
print(as.numeric(x1)) #실수
print(as.character(x1)) #문자열

### 벡터의 type, 차원, 원소개수를 확인해봅시다.
print(x1)
print(typeof(x1)) #type
print(class(x1)) 
print(dim(x1)) #차원
print(length(x1)) #원소개수
print(str(x1)) #정보요약제시

### 논리 연산자를 이용해 필터링해 봅시다.
index=c(T,F,T)
print(x1[index])

### x2의 짝수 원소를 0으로 바꿔봅시다.
##짝수선택하기
print(x2[c(2,4,6,8)])
print(x2[x2%%2==0])
print(x2[c(F,T,F,T,F,T,F,T,F)])

#짝수 0으로 바꾸기
x2[c(2,4,6,8)]=0
print(x2)

### 벡터 연산을 해봅시다
print(x1)
x2=x1*3 #상수배
print(x2)
print(x1+x2) #크기가 같은 두 벡터의 합

### +조건으로 필터링해봅시다
print(x2)
print(x2[x2<5]) #5미만인 원소만 필터링
print(sum(x2==6)) #6인 원소 개수세기

# 행렬뿌시기!=========================================

### 원소를 1~12로 하는 3x4 행렬을 만들어 봅시다.
y1 = matrix(1:12, 3,4,byrow=T)
print(y1)

#### 행렬의 type, 차원차원, 원소개수를 확인해봅시다.
print(y1)
print(typeof(y1))
print(class(y1))
print(dim(y1))
print(length(y1))
print(str(y1))

### 논리연산자로 행렬을 필터링해봅시다.
print(y1)

#짝수 필터링 인덱스 만들기
idx=(y1%%2==0) #2로 나눴을때 나머지가 0
print(idx)
print(y1[idx])

### y1에서 3의 배수를 -10으로 바꿔봅시다.
print(y1)

idx2=(y1%%3==0) #3로 나눴을때 나머지가 0 == 3의배수
y1[idx2] = y1[idx2]-10
print(y1)

### 행렬 연산을 해봅시다.
y2 = matrix(1:4,2,2,byrow=T)
print(y2)

#스칼라배
y3=y2*3
print(y3)

#행렬합
print(y2+y3)

#행렬 원소끼리 곱
print(y2 * y3)

#행렬곱
print(y2%*%y3)

#전치
print(t(y2))

#역함수
print(solve(y2))

### + 특정행, 특정열 선택하기.
y1=matrix(1:12,3,4)
print(y1)
print(y1[2,]) #두번째 행 추출
print(y1[,1]) #첫번째 열 추출

# x+2y=3, 3x+4y=5 연립방정식의 해를 풀어봅시다.
a=matrix(c(1,2,3,4),nrow=2, byrow=T)
b=matrix(c(3,5),ncol=1)
print(solve(a,b))

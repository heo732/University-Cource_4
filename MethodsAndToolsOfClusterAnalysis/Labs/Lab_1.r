#1.	Написати функцію, яка має три обов’язкові вхідні параметри: 
#   два вектори однакової довжини та назву методу, за допомогою якого  буде знайдена 
#   відстань між двома векторами. Функція повинна реалізувати п’ять відстаней.

x<-c(2,4,1) #довільний вектор
y<-c(1,3,2)

#Відстані:

#Евклідова відстань

Euclidian<-function (x,y) {
  return(sqrt(sum((x-y)*(x-y))))
}

#Мінковського (Mod - модуль)

p<-2 #параметр для відстані Мінковського

Minkowski<-function(x,y,p){ 
  return((sum(Mod(x-y)^p))^(1/p))
}

#Манхетенська

Manhattan<-function(x,y){ 
    return(sum(Mod(x-y)))
}

#Чебишева

Chebyshev<-function(x,y){
  return(max(Mod(x-y)))
}

#Махаланобіса

W<-rbind(c(1,0,0), c(0,1,0), c(0,0,1)) #одинична матриця (W – додатньо-визначена матриця (додатковий параметр функції)) 
 
MahalanobisD<-function (x,y, W)
{ 
  A<-x-y #різниця веторів
  TA<-t(A) #транспонування вектора А
  res<-TA%*%W%*%A  #множимо транспонований вектор на одиничну матрицю і на різницю векторів 
  return(res)
}


#Вивід відстаней по номеру

ShowDistance<-function(x, y,n=1, p=2, W = NA){
   x<- switch (n,
       Euclidian(x,y),
       Minkowski(x,y,p),
       Manhattan(x,y),
       Chebyshev(x,y),
       MahalanobisD(x,y,W)
           )
     return(x)
   }

#2. Використовуючи функції з п.1, написати функцію для обчислення 
#   матриці відстаней N об’єктів

MD<-function(X, c = "1", p = NA, W= NA)
{#X= matrix(c(1, 1, 2, 1, 2, 3, 1, 2, 3), nrow = 3, ncol = 3)
 
  N=dim(X)[1]
  result <- matrix(NA, nrow = N, ncol = N) #пуста матриця для результату
  for (i in 1:N) 
  {
    for (j in 1:N) 
    {
      if(c == "1"){
        result[i,j] <- Euclidian(X[i,], X[j,])
      }
      if(c == "2"){
        result[i,j] <- Minkowski(X[i,], X[j,], p)
      }
      if(c == "3"){
        result[i,j] <- Manhattan(X[i,], X[j,])
      }
      if(c == "4"){
        result[i,j] <- Chebyshev(X[i,], X[j,])
      }
      if(c == "5"){
        result[i,j] <- MahalanobisD(X[i,], X[j,], W)
      }
    }
  }
  return (result)
}


#2.2 Побудувати матрицю схожості

MS <- function(X, p = NA, W= NA) #матриця подібності (Matrix Similarity)
   {   #X= matrix(c(1, 1, 2, 1, 2, 3, 1, 2, 3), nrow = 3, ncol = 3)
       MDR = MD(X)
       
       N=dim(X)[1]

       result <- matrix(NA, nrow = N, ncol = N)
        for (i in 1:N) 
        {   
            M <- max(MDR[i,])
            m <- min(MDR[i,])
            result[i,] <- 1- (MDR[i,]-m)/(M-m)
                 
        }
       
       return(result)
}



#3.	Згенерувати масив з 10 двовимірних точок в R^2,зобразити даний масив
#   на графіку та побудувати матрицю відстаней для даного двовимірного масиву. 

# двовимірна матриця згенерована з допомогою показникового розподілу
Mat<-matrix(rexp(20, rate=0.6),10,2) 
plot(Mat)

Rs<-function(Mat, c = "1", p = NA, W= NA)
{ N=dim(Mat)[1]
  result<-matrix(NA,N,N)    
 
    for (i in 1:N){
      
      for (j in 1:N){
        
        if(c == "1"){result[i,j] <- Euclidian(Mat[i,], Mat[j,])}
        if(c == "2"){result[i,j] <- Minkowski(Mat[i,], Mat[j,], p)}
        if(c == "3"){result[i,j] <- Manhattan(Mat[i,], Mat[j,])}
        if(c == "4"){result[i,j] <- Chebyshev(Mat[i,], Mat[j,])}
        if(c == "5"){result[i,j] <- MahalanobisD(Mat[i,], Mat[j,], W)}
      }
      
    }

  return(result)
}


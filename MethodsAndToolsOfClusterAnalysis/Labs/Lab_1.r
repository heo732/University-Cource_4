#1.	�������� �������, ��� �� ��� ��������� ������ ���������: 
#   ��� ������� �������� ������� �� ����� ������, �� ��������� �����  ���� �������� 
#   ������� �� ����� ���������. ������� ������� ���������� ���� ��������.

x<-c(2,4,1) #�������� ������
y<-c(1,3,2)

#³������:

#�������� �������

Euclidian<-function (x,y) {
  return(sqrt(sum((x-y)*(x-y))))
}

#̳���������� (Mod - ������)

p<-2 #�������� ��� ������� ̳����������

Minkowski<-function(x,y,p){ 
  return((sum(Mod(x-y)^p))^(1/p))
}

#������������

Manhattan<-function(x,y){ 
    return(sum(Mod(x-y)))
}

#��������

Chebyshev<-function(x,y){
  return(max(Mod(x-y)))
}

#�����������

W<-rbind(c(1,0,0), c(0,1,0), c(0,0,1)) #�������� ������� (W � ��������-��������� ������� (���������� �������� �������)) 
 
MahalanobisD<-function (x,y, W)
{ 
  A<-x-y #������ ������
  TA<-t(A) #�������������� ������� �
  res<-TA%*%W%*%A  #������� �������������� ������ �� �������� ������� � �� ������ ������� 
  return(res)
}


#���� �������� �� ������

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

#2. �������������� ������� � �.1, �������� ������� ��� ���������� 
#   ������� �������� N �ᒺ���

MD<-function(X, c = "1", p = NA, W= NA)
{#X= matrix(c(1, 1, 2, 1, 2, 3, 1, 2, 3), nrow = 3, ncol = 3)
 
  N=dim(X)[1]
  result <- matrix(NA, nrow = N, ncol = N) #����� ������� ��� ����������
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


#2.2 ���������� ������� �������

MS <- function(X, p = NA, W= NA) #������� �������� (Matrix Similarity)
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



#3.	����������� ����� � 10 ���������� ����� � R^2,��������� ����� �����
#   �� ������� �� ���������� ������� �������� ��� ������ ����������� ������. 

# ��������� ������� ����������� � ��������� ������������� ��������
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


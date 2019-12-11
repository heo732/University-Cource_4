install.packages("ggplot2")
install.packages("dplyr")
install.packages("MASS")
install.packages("cluster")
install.packages("factoextra")
install.packages("ape")
install.packages("mva")
install.packages("caret")
install.packages("e1071")
library("ggplot2")
library("cluster")
library("MASS")
library("dplyr")
library("factoextra")
library("ape")
library("mva")
library("caret")
library(e1071)
install.packages("combinat")
library("combinat")


#1. ����������� 3 ������� ��������� ����������� ���������� ����� � R^2 � 
#   ��������� �� ������������� ��������� 
#ʳ������ ����� � ������� ����� ������� ���� ��������� 

m1=c(1,1)
E1=rbind(c(1,1), c(1,2)) #����������� ������� 


m2=c(1,-9)
E2=rbind(c(1,-1), c(-1,2))

m3=c(-7,-2)
E3=rbind(c(2,0.5), c(0.5,0.3))

#���������� 3 ������ � �������������� ����������� ��������
a1=mvrnorm(n = 100, mu=m1, Sigma=E1, tol = 1e-6, empirical = TRUE, EISPACK = FALSE)
a2=mvrnorm(n = 100, mu=m2, Sigma=E2, tol = 1e-6, empirical = TRUE, EISPACK = FALSE)
a3=mvrnorm(n = 100, mu=m3, Sigma=E3, tol = 1e-6, empirical = TRUE, EISPACK = FALSE)


plot(a1, type="p", col="green", xlim=c(-10,6), ylim=c(-15,10))
lines(a2, type="p", col="yellow")
lines(a3, type="p", col="red")


# 2. �������������� ����� k � �������� � ������ ����������� ����������� ��������, 
#���������� �������� ��� ��� ������ � 3N ������� ��� k=2,3,4
#��������� �� �������� ���������� �������� �������������

V = data.frame(c(a1[,1],a2[,1], a3[,1]), 
               c(a1[,2],a2[,2], a3[,2])) #��'������� �1,�2,�3
 
A1=kmeans(V, centers=3, iter.max = 10, nstart = 1) #����� �-�������� � 3 ��������
A2=kmeans(V, centers=2, iter.max = 10, nstart = 1) #����� �-�������� � 2 ��������
A3=kmeans(V, centers=4, iter.max = 10, nstart = 1) #����� �-�������� � 4 ��������

plot(V, type="p", col=A1$cluster)
lines(A1$centers, type="p", col="blue")

plot(V, type="p", col=A2$cluster)
lines(A2$centers, type="p", col="blue")

plot(V, type="p", col=A3$cluster)
lines(A3$centers, type="p", col="blue")


#3. �������������� ���������� ������������� � ������ ����������� ����������� ��������, 
#���������� �������� ��� ��� ������ � 3N ������� ��� k=2,3,4 ��������. 
#��������� �� �������� ���������� �������� �������������.

d = dist(V, method = "euclidean") #������ ������� ��������

H1 = hclust(d) #���������� ������������� 

#������� �� 3 ��������
sub_grp <- cutree(H1, k = 3) 

#����:
table(sub_grp)
fviz_cluster(list(data = V, cluster = sub_grp), geom = "point")

#������� �� 2 ��������
sub_grp1 <- cutree(H1, k = 2)

table(sub_grp1)
fviz_cluster(list(data = V, cluster = sub_grp1), geom="point")

#������� �� 4 ��������
sub_grp2 <- cutree(H1, k = 4) 

table(sub_grp2)
fviz_cluster(list(data = V, cluster = sub_grp2), geom="point")



#4. �������������� ��������� ���� ����� (N = 5), 
#���������� ���������� ���������� �������������.  

V1=V[1:5,] #�������� ����� 5 �������� � V

# ���������� 3 �������� ��� �������� ���������� ������������� ��� V1
d1=dist(V1)
H2=hclust(d1)
sub_grp3 <- cutree(H2, k = 2)
table(sub_grp3)

hcd <- as.phylo(H2) #��� ������������ � ������ ����������
plot(hcd, type = "fan") #type="radial" or "fan"
 
#5. ��� ������� K=3 � ����� k � �������� �� ���������� ������������� 
#��� ������� ������ ����� ���������� ������� ������������. 
#�������������� ������� ������������ CM, ��������� 
#������� ������� � ������� k � �������� �� ���������� �������������

t<-table(A1$cluster,sub_grp)
t
P = permn(1:3)
P
for (i in 6) {
  
t1 = t[,P[[i]]]
AC=sum(diag(t1))/sum(t1)*100
}
AC

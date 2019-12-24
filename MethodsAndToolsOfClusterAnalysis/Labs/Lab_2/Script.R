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


#1. Згенерувати 3 множини нормально розподілених випадкових чисел в R^2 з 
#   середніми та коваріаційними матрицями 
#Кількість точок в кожному наборі повинна бути однаковою 

m1 = c(1, 1)
E1 = rbind(c(1, 1), c(1, 2)) #коваріаційні матриці 


m2 = c(1, -9)
E2 = rbind(c(1, -1), c(-1, 2))

m3 = c(-7, -2)
E3 = rbind(c(2, 0.5), c(0.5, 0.3))

#побудувати 3 вибірки з багатовимірного нормального розподілу
a1 = mvrnorm(n = 100, mu = m1, Sigma = E1, tol = 1e-6, empirical = TRUE, EISPACK = FALSE)
a2 = mvrnorm(n = 100, mu = m2, Sigma = E2, tol = 1e-6, empirical = TRUE, EISPACK = FALSE)
a3 = mvrnorm(n = 100, mu = m3, Sigma = E3, tol = 1e-6, empirical = TRUE, EISPACK = FALSE)


plot(a1, type = "p", col = "green", xlim = c(-10, 6), ylim = c(-15, 10))
lines(a2, type = "p", col = "yellow")
lines(a3, type = "p", col = "red")


# 2. Використовуючи метод k – середніх з трьома випадковими початковими центрами, 
#побудувати кластери для всіх вибірок з 3N точками для k=2,3,4
#Зобразити на графіках результати відповідної кластеризації

V = data.frame(c(a1[, 1], a2[, 1], a3[, 1]),
               c(a1[, 2], a2[, 2], a3[, 2])) #об'єднання а1,а2,а3

A1 = kmeans(V, centers = 3, iter.max = 10, nstart = 1) #метод к-середніх з 3 центрами
A2 = kmeans(V, centers = 2, iter.max = 10, nstart = 1) #метод к-середніх з 2 центрами
A3 = kmeans(V, centers = 4, iter.max = 10, nstart = 1) #метод к-середніх з 4 центрами

plot(V, type = "p", col = A1$cluster)
lines(A1$centers, type = "p", col = "blue")

plot(V, type = "p", col = A2$cluster)
lines(A2$centers, type = "p", col = "blue")

plot(V, type = "p", col = A3$cluster)
lines(A3$centers, type = "p", col = "blue")


#3. Використовуючи ієрархічну кластеризацію з трьома випадковими початковими центрами, 
#побудувати кластери для всіх вибірок з 3N точками для k=2,3,4 кластерів. 
#Зобразити на графіках результати відповідної кластеризації.

d = dist(V, method = "euclidean") #знайти матрицю відстаней

H1 = hclust(d) #ієрархічна кластеризація 

#групуємо на 3 кластери
sub_grp <- cutree(H1, k = 3)

#вивід:
table(sub_grp)
fviz_cluster(list(data = V, cluster = sub_grp), geom = "point")

#групуємо на 2 кластери
sub_grp1 <- cutree(H1, k = 2)

table(sub_grp1)
fviz_cluster(list(data = V, cluster = sub_grp1), geom = "point")

#групуємо на 4 кластери
sub_grp2 <- cutree(H1, k = 4)

table(sub_grp2)
fviz_cluster(list(data = V, cluster = sub_grp2), geom = "point")



#4. Використовуючи невеликий набір даних (N = 5), 
#побудувати дендограму ієрархічної кластеризації.  

V1 = V[1:5,] #записуємо перші 5 елементів з V

# повторюємо 3 завдання для побудови ієрархічної кластеризації над V1
d1 = dist(V1)
H2 = hclust(d1)
sub_grp3 <- cutree(H2, k = 2)
table(sub_grp3)

hcd <- as.phylo(H2) #для перетворення у вигляд дендограми
plot(hcd, type = "fan") #type="radial" or "fan"

#5. Для випадку K=3 у методі k – середніх та ієрархічної кластеризації 
#для повного набору даних побудувати матрицю невідповідності. 
#Використовуючи матрицю невідповідності CM, обчислити 
#відсоток помилок в методах k – середніх та ієрархічної кластеризації

t <- table(A1$cluster, sub_grp)
t
P = permn(1:3)
P
for (i in 6) {

    t1 = t[, P[[i]]]
    AC = sum(diag(t1)) / sum(t1) * 100
}
AC
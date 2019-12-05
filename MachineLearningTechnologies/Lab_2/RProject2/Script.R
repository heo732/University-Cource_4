library(e1071)
library(caret)
library(ggplot2)
library(MASS)
library(scales)


iris
ir <- iris

names(iris)

# Кадр даних, що містить дані про навчання, де зразки знаходяться у рядках, а функції - у стовпцях.
x = iris[, -5]
# Числовий чи факторний вектор, що містить результат для кожного зразка.
y = iris$Species

# 'nb' рядок із зазначенням, яку модель класифікації чи регресії використовувати.
# trControl список значень, які визначають, як діє ця функція
# Метод передискретизации: boot, cv, LOOCV, LGOCV(для повторного навчання / тестування розколів), або oob(тільки для випадкового лісу, дерева в мішках, в мішках землю, упаковують гнучкий дискримінантний аналіз,method cv 
model = train(x, y, 'nb', trControl = trainControl(method = 'cv', number = 10))

# Використовуэмо прогноз для отримання значення прогнозування та класу результатів.
predict(model$finalModel, x)
# Потрібно порівняти результат прогнозування з видами класу щоб дізнатись скільки класифіковано помилок.
table(predict(model$finalModel, x)$class, y)

naive_iris <- naiveBayes(iris$Species ~ ., data = iris)
w <- seq(0, 10, by = 0.1)
plot(w, naive_iris)


ac <- percent((26 + 10) / 45)


# pima
pi <- Pima.tr2

names(pi)

# 8-ий стовбець не виводиться.
xpi <- Pima.tr2[, -8]
# ypi<-as.factor(Pima.tr2$type)  
ypi <- Pima.tr2$type

ifelse(Pima.tr2$npreg == 0, NA, Pima.tr2$npreg)
ifelse(Pima.tr2$glu == 0, NA, Pima.tr2$glu)
ifelse(Pima.tr2$bp == 0, NA, Pima.tr2$bp)
ifelse(Pima.tr2$skin == 0, NA, Pima.tr2$skin)
ifelse(Pima.tr2$bmi == 0, NA, Pima.tr2$bmi)
ifelse(Pima.tr2$ped == 0, NA, Pima.tr2$ped)


# з 1 по 80 рядок
train <- pi[1:100,]
test <- pi[101:150]

pimodel = train(xpi, ypi, 'nb', trControl = trainControl(method = 'cv', number = 10))



pinaive_pima <- naiveBayes(type ~ ., data = Pima.tr2)

pr <- predict(pinaive_pima, train)

table(pr)

table(Pima.tr2$type, pr)
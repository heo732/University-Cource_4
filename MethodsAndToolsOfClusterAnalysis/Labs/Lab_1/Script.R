# 1) Написати функцію, яка має три обов’язкові вхідні параметри: 
# два вектори однакової довжини та назву методу, за допомогою якого  буде знайдена 
# відстань між двома векторами. Функція повинна реалізувати п’ять відстаней.

GetDistance = function(x, y, methodName = 'Euclidian', p = 2, W = NA)
{
    return(switch(methodName,
        'Euclidian' = sqrt(sum((x - y) * (x - y))),
        'Minkowski' = (sum(Mod(x - y) ^ p)) ^ (1 / p),
        'Manhattan' = sum(Mod(x - y)),
        'Chebyshev' = max(Mod(x - y)),
        'Mahalonobis' = t(a) %*% W %*% (x - y)));
}

# 2) Використовуючи функції з п.1, написати функцію для обчислення 
# матриці відстаней N об’єктів.

CalculateDistanceMatrix = function(X, methodName = 'Euclidian', p = NA, W = NA)
{
    N = dim(X)[1];
    result = matrix(NA, nrow = N, ncol = N);
    for (i in 1:N)
    {
        for (j in 1:N)
        {
            result[i, j] = GetDistance(X[i,], X[j,], methodName, p, W);
        }
    }
    return(result);
}


#2.2 Побудувати матрицю схожості

CalculateSimilarityMatrix = function(X, methodName = 'Euclidian', p = NA, W = NA)
{
    distanceMatrix = CalculateDistanceMatrix(X);

    N = dim(X)[1];

    result = matrix(NA, nrow = N, ncol = N);
    for (i in 1:N)
    {
        M = max(distanceMatrix[i,]);
        m = min(distanceMatrix[i,]);
        result[i,] = 1 - (distanceMatrix[i,] - m) / (M - m);
    }

    return(result);
}

CalculateSimilarityMatrix(c(2, 3, 7));


#3.	Згенерувати масив з 10 двовимірних точок в R^2,зобразити даний масив
#   на графіку та побудувати матрицю відстаней для даного двовимірного масиву. 

# двовимірна матриця згенерована з допомогою показникового розподілу
Mat = matrix(rexp(20, rate = 0.6), 10, 2);
plot(Mat);

Mat;

Rs = function(Mat, c = "1", p = NA, W = NA)
{
    N = dim(Mat)[1];
    result = matrix(NA, N, N);

    for (i in 1:N)
    {
        for (j in 1:N)
        {
            if (c == "1") { result[i, j] = GetDistance(Mat[i,], Mat[j,]); }
            if (c == "2") { result[i, j] = GetDistance(Mat[i,], Mat[j,], 'Minkowski', p); }
            if (c == "3") { result[i, j] = GetDistance(Mat[i,], Mat[j,], 'Manhattan'); }
            if (c == "4") { result[i, j] = GetDistance(Mat[i,], Mat[j,], 'Chebyshev'); }
            if (c == "5") { result[i, j] = GetDistance(Mat[i,], Mat[j,], 'Mahalonobis', NA, W); }
        }
    }

    return(result);
}
Rs(Mat);
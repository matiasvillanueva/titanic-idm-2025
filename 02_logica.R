# Cargar librerías para árbol de decision
library(rpart)
library(rpart.plot)

# 1. Crear el arbol de decision
arbol_survived <- rpart(
  Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked,
  data = titanic_train,
  method = "class",  # Para clasificacion
  control = rpart.control(
    minsplit = 10,    # Mínimo de observaciones para dividir
    minbucket = 5,    # Mínimo en nodo terminal
    cp = 0.01,        # Complejidad (evita overfitting)
    maxdepth = 5      # Profundidad máxima
  )
)

# 2. Ver resumen del arbol
print(arbol_survived)
summary(arbol_survived)

# 3. Visualizar el arbol y guardarlo como PNG
png("output/titanic.png", width = 1000, height = 600)
rpart.plot(arbol_survived, 
           type = 2, 
           extra = 104,  # Muestra probabilidades y clasificación
           box.palette = "GnBu",
           fallen.leaves = TRUE,
           main = "Árbol de Decisión - Supervivencia en el Titanic")
dev.off()

# 4. Hacer predicciones en el training set (para ver performance)
predicciones_train <- predict(arbol_survived, titanic_train, type = "class")

# 5. Matriz de confusión en training (comparar predicciones con valores reales)
table(Predicho = predicciones_train, Real = titanic_train$Survived)

# 6. Accuracy en training
accuracy_train <- mean(predicciones_train == titanic_train$Survived)
cat("Accuracy en training:", round(accuracy_train * 100, 2), "%\n")
# Hacer predicciones en el test set
predicciones_test <- predict(arbol_survived, titanic_test, type = "class")

# Crear dataframe con ID y prediccion de supervivencia
resultados_test <- data.frame(
  PassengerId = titanic_test$PassengerId,
  Survived_Pred = predicciones_test
)

# Ver los primeros resultados
head(resultados_test)
table(resultados_test$Survived_Pred)

write.csv(resultados_test, "output/predicciones_titanic.csv", row.names = FALSE)

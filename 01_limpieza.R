# Librerias
library(dplyr)
library(readr)

set.seed(123)

# Leer el dataset
titanic <- read.csv("input/titanic.csv", stringsAsFactors = FALSE)

# Limpieza
titanic_clean <- titanic %>%
  mutate(
    # Imputar Age con mediana
    Age = ifelse(is.na(Age), median(Age, na.rm = TRUE), Age),
    # Imputar Embarked con moda. Asumimos que embarcaron en "S"- Southampton.
    Embarked = ifelse(Embarked == "" | is.na(Embarked), "S", Embarked),
    # Imputar Fare con mediana para no impactar en el precio del ticket.
    Fare = ifelse(is.na(Fare) | Fare == 0, median(Fare, na.rm = TRUE), Fare),
    # Convertir a factores
    Survived = factor(Survived),
    Pclass = factor(Pclass),
    Sex = factor(Sex),
    Embarked = factor(Embarked)
  )

# Verificar limpieza
summary(titanic_clean)
glimpse(titanic_clean)
sum(is.na(titanic_clean))

# Dividir solo en train y test (80% - 20%)
train_size <- floor(0.8 * nrow(titanic_clean))

# Crear indices aleatorios
shuffled_indices <- sample(1:nrow(titanic_clean))

# 1. Dataset de entrenamiento (con Survived)
titanic_train <- titanic_clean[shuffled_indices[1:train_size], ]

# 2. Dataset de prueba (SIN Survived)
titanic_test <- titanic_clean[shuffled_indices[(train_size + 1):nrow(titanic_clean)], ] %>%
  select(-Survived)

# Verificar tamaños de los dos datasets
cat("Train:", nrow(titanic_train), "filas - Con Survived\n")
cat("Test:", nrow(titanic_test), "filas - Sin Survived\n")

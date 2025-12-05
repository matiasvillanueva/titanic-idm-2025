# Librerias
library(ggplot2)
library(dplyr)
library(car)

png("output/Distribucion_de_Supervivencia.png", width = 1000, height = 600)

ggplot(titanic_clean, aes(x = factor(Survived), fill = factor(Survived))) +
  geom_bar() +
  geom_text(
    stat = "count",
    aes(label = sprintf("%.1f%%", after_stat(count / sum(count) * 100))),
    vjust = -0.3,
    size = 4
  ) +
  labs(
    title = "Distribución de Supervivencia",
    x = "Survived (0 = no, 1 = si)",
    y = "Cantidad de pasajeros"
  ) +
  ylim(0, max(table(titanic_clean$Survived)) * 1.1) +  # espacio para los %
  theme_minimal()


dev.off()

png("output/Proporcion_de_supervivencia_por_sexo.png", width = 1000, height = 600)
ggplot(titanic_clean, aes(x = Sex, fill = Survived)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = "Proporción de supervivencia por sexo",
    x = "Sexo",
    y = "Porcentaje"
  )
dev.off()

png("output/Edad_por_condicion_de_supervivencia.png", width = 1000, height = 600)
ggplot(titanic_clean, aes(x = Survived, y = Age, fill = Survived)) +
  geom_boxplot() +
  labs(
    title = "Edad por condición de supervivencia",
    x = "Survived (0 = no, 1 = sí)",
    y = "Edad"
  )
dev.off()

png("output/Relacion_entre_Edad_y_Tarifa.png", width = 1000, height = 600)
ggplot(titanic_clean, aes(x = Age, y = Fare, color = Survived)) +
  geom_point(alpha = 0.6) +
  labs(
    title = "Relación entre Edad y Tarifa (color = Survived)",
    x = "Edad",
    y = "Tarifa pagada"
  )
dev.off()

png("output/Supervivencia_segun_Clase.png", width = 1000, height = 600)

ggplot(titanic_clean,
       aes(x = Pclass, fill = Survived)) +
  geom_bar(position = "fill") +
  geom_text(
    stat = "count",
    aes(
      label = sprintf("%.1f%%", after_stat(prop * 100)),
      y = after_stat(prop),
      group = Survived
    ),
    position = position_fill(vjust = 0.5),
    color = "white",
    size = 4
  ) +
  labs(
    title = "Supervivencia según Clase",
    x = "Clase (1 = Alta, 2 = Media, 3 = Baja)",
    y = "Proporción dentro de cada clase",
    fill = "Survived"
  ) +
  theme_minimal()
dev.off()

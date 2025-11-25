# make.R - Ejecutar pipeline Titanic
run:
	R -e "source('01_limpieza.R'); source('02_logica.R'); source('03_resultado.R')"
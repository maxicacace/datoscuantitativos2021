# Cargar el paquete tidyverse.

library(tidyverse)

### Ejercicio 1: cargar los paquetes haven y readxl.

library(readxl)

library(haven)

# Importar la base de datos PsicPositiva.xlsx.
read_xlsx("datos/PsicPositiva.xlsx")

glimpse(intervenciones_xlsx)

### Ejercicio 2: Crear el data frame "intervenciones_xlsx" a partir 
### de la base PsicPositiva.xlsx.

intervenciones_xlsx <- read_xlsx("datos/PsicPositiva.xlsx")

# Inspeccionar el data frame

# dimensiones
#primero aparecen las filas y después las columnas (442x9)
dim(intervenciones_xlsx)

# estructura general
# tibble es un tipo de data frame
#los dos hacen lo mismo, pero a ella le gusta más glimpse
str(intervenciones_xlsx)

glimpse(intervenciones_xlsx)

# primeras filas
head(intervenciones_xlsx)
#por default tira 6, pero puedo pedirle que me de las que quiero, por ejemplo 2
head(intervenciones_xlsx, 2)

# ultimas filas
tail(intervenciones_xlsx)
#igual que head, por default tira 6 pero puedo pedir las que quiera
tail(intervenciones_xlsx, 2)

# resumen rápido
#da un pantallazo general de las columnas, permite ver errores y algunos datos rápido

summary(intervenciones_xlsx)

#view es para ver la base completa, la abre al lado del script
view(intervenciones_xlsx)

# ¿Por qué la columna edad es de tipo character? Subsetear
# la columna edad como vector. 

intervenciones_xlsx["edad"]

#si lo pido con doble corchete convierte la columna de un dataframe en un vector
intervenciones_xlsx[["edad"]]

#lo mismo se puede hacer poniendo el signo $, te hace elegir entre las variables cuál querés ver
intervenciones_xlsx$edad

#con esta manera puedo ver cuál es la razón por la que me está codificando edad como texto
#encuentro que en un lugar dice "falta", entonces lo tengo que cambiar


# Especificar en la función read_xlsx la hoja de cálculo y 
# el código que identifica los datos faltantes. 

intervenciones_xlsx <- read_xlsx("datos/PsicPositiva.xlsx", na = "Falta")

#así le estamos indicando que donde dice "falta" lo tome como un NA, es decir como un dato que falta
#si sale bien, al poner glimpse aparece que edad ahora es "dbl"
#No hay que olvidarse que es caps sensitive, tiene que estar escrito igual que en el archivo
#por eso es útil escribir siempre todo en minúscula

glimpse(intervenciones_xlsx)



# Qué hacer cuando es más de un código.
#es decir, cuando se usan distintas palabras para decir que faltan datos, por ejemplo con minuscula y mayuscula
#entonces ponemos c para combinar y ponemos las distintas notaciones
intervenciones_xlsx <- read_xlsx("datos/PsicPositiva.xlsx", na = c("Falta", "falta"))



# Importar las bases PsicPositiva.sav y PsicPositiva.csv. 
read_sav("datos/PsicPositiva.sav")
read_csv("datos/PsicPositiva.csv")

#creamos el objeto intervenciones_csv
intervenciones_csv <- read_csv("datos/PsicPositiva.csv")

# Extraer los nombres de las columnas
names(intervenciones_csv)
names(intervenciones_xlsx)

#vemos por que tienen diferentes observaciones



#esto tambien te permite cambiar los nombres de las columnas

# Modificar el nombre de evaluacion por tiempo_evaluacion
names(intervenciones_xlsx)[6] <- "tiempo_evaluacion"

#vuelvo a pedir los nombres para ver si funciono
names(intervenciones_xlsx)


### Ejercicio 3: Inspeccionar intervenciones_csv y responder:
glimpse(intervenciones_csv)

### a. ¿Cuántas observaciones y cuántas columnas tiene el df?
dim(intervenciones_csv) #o directamente glimpse
#299 filas y 10 columnas

### b. ¿De qué tipo es cada variable o columna?
#son todas numericas (dbl) menos "edad" e ingresos" que son tipo character (dbl)

### c. ¿Por qué la variable edad es de tipo character? 
intervenciones_csv["edad"]
intervenciones_csv$edad #para ver el vector completo y ver donde esta el error

### ¿Podés solucionarlo?

intervenciones_csv <- read_csv("datos/PsicPositiva.csv", na = c("Falta", "falta", "No lo informa", "NA")) #para que
#tome lo que le digo como NA y no como texto
glimpse(intervenciones_csv) #para ver si cambió el tipo de vector







# Contar participantes en intervenciones_csv por categoría de:
 # Sexo
 # Nivel de ingreso

count(intervenciones_csv, sexo)
count(intervenciones_csv, ingresos)
#en el vector ingresos no nos damos cuenta que la base esta mal cargada hasta que no pedimos el count 


# Borrar las bases intervenciones_csv e intervenciones_sav.

rm(intervenciones_csv)
rm(intervenciones_xlsx)

### Ejercicio 4: 
### a. Importar las bases "Licencia de conducir.xlsx" 
### como LC, "Notas.xlsx" como N, "Tarea.xlsx" como Ta
read_xlsx("datos/Licencia de conducir.xlsx")
LC <- read_xlsx("datos/Licencia de conducir.xlsx")

read_xlsx("datos/Notas.xlsx")
N <- read_xlsx("datos/Notas.xlsx")


read_xlsx("datos/Tarea.xlsx")
Ta <- read_xlsx("datos/Tarea.xlsx")


### b. Usar la función "glimpse()" con cada una ver que se imprime
### por consola. 

glimpse(LC)
#cuando usamos subtitulos, R los lee mal, los toma como si fuera la primera fila

glimpse(N)
#cuando pedimos el promedio al final de la columna en excel R lo levanta, hay que tener cuidado de no dejarlo puesto

glimpse(Ta)
#tiene informacion codificada con codigo de color, que R no lo lee y es un error que no se nota acá


### c. Abrir las bases en excel y mirar que caracteristicas de las
### bases pueden generar problemas con R.

# Eliminar las bases LC, N y TA.
rm(LC)
rm(N)
rm(Ta)


#cargar de nuevo intervenciones
intervenciones_xlsx <- read_xlsx("datos/PsicPositiva.xlsx")

# Extraer las columnas felicidad_AHI y depresion_CESD
intervenciones_xlsx[c("felicidad_AHI", "depresion_CESD")]



# Extraer las columnas felicidad_AHI y depresion_CESD 
# para la fila 8. 
intervenciones_xlsx[8, c("felicidad_AHI", "depresion_CESD")]


# Extraer las columnas felicidad_AHI y depresion_CESD 
# para las filas 8 a 20. 
intervenciones_xlsx[8:20, c("felicidad_AHI", "depresion_CESD")]


# Extraer las columnas felicidad_AHI y depresion_CESD 
# para las filas 5, 15 y 25.
intervenciones_xlsx[c(5, 15, 25), c("felicidad_AHI", "depresion_CESD")]

# Extraer las columnas felicidad_AHI y depresion_CESD 
# para los participantes de sexo femenino.  

intervenciones_xlsx[intervenciones_xlsx$sexo == 1, c("felicidad_AHI", "depresion_CESD")] #con el codigo tradicional asi segmentamos en base a una condicion
#despues de la coma dejamos espacio en blanco porque queremos todas las columnas
#ahora vamos a aprender a hacerlo  usando tidyverse


# Pipe lines ---------------------------------------------------------
%>% #esto se hace poniendo ctrl+shift+m


intervenciones_xlsx %>% 
  filter(sexo == 1) %>% 
  select(felicidad_AHI, depresion_CESD)



# select(), select_if() ------------------------------------

# seleccionar las variables felicidad_AHI y depresion_CESD


# seleccionar todas menos id

intervenciones_xlsx %>% 
  select(-id)

# seleccionar todas las variables entre sexo y tiempo_evaluacion

intervenciones_xlsx %>% 
  select(sexo:evaluacion)


# seleccionar sólo las variables numéricas.

intervenciones_xlsx %>% 
  select_if(is.numeric)



# filter ------------------------------------------------------

# operadores lógicos o booleanos

2 == 2 #si es verdad va a poner TRUE en la consola
2 == 3 #si no, va a poner FALSE #el doble signo igual pregunta por la igualdad
2 != 4 #el signo de exclamación antes del igual pregunta por diferencia (desigual)
2 > 4 #mayor
2 >= 4  #mayor o igual
2<4 #menor
2<=4 #menor o igual


2 != 3 & 2 == 2 #se pueden hacer más de una pregunta en simultáneo
# & se usa para encadenar funciones que se cumplan todas

2 != 3 | 2 == 4
#la barra parada ( | )funciona como disyuntivo, una o la otra

# seleccionar solo las observaciones de participantes masculinos (2)
# (con y sin pipes)
intervenciones_xlsx %>% 
  filter(sexo == 1 | ingresos == "Medios")

intervenciones_xlsx %>% 
  filter(sexo == 1 & ingresos == "Medios")  #también se puede usar coma en vez de &


# seleccionar las observaciones de participantes sin ingresos altos

intervenciones_xlsx %>% 
  filter(ingresos != "Altos")


# seleccionar las observaciones con valores de depresion_CESD 
# menores o iguales a 40.

intervenciones_xlsx %>% 
  filter(depresion_CESD <= 40)

# y entre 20 y 40. 

intervenciones_xlsx %>% 
  filter(between(depresion_CESD, 20, 40))

intervenciones_xlsx %>% 
  filter(depresion_CESD >= 20, depresion_CESD >= 40)

# seleccionar dos condiciones con , y |.

# Seleccionar y filtrar --------------------------------------------

# seleccionar depresion_CESD y felicidad_AHI sólo para la 
# primera evaluación (0).


intervenciones_xlsx %>% 
  filter(evaluacion == 0) %>% 
  select(depresion_CESD, felicidad_AHI)



### Ejercicio 5:
### Seleccionar a los participantes de sexo femenino (1) de entre
### 45 y 65  de felicidad. 

intervenciones_xlsx %>% 
  filter(sexo == 1) %>% 
  filter(between(felicidad_AHI, 45, 65)) %>% 
  select(id)

intervenciones_xlsx %>% 
  filter(sexo == 1, between(felicidad_AHI, 45, 65)) %>% 
  select(id)



# count -----------------------------------------------

# contar cuantos participantes hay en la evaluacion inicial y
# cuantos en la final. 

intervenciones_xlsx %>% 
  count(evaluacion)

intervenciones_xlsx %>% 
  count(evaluacion, intervencion)
#cuando contamos algo arma una variable que se llama "n" con la que después podemos operar


### Ejericio 6: 
### Contar cuantos participantes hay con ingresos altos, 
### medios y bajos dentro de cada grupo terapéutico (intervencion).  

intervenciones_xlsx %>% 
  count(ingresos, intervencion)



# group_by y summarise -------------------------------------------

# calcular el promedio de felicidad_AHI y depresion_AHI para 
# cada grupo terapeutico

# calcular el promedio de felicidad_AHI y depresion_AHI para 
# cada grupo terapeutico, en las evaluaciones inicial y final. 

# arrange --------------------------------------------------------



# Depresion.csv ------------------------------------------------------

# Importar Depresion.csv (read_csv)

# Inspeccionar la base (glimpse) 

# Extraer el nombre de las columnas (names).

# Crear las variables AHI_total y CESD_total.

# Cambiar el nombre de las columna y guardar la nueva base.

# Quedarse sólo con los participantes que fueron evaluados 
# 4 veces. 

# Calcular el puntaje promedio de felicidad_AHI y depresion_AHI
# en cada grupo terapéutico en cada momento de evaluación. 
# 
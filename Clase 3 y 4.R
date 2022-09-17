# instalar el paquete "writexl"


install.packages("writexl")

# citar r
version  #para ver cuál es la versión de R que tenemos, nos da toda la info de eso
#cuando hacemos un artículo, tenemos que citar lo que dice en "version.string", 
#que en este caso es R version 4.0.4 (2021-02-15)

citation() #con esto te dice cómo se cita R, en este caso dice
#To cite R in publications use:
#R Core Team (2021). R: A language and environment for
#statistical computing. R Foundation for Statistical
#Computing, Vienna, Austria. URL
#https://www.R-project.org/.


### Ejercicio 1: cargar los paquetes readxl, tidyverse

library(tidyverse) # library es para cargarlo
library(haven)
library(readxl)

install.packages("writexl") #a diferencia de library, para instalar hay que ponerlo entre comillas


library(writexl)

### Ejercicio 2: importar la base "Notas cursos.xlsx" como un 
### data frame que se llame "notas".
read_xlsx("datos/Notas cursos.xlsx")
notas <- read_xlsx("datos/Notas cursos.xlsx")


### Ejercicio 3. Registrar:
### - cuántas filas y cuántas columnas tiene el data frame.
glimpse(notas)
str(notas)
### - qué información tiene cada variable. 
summary(notas) #para ver información general, pero también con glimpse vemos el tipo de información que tiene cada variable

### - si el tipo de columna coincide con la información que tiene. 
#todo lo vemos con glimpse


# Imprimir en consola los nombres de todas las columnas
names(notas)

# Funciones count(), filter(), select() y view() ---------------------


# contar cuantos alumnos aprobaron el curso (variable "condicion")
count(notas, condicion) #primero ponemos el data frame y despues la variable que queremos ver
#me va a mostrar un mini data frame con esos datos


### Ejercicio 4: contar cuantos alumnos tiene cada docente. 
count(notas, doc)

# Imprimir por consola un data frame que contenga sólo
# las variables "faltas" y "nota".
select(notas, faltas, nota) #dentro de select no hace falta usar comillas, porque en las funciones
#de tidy verse cuando ponemos comillas lo toma como si fuera el valor de una celda
#sí hace falta usarlas cuando usamos corchetes

#otra opción para hacerlo
notas[c("faltas", "nota")]
#da el mismo resultado, pero es más larga porque requiere usar la función combinar y usar comillas


# seleccionar todas las variables menos "condicion". 
select(notas, -condicion) #se pone el signo menos
#se puede seguir poniendo - para sacar más variables

select(notas, condicion:grupo) #esto es para seleccionar todas las variables que están entre "condicion" y "grupo"


# Quedarse sólo con los alumnos que aprobaron.
#select es para seleccionar columnas
#filter es para seleccionar filas

filter(notas, condicion == "Aprobado")

notas %>% 
  filter(condicion == "Aprobado") #así se escribe usando pipes


# Quedarse sólo con los alumnos que aprobaron y que, además, 
# participaron de un grupo de estudio. 

notas %>% 
  filter(condicion == "Aprobado", grupo == "Si") #así me muestra las dos condiciones

notas %>% 
  filter(condicion == "Aprobado" | grupo == "Si") #esto es si quisiera pedir una condición o la otra



# a. ¿Cúantos alumnos cumplen esas condiciones? 

notas %>% 
  filter(condicion == "Aprobado", grupo == "Si") %>% 
  count()


# b. ¿Cuántos alumnos cumplen esas condiciones por docente?
notas %>% 
  filter(condicion == "Aprobado", grupo == "Si") %>% 
  count(doc)

### Ejercicio 5:
### Imprimir en la consola un data frame que contenga:
### - todos los alumnos que aprobaron y... 
### - sólo las variables condicion, faltas.

notas %>% 
  filter(condicion == "Aprobado") %>% 
  select(condicion, faltas)
  


# ¿Qué pasa si invertimos las líneas de filter() y select()?
notas %>% 
  select(condicion, faltas) %>% 
  filter(condicion == "Aprobado") 
 #con esto no hay problema porque filtramos una variable que seleccionamos, el problema es cuando no la seleccionamos antes



# Abrir en una pestaña aparte un data frame que contenga la condicion y 
# la nota de todos los alumnos que faltaron menos de 5 veces
notas %>% 
  filter(faltas < 5) %>% 
  select(condicion, nota) %>% 
  view()


# Modificar el codigo para contar cuantos aprobados y cuantos desaprobados
# faltaron menos de 5 veces. 

notas %>% 
  filter(faltas < 5) %>% 
  count(condicion) 


# Funciones mutate(), group_by() y summarise() ---------------------------------------

#summarise da medidas de resumen
#min da el valor minimo
#max da el valor maximo
#mean da el promedio

#mutate sirve para crear una variable nueva o modificar una existente

# Calcular el promedio de las notas (summarise)

notas %>% 
  summarise(mean(nota))

# agregar valor mínimo y máximo

notas %>% 
  summarise(mean(nota), min(nota), max(nota))

notas %>% 
  summarise(Media = mean(nota), Minimo = min(nota), Maximo = max(nota))
#así me lo tira con nombres que podríamos levantar para una tabla que queramos usar después

#con la notación tradicional se puede escribir así
mean(notas$nota)
min(notas$nota)
max(notas$nota)


# obtener esos mismos valores para el curso de cada docente (group_by
# y summarise)

notas %>% 
  group_by(doc) %>% 
  summarise(Media = mean(nota), Minimo = min(nota), Maximo = max(nota))
# asi le pido que ese resumen me lo agrupe por las variables de la columna docente



### Ejercicio 6: 
### Calcular el promedio de edad para los alumnos de cada docente. 

notas %>% 
  group_by(doc) %>% 
  summarise(mean(edad))

# Crear un data frame llamado "curso_notas" con los datos del código 
# anterior (mean, min, max de nota por docente). 

curso_notas <- notas %>% 
  group_by(doc) %>% 
  summarise(Media = mean(nota),
            Minimo = min(nota),
            Maximo = max(nota))

# Guardar el data frame en un archivo llamado 
# "Notas por curso.xlsx" en la carpeta datos (clase 4)

write_xlsx(curso_notas)

curso_notas %>% 
  write_xlsx("datos/Notas por curso.xlsx")
#asi podemos guardar archivos nuevos con selecciones de datos del archivo original sin tocar el original

#otra forma de hacerlo
write_xlsx(curso_notas, "Notas por curso.xlsx")

readxl:: #para ver las funciones que tiene un paquete
#tambien podemos poner el nombre del paquete + r en google y entre los resultados
  #buscamos un archivo pdf que esta en una pagina que se llama "cran"
  

# Calcular el promedio de las notas por docente, separando entre
# quienes participaron y quienes no participaron de un grupo de estudio. 


notas %>% 
  group_by(doc, grupo) %>% 
  summarise(mean(nota))
  

# crear una variable llamada nota2 que sea la nota dividido 10. 

notas %>% 
  mutate(nota2 = nota/10) #en la consola se me muestra esta nueva variable en el dataframe


#para cambiar la variable original directamente

notas %>% 
  mutate(nota = nota/10)

notas2 <- notas %>% 
  mutate(nota = nota/10) %>% 
  filter(nota > 7)


# crear una variable llamada "regularidad" que valga "si" si el 
# alumno faltó menos de 5 veces y "no" si faltó 5 veces o más. 

notas %>% 
  mutate(regularidad = ifelse(faltas < 5, "si", "no"))
#estamos categorizando una variable
#ifelse solo nos sirve si las respuestas son 2 opciones nada más

# agregar el código necesario para contar cuantos alumnos mantuvieron
# la regularidad. 

notas %>% 
  mutate(regularidad = ifelse(faltas < 5, "si", "no")) %>% 
  count(regularidad)

### Ejercicio 7: crear una variable llamada "promoción" que valga "si"
### si la nota es igual o mayor a 70 y "no" si es menor. 

notas %>% 
  mutate(promocion = ifelse(nota >= 70, "si", "no")) 

notas %>% 
  mutate(promocion = ifelse(nota >= 70, "si", "no")) %>% 
  count(promocion)

#case_when es como ifelse pero para más condiciones que 2
notas %>% 
  mutate(condicion2 = case_when(nota < 40 ~ "Desaprobado",
                                between(nota, 40, 69) ~ "Aprobado",
                                nota >= 70 ~ "Promocionado")) %>% 
  count(condicion2)


# crear una variable que sea la proporcion de alumnos dentro de 
# cada categoría condición x grupo.

notas %>% 
  count(condicion, grupo) %>% #primero pongo ctrl+enter acá para que se cree la variable "n" que crea count
  mutate(prop = n/200*100)


notas %>% 
  count(condicion, grupo) %>% 
  group_by(condicion) %>% 
  summarise(prop = n/sum(n)*100) #aca pònemos sum(n) para que el algoritmo se de cuenta solo cuantos n totales hay, sin tener que saberlo
#asi podemos ver los aprobados y desaprobados agrupados segun si participaron del grupo de estudio o no
#nos falta conseguir que aparezca la columna que muestre si participaron o no




# HELPERS


#HELPERS DE SELECT

names(notas)
notas2 <- notas %>% 
  mutate(nota2 = nota / 10)

names(notas2)


select(notas2, starts_with("no"))
#starts_with te permite seleccionar las variables que empiezan igual o tienen el mismo prefijo

depresion <- read_csv("datos/Depresion.csv")
view(depresion)

select(depresion, starts_with("ahi"))

#ends_with es lo mismo pero con el final en vez del inicio o tienen el mismo sufijo
select(depresion, ends_with("01")) 

#regex son regular expressions, no hace falta saberlo de memoria
  
#contains es para algo que no está al principio ni al final necesariamente
select(depresion, contains("es"))
  

#HELPERS DE FILTER

filter(depresion, between(cesd20, 1, 45))

depresion %>% 
  filter(between(cesd20, 1, 20))

depresion %>% 
  filter(cesd20 >= 1, cesd20 <= 20)

#en el texto que nos subio al campus estan todas las funciones de dplyr
#https://rpubs.com/jformoso/743247


select(depresion, cesd01, cesd02, cesd03)



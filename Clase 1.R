2+6+9

(2 + 6 + 9)/3

x <- 3

x

x+5

x <- x + 5

rm(x)
x

#crear un vector
edad <- c(2, 4, 1, 7, 9)
edad
edad + 5

edad / 3

edad^2

edad [4]

edad [2:4]

edad [c(2 , 4)]

edad_segmento <- c(2, 1)

edad_segmento <- edad[c(1, 3)]

x <- 3
rm (x)

sum(edad)

?sum()
length(edad)

sum(edad)/length(edad)

mean(edad)

typeof(edad)

edad_int <- as.integer(edad)
typeof(edad_int)


# Tipos de vectores -------------------------------------------------------

typeof(edad)
typeof(edad_int)

nombres <- c("Juan", "Pedro", "Marcos", "Ana", "María")
typeof(nombres)

sum(nombres)

edad_par <- c(TRUE, TRUE, FALSE, FALSE, FALSE)

typeof(edad_par)

sum(edad_par)

x <- c(1, 3, TRUE)
typeof(x)
sum(x)

X <- c(1, 3, "a")
typeof(X)
sum(X)

edad_texto <- c("4", "5", "9")
typeof(edad_texto)

edad_texto <- as.numeric(edad_texto)
typeof(edad_texto)

edad <- as.character(edad)
typeof(edad)

y <- c(1, 3, NA, 6)
typeof(y)
sum(y)

sum(y, na.rm = TRUE)

edad <- c(5, 3, "cuatro")
typeof(edad)
mean(edad)

edad <- as.numeric(edad)
mean(edad)
mean(edad, na.rm = TRUE)

which(is.na(edad))
is.na(edad)


# 1.crear un vector de caracteres y
# calcular la cantidad de elementos
VC <- c("a", "b", "c", "d")
length(VC)


# 2. crear un vector numerico que incluya
# 2NA y sumarlo

VN <- c(5, 3, NA, NA, 7)
sum(VN, na.rm = TRUE)

mean(VN, na.rm = TRUE)

# Crear  vectores que forman parte del mismo grupo de datos
# son  vectores relacionados

nombre <- c("Juan", "Marcos", "María")

edad <- c(15, 16, 21)

base <- data.frame(nombre, edad)
base

# como sería si no tengo la edad de uno 

nombre1 <- c("Juan", "Marcos", "María")
edad1 <- c(15, 16, NA)

base1 <- data.frame(nombre1, edad1)
base1

años_estudio <- c(6, 3, 10)

# suma los elementos que ocupan la misma posicion
# en los distintos vectores
edad + años_estudio

correctas <- c(20, 18, 15)

#si el total de preguntas es 25
correctas / 25

#si el total de preguntas es distinto en cada examen
total <- c(25, 20, 17)
correctas / total

#pedir un valor de la base requiere poner las dos dimensiones
#siempre va primero la fila y despues la columna
base[2, 2]
base[3, 1]

#si pongo solo un número me va a tirar toda esa columna
base[2]

#si pongo un número y dejo vacía la segunda posición, me tira la fila
base[2, ]

#para que me diga posiciones consecutivas
nombres[1:2]

#para extraer valores de posiciones no consecutivas
# tengo que usar la funciòn de combinar
nombres[c(2, 5)]

#para que me tire filas no consecutivas de la base, 
#uso combinar, pongo en parentesis las filas
#y dejo vacio el lugar de las columnas
base[c(1,2), ]

# ACTIVIDAD CLASE 1
a <- 2 + 1

x <- 2
x + 1

X<-3
rm(x)
x

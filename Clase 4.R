library(tidyverse)
library(readxl)
library(writexl)
library(haven)
read_csv("datos/Depresion.csv")
depresion <- read_csv("datos/Depresion.csv")
#archivos csv: comma separated values
#se abren con excel pero en vez de verse con un valor por celda, están separados por una coma todos juntos

glimpse(depresion) #para ver las variables y sus tipos
#las que se llaman "ahi" son todas del mismo cuestionario de felicidad
#las que se llaman "cesd" son del cuestionario de prevalencia de sintomas depresivos
#necesitamos chequear que todas sean de tipo numérico así se pueden sumar entre sí para tener los datos del cuestionario completo
count(depresion, occasion, intervention)
count(depresion, intervention)
count(depresion, occasion)

#hay 4 items para los que tener el puntaje mas alto es algo bueno y 4 para los que pasa lo contrario, 
#tenemos que invertirlo para que el criterio sea el mismo
#mutate_at me permite elegir varias variables simultaneamente para aplicar la misma modificacion a todas
#vars funciona de forma similar a select, dentro de vars elijo las variables que quiero modificar
depresion %>% 
  mutate_at(vars(cesd04, cesd08, cesd12, cesd16), function(x){5 - x}) %>% 
  select(cesd04) %>% #esto es para ver una variable y ver si se invirtió o no
  head(4)
#estamos inventando una función nueva en la que le pedimos que invierta los valores
#como los valores de esos vectores van del 1 al 4, la forma de invertirlos es pedirle que reste el valor de cada uno a 5
#entonces el 4 pasa a valer 1 (5-4), el 3 pasa a valer 2 (5-3), el 2 pasa a valer 3 (5-2) y el 1 pasa a valer 4 (5-1)

depresion %>% 
  select(cesd04) %>% 
  head(4)
#así podemos ver la original y ver si efectivamente se invirtieron los datos


depresion <- depresion %>% 
  mutate_at(vars(cesd04, cesd08, cesd12, cesd16), function(x){5 - x})
#así guardamos estas modificaciones en el dataframe, lo editamos para poder usarlo con los datos invertidos
#hay que tener cuidado cuando corremos esto de hacerlo 1 sola vez, porque si no volvemos a invertir los valores



#ahora queremos sumar todos los items de felicidad para crear la variable felicidad y todos los de depresion para crear la variable depresion
#le estamos pidiendo que sume las filas de todas las variables que empiecen con el prefijo "ahi" que son todas las preguntas del mismo cuestionario
depresion %>% 
  mutate(felicidad_AHI = rowSums(select(., starts_with("ahi"))))  #el punto dentro de select se usa para referir al dataframe depresion
#y ahora estamos haciendo lo mismo con las del cuestionario CESD
depresion %>% 
  mutate(felicidad_AHI = rowSums(select(., starts_with("ahi"))),
         depresion_CESD = rowSums(select(., starts_with("cesd")))) %>% 
  select(-starts_with("ahi"), -starts_with("cesd"), -elapsed.days)   #asi borramos todas las variables que teniamos para cada cuestionario y la variable elapsed days que no vamos a usar
#y nos quedamos solamente con las variables que queremos usar, que son las que generamos sumando las de cada cuestionario y otras que venian

#para crear una carpeta, ponemos directamente en la consola dir.create("Analisis depresion")
#si no también podemos hacerlo en el script y borrarlo, es pars hacerlo una sola vez y que no se corra cada vez que corremos el script
#por eso las cosas que necesitamos correr una unica vez no deberiamos dejarlas guardadas en el script
#tampoco deberíamos dejar cosas que modifiquen la computadora si vamos a compartir ese script con alguien

#genero un dataframe nuevo con estas columnas para armar el excel
depresion1 <- depresion %>% 
  mutate(felicidad_AHI = rowSums(select(., starts_with("ahi"))),
         depresion_CESD = rowSums(select(., starts_with("cesd")))) %>% 
  select(-starts_with("ahi"), -starts_with("cesd"), -elapsed.days)

write_xlsx(depresion1, "Analisis depresion/depresion.xlsx") #estoy generando un excel con el df depresion que creamos, dentro de la carpeta que creamos recien

#ahora vamos a cambiarle los nombres a las variables que tienen nombres en inglés por nombres en español
names(depresion1)[2:3] <- c("evaluacion", "intervencion") #con los corchetes selcciono las variables y con el operador de asignación les cambio el nombre

names(depresion1)

write_xlsx(depresion1, "Analisis depresion/depresion.xlsx")
#vuelvo a correr esta función para que en el archivo excel se guarden las variables con los nombres correspondientes
#cada vez que hago esto se sobreescribe el archivo, hay que tener cuidado por si hicimos modificaciones en el medio


#ahora creo 1 variable que me marca si los sujetos tienen depresion en funcion de los puntajes que tuvieron en el cuestionario
depresion1 <- depresion1 %>% 
  mutate(depresion_clinica = ifelse(depresion_CESD >= 26, "si", "no"))

count(depresion1)
count(depresion1, depresion_clinica)

#todo lo que hicimos hasta ahora fue limpiar la base de datos

#con ctrl+shift+R armamos un subtitulo
# Descriptivos ------------------------------------------------------------

depresion1 %>% 
  group_by(intervencion) %>% 
  summarise(Media_AHI = mean(felicidad_AHI), DE_AHI = sd(felicidad_AHI),
            Media_CESD = mean(depresion_CESD), DE_CESD = sd(depresion_CESD))
#con esto genero variables con la Media y el desvio estandar para los formularios de felicidad y depresion en la columna de intervencion
#si quiero puedo poner coma dentro de group by y agregar todas las columnas para las que quiero que me de eso


depresion1 %>% 
  group_by(intervencion) %>% 
  summarise(Media_AHI = mean(felicidad_AHI), DE_AHI = sd(felicidad_AHI),
            Min_AHI = min(felicidad_AHI), Max_AHI = max(felicidad_AHI),
            Media_CESD = mean(depresion_CESD), DE_CESD = sd(depresion_CESD),
            Min_CESD = min(depresion_CESD), Max_CESD = max(depresion_CESD))
#y así creo también variables con el valor maximo y minimo de cada una


#Guardar los descriptivos en un df llamado "descriptivos" y
#crear un archivo de excel llamado "Tabla de descriptivos.xlsx" 
#en la carpeta Analisis depresion


descriptivos <- depresion1 %>% 
  group_by(intervencion) %>% 
  summarise(Media_AHI = mean(felicidad_AHI), DE_AHI = sd(felicidad_AHI),
            Min_AHI = min(felicidad_AHI), Max_AHI = max(felicidad_AHI),
            Media_CESD = mean(depresion_CESD), DE_CESD = sd(depresion_CESD),
            Min_CESD = min(depresion_CESD), Max_CESD = max(depresion_CESD))

write_xlsx(descriptivos, "Analisis depresion/Tabla de descriptivos.xlsx")

#la idea de acostumbrarnos a hacer todo esto es que podamos hacer todo lo que necesitamos 
#desde R Studio, sin necesidad de usar otros programas


depresion1 %>% 
  group_by(intervencion) %>% 
  summarise_at(vars(felicidad_AHI, depresion_CESD),
               .funs = list(Mdia = mean, DE = sd, Minimo = min, Maximo = max))
#esto es otra forma de hacer lo mismo con menos texto, que es especialmente útil para cuando necesitamos
#hacerlo con muchas funciones
#es la forma acotada y mas correcta de hacerlo
#lq unica contra que tiene es que no podemos determinar el orden en el que van a quedar las columnas




# Gráficos ----------------------------------------------------------------

#el paquete que usamos para gráficos es parte de tidyverse y se llama ggplot
#permite cambiar y acomodar todo lo que nos guste
#ggplot encadena las lineas con +, no con pipes

#aes es aesthetics, es una funcion que nos permite trazar la matriz en que vamos a armar nuestro gráfico
#es para definir que vamos a poner en el eje x, en el eje y y algunas cosas más
#las figuras en ggplot se llaman geom
#los graficos los arma al costado en la pestaña de Plots

depresion1 %>% 
  ggplot(aes(felicidad_AHI)) + 
  geom_histogram()

depresion1 %>% 
  ggplot(aes(depresion_CESD)) + 
  geom_histogram()
#esto sirve para ver la distribucion de una variable continua

#para ver como se vinculan dos variables numericas entre si, podemos hacer un grafico de dispersion
#dentro de aes el primer valor siempre es el eje x y el segundo el y
depresion1 %>% 
  ggplot(aes(depresion_CESD, felicidad_AHI)) +
  geom_point() +
  geom_smooth()
#si lo dejo asi me tira la linea que mejor se ajuste a los datos
#si dentro de geom smooth pongo method = "lm" me tira una linea recta

depresion1 %>% 
  ggplot(aes(depresion_CESD, felicidad_AHI)) +
  geom_point() +
  geom_smooth(method = "lm")

#puedo poner que les ponga colores por variables, por ejemplo por intervencion
depresion1 %>% 
  ggplot(aes(depresion_CESD, felicidad_AHI, color = as_factor(intervencion))) +
  geom_point()
#as factor es para que no tome la variable como numerica, sino como factor

depresion1 %>% 
  ggplot(aes(depresion_CESD, felicidad_AHI, color = as_factor(intervencion))) +
  geom_point() +
  theme_classic() #con esto podemos ponerle un tema que cambia los colores y las formas
#hay varios paquetes con temas diferentes 
#el theme classic se parece bastante a lo que suelen pedir en normas APA

#para cambiar los nombres usamos labs
depresion1 %>% 
  ggplot(aes(depresion_CESD, felicidad_AHI, color = as_factor(intervencion))) +
  geom_point() +
  theme_classic() +
  labs(x = "Depresion", y = "Felicidad")

#cuando tenemos una variable continua y una categorica podemos hacer grafico de columnas
depresion1 %>% 
  ggplot(aes(depresion_clinica, felicidad_AHI)) +
  geom_col()
#asi me suma todas las variables

#y asi me lo hace con la media  
depresion1 %>% 
  group_by(depresion_clinica) %>% 
  summarise(Media = mean(felicidad_AHI)) %>% 
  ggplot(aes(depresion_clinica, Media)) +
  geom_col()

#para hacer graficos longitudinales
depresion1 %>% 
  group_by(intervencion, evaluacion) %>% 
  summarise(Media = mean(felicidad_AHI)) %>% 
  ggplot(aes(evaluacion, Media, color = as_factor(intervencion))) +
  geom_path()



depresion1 %>% 
  group_by(intervencion) %>% 
  summarise(Media = mean(felicidad_AHI)) %>% 
  ggplot(aes(intervencion, Media, fill = as_factor(intervencion))) +
  geom_col() +
  labs(fill = "Intervención", x = "Intervenciones", y = "Promedio de felicidad (AHI)") + 
  theme_classic()

#con esto marco las especificaciones que necesito que tenga mi grafico  
png(res = 300, height = 20, width = 15, units = "cm", 
    filename = "Analisis depresion/Gráfico de barras.png")
#primero pongo las especificaciones
#despues tengo que correr mi grafico
#y por ultimo corro dev off
dev.off()

#para armar mas de un grafico al mismo tiempo buscamos el paquete ggpubr y gridextra
#asi podemos armar matrices de graficos



# FOROS CON DATA DE R -----------------------------------------------------

#paginas confiables
#uno de los foros con respuestas mas confiables es stackoverflow
#tambien sthda.com que tiene material preparado
#otra es rpubs - es donde ella esta subiendo el material del taller
#tiene un tutorial de R que es jformoso.shinyapps.io/BienvenidosintroR
#sebastiansauer tiene lindas visualizaciones

#actividad final, nos manda una base con actividades y tenemos que hacer el script y mandarselo
#va a quedar abierto hasta el 30 de abril




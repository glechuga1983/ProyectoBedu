library(DBI)
library(RMySQL)
library(dplyr)
##conectar a base de datos
MyDataBasel <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "pruebas2",
  host = "localhost",
  username = "root",
  password = "")

##verificando la clase de base de datos
class(MyDataBasel)
##listando las tablas de la base de datos
dbListTables(MyDataBasel)



##Generando una consulta de las tablas

Consulta1 <- dbGetQuery(MyDataBasel, "select * from gastoscarteravalida
join gastoscarteradepositos on gastoscarteravalida.idValida = gastoscarteradepositos.idValidaD
WHERE gastoscarteradepositos.fechaDeposito BETWEEN '2019-01-01' and '2019-12-31'")

##analizando los montos de gastos 
summary(Consulta1$montoDeposito)
sum(Consulta1$montoDeposito)
dim(Consulta1)
##verificando a que concepto pertenece el monto de gastos mas alto del periodo
mayor<-Consulta1[which.max(Consulta1$montoDeposito),]

##verificando a que concepto pertenece el monto de gastos mas bajo del periodo
menor<-Consulta1[which.min(Consulta1$montoDeposito),]

##uniendo los dos resultados en un solo data frame
extremos<-as.data.frame(rbind(menor,mayor))
summary(Consulta1$montoDeposito)
##filtramos los gastos de chiapas
gChiapas<-filter(Consulta1, estado == "CHIAPAS")
dim(gChiapas)
##Guardamos de manera local la informacion obtenida
write.csv(Consulta1, "Vista_mysql.csv", row.names = FALSE)

Consulta2 <- dbGetQuery(MyDataBasel, "select * from gastoscarteravalida
join gastoscarteradepositos on gastoscarteravalida.idValida = gastoscarteradepositos.idValidaD
WHERE gastoscarteradepositos.fechaDeposito BETWEEN '2020-01-01' and '2020-12-31'")


sum(Consulta2$montoDeposito)
hist(Consulta2$montoDeposito,
     main = "Cantidad de Gastos 2020", 
     ylab = "Monto del Gasto",
     xlab = "Cantidad de Gastos",
     col = "green")
grid(nx = NA, ny = NULL, lty = 2, col = "gray", lwd = 1)
summary(Consulta2$montoDeposito)

##Comparando con un informe enviado del mismo periodo
##verificando el working directory
getwd()
##modificando el working Directory
setwd("C:/Users/RUGAL83LENOVO/OneDrive/R/Proyecto")
##buscando los archivos de trabajo
dir()
##leyendo el primer archivo de trabajo donde estan los datos globales
gtos<-read.csv("dep2019Glob.csv")
class(gtos)
dim(gtos)
str(gtos)

##verificando a que concepto pertenece el monto de gastos mas alto del periodo
mayor1<-gtos[which.max(gtos$montoDeposito),]

##verificando a que concepto pertenece el monto de gastos mas bajo del periodo
menor1<-gtos[which.min(gtos$montoDeposito),]

##uniendo los dos resultados en un solo data frame
extremos1<-as.data.frame(rbind(menor1,mayor1))

##Grafica para analizar la frecuencia de gastos por montos
hist(gtos$montoDeposito,
     main = "Cantidad de Gastos", 
     ylab = "Monto del Gasto",
     xlab = "Cantidad de Gastos",
     col = "green")
grid(nx = NA, ny = NULL, lty = 2, col = "gray", lwd = 1)
##Grafico de estado de gastos 
#1 Comprobado
#2 Parcial
#3 No Comprobado
#4 Quebranto
hist(gtos$Freq, breaks = 4,
     main = "Estado de los gastos", 
     ylab = "Cantidad de Gastos",
     xlab = "Estado de comprobacion",
     col = "blue")
grid(nx = NA, ny = NULL, lty = 2, col = "gray", lwd = 1)

##Verificamos la cantidad y concepto de los quebrantos
Quebrantos<-filter(gtos, Freq == "4")

##analizando los montos de gastos 
summary(Consulta1$montoDeposito)
summary(gtos$montoDeposito)
gChiapas<-filter(Consulta1, estado == "CHIAPAS")
dim(gChiapas)
gChiapas<-filter(gtos, estado == "CHIAPAS")
dim(gChiapas)
sum(gChiapas$montoDeposito)

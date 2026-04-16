#questo serve per scaricare dei dati
#https://code.earthengine.google.com/957b34097e4d6f4dc33ace082ec7cad7 clicchi questo
#apri la pagina fai nuovo progetto e inserisci pezzo di codice troviamo un codice "var aoi" lo eliminiamo cestinandolo
#poi creiamo un area of interest, si crea un poligono rettangolare con un tool
#si scrive al posto che geometry, "aoi" poi prenderà la mediana cambiando le da
#si clicca run e trova 
#si va nell' area a destra e si fanno partire i dati con run, che sono pesanti e vengono salvati nel drive

#questo ci trova tutti i dati sentinel nello spazio ed estre la mediana
#facciamo un markdown, come prima cosascriviamo il titolo
# si usano i backtick per scrivere i pacchetti ```r


library(terra) # package to manage spatial data
library(imageRy) # package for RS didactis

setwd("~/Desktop/")
getwd()
list.files()

richart <-rast("ISS074-E-417243.jpg")
richart <-flip(richart)
plot(richart)

png("prime_due_band.png")
im.multiframe(2,1)
plot(ice[[1]])
plot(ice[[2]])
dev.off()

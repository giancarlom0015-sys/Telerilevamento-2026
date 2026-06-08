
library(terra) # Pacchetto per l'analisi spaziale dei dati con vettori e dati raster
library(imageRy) # Pacchetto per manipolare, visualizzare ed esportare immagini raster in R
library(viridis) # Pacchetto per cambiare le palette di colori anche per chi è affetto da colorblindness
library(ggplot2)

#impostiamo la working directory
setwd("C:/Users/giancarlo/Desktop/TELERILEVAMENTO_ESAME")

#importiamo le immagini
wint24 <- rast("umbra_inverno_2024.tif")
plot(wint24)

sum24 <- rast("umbra_estate_2024.tif")
plot(sum24) 

#per plottare a colori naturaliiiii eheeeheeeheh
im.plotRGB(sum24, r = 3, g = 2, b = 1, title = "Foresta Umbra - Estate 2024")

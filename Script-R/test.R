# PROGETTO DI MISURAZIONE DELLA QUANTITA DI CLOROFILLA

# 1 Visualizzazione RGB
# 2 Calcolo degli indici per ciascuno, DVI, NDVI e pensavo di usare EVI
# 3 Analiso multi temporale  NDVI fra inverno e estate e EVI fra estate 2016 e estate 2024
# 4 Grafici comparativi delle analisi temporali
# 5 Conclusioni
#
# 2 grafici a seguire 
# 3 conclusioni
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

sum16 <- rast("umbra_estate_2016.tif")
plot(sum16)
#per plottare a colori naturaliiiii eheeeheeeheh
im.multiframe(1,3)
im.plotRGB(sum24, r = 3, g = 2, b = 1, title = "Foresta Umbra - Estate 2024")
im.plotRGB(wint24, r = 3, g = 2, b = 1, title = "Foresta Umbra - Inverno 2024")
im.plotRGB(sum16,  r = 3, g = 2, b = 1, title = "Foresta Umbra - Estate 2016")
dev.off()



# Indice DVI ((Difference Vegetation Index))
# NIR - RED
# Misura la quantità assoluta di vegetazione senza normalizzazionedvi_
dvi_sum24 = sum24[["B8"]] - sum24[["B4"]] # Calcolo DVI estate 24
dvi_wint24= wint24[["B8"]] - wint24[["B4"]] # Calcolo DVI inverno 24
dvi_sum16 = sum16[["B8"]] - sum16[["B4"]] # Calcolo DVI estate 16

ddvi = dvi_wint24 - dvi_sum24 # Differenza DVI fra estate/inverno 24
ddvi = dvi_sum16 - dvi_sum24 # Differenza DVI fra estati 16/24

im.multiframe(2, 3)
plot(dvi_wint24, main = "DVI Inverno 24' ", col=viridis::viridis(100)) # Visualizzazione DVI inverno
plot(dvi_sum24, main = "DVI Estate 24' ", col=viridis::viridis(100)) # Visualizzazione DVI estate 24
plot(dvi_sum16, main = "DVI Estate 16' ", col=viridis::viridis(100)) # Visualizzazione DVI estate 16

plot(ddvi, main = "ΔDVI estate/inverno 24' ", col=viridis::inferno(100)) 
plot(ddvi, main = "ΔDVI estate 16'/24' ", col=viridis::(100)) 




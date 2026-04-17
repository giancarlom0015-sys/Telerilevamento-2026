# Code for performing multitemporal analysis with satellite imagery

library(terra)
library(imageRy)
# install.packages("ggrdiges")
library(ggridges)


im.list()

EN_01 <- im.import("EN_01.png")
EN_01 <- flip(EN_01)
plot(EN_01)

EN_13 <- im.import("EN_13.png")
EN_13 <- flip(EN_13)
plot(EN_13)

# Exercise: plot the two images one on top of the other
im.multiframe(2,1)
plot(EN_01)
plot(EN_13)

# Differencing
ENdif <- EN_01[[1]] - EN_13[[1]] 
dev.off()
plot(ENdif)

# Greenland example

# Exercise: import all the greenland data and create a stack
g2000 <- im.import("greenland.2000.tif")
g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")
sg <- c(g2000, g2005, g2010, g2015)

gr <- im.import("greenland")

im.multiframe(1,2)
plot(gr[[1]], col=plasma(100))
plot(gr[[4]], col=plasma(100))


dif <- gr[[4]] - gr[[1]]
dev.off()
plot(dif)

# RGB
im.plotRGB(gr, r=1, g=2, b=4)

# da qui inizia la lezione

ndvi <- im.import("Sentinel2_NDVI_2020")

# una funzione, im.ridgeline
# ridgeline plotting
im.ridgeline(ndvi, scale=1, palette="viridis")

#il fatto è che qui si sovrascirve tutto e diventa un solo plot perchè i nomi sono tutti NDVI
per rinominare usare la funzione names

#per ovviare a questo problema si devono cambiare nomi
names(ndvi) <- c("02_feb", "05_may", "08_aug", "11_nov")

#cambiando scala, si può accentuale la composizione dei kernel density semplicemente con il tasto scale e il colore

plot(ndvi[[1]], ndvi[[2]])



# y = x
# y = a + b, questa è "l'equazione della linea con abline troviamo l' intercetta della linea [abline(0, 1)]

abline(0, 1 col="red")
# in questo caso però la linea non è dritta(obligua) perchè gli assi hanno una differenza
# cambiamo il nostro plot con un accorgimento, notiamo che

# x min 0.3
# y max 0.9

plot(ndvi[[1]], ndvi[[2]], xlim=c(-0.3,0.9), ylim=c(-0.3,0.9))

# ottimo questo plot per fare un analisi multitemporale


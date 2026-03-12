# R code for visualizing satellite images

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

install.packeges("viridis")

im.list()

# import images
b2 <-im.import("sentinel.dolomites.b2.tif")

#changing colors
cl <- colorRampPalette(c("darkorange", "#00FF00", "#FF69B4"))(100)
plot(b2, col=cl)

#viridis palettes
plot(b2, col=inferno(100))

#Exercise: plot band 2 with a greyscale palette
cl <- colorRampPalette(c("darkgrey","grey", "lightgret"))(100)
plot(b2, col=cl)

par(mfrow=c(1,2))
plot(b2, col=cl)
plot(b2, col=inferno(100))

dev.off()

im.multiframe(1,2)
plot(b2, col=cl)
plot(b2, col=inferno(100))

#creiamo uno stack e inseriamo le bande
b2 <- im.import("sentinel.dolomites.b2.tif") # blue  
b3 <- im.import("sentinel.dolomites.b3.tif") # green
b4 <- im.import("sentinel.dolomites.b4.tif") # red
b8 <- im.import("sentinel.dolomites.b8.tif") # NIR

sentinel <- c(b2, b3, b4, b8)

#PLOTTING RGB sistem
#layer 1 = b2 blue
#layer 2 = b3 green
#layer 3 = b4 red
#layer 4 = b8 NIR

plot(sentinel)
plot(
#im.gglot(b8) da inserire 

p1 <- im.ggplot(b8)
p2 <- im.ggplot(b4)

p1 + p2

  # la banda del blue che in sentinel è la banda numero 2 ma nel nostro stack è usata come numero 1
im.plotRGB(sentinel, r=3, g=2, b=1)
im.plotRGB(sentinel, r=4, g=3, b=2) #tutto quello che riflette la banda dell' infrarosso tutto quello che riflette bene la banda dell' infrarosso diventa rosso
im.plotRGB(sentinel, r=3, g=4, b=2)
im.plotRGB(sentinel, r=2, g=4, b=3)# in questo caso non cambia nulla
  
im.multiframe(1,2)
im.plotRGB(sentinel, r=3, g=4, b=2)
im.plotRGB(sentinel, r=2, g=4, b=3)

#correlazioni si
  pairs(sentinel)
  im.plotRGB(sentinel, r=2, g=3, b=4) #quando metti infrarosso sulla componente blue le parti di neve diventano gialle (ok lol)

  #plotting in RGB via terra
  plotRGB(sentinerl, r=4, g=3, b=2)
   plotRGB(sentinerl, r=4, g=3, b=2, stretch="lin")
   plotRGB(sentinerl, r=4, g=3, b=2, stretch="hist") #stretch istogramma, serve ad individuare per esempio, parti relazionate a scorrimento fiumi.
  #serve quando si vuole discriminare molto fra vari oggett(CMQ LA FUNZIONE SI PUò SCRIVERE SENZA FARE r=, g=, b=

  #RGB PLOTTINGbased on the ggplot2 RGB
  im.ggplot2
  

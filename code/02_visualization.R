# R code for visualizing satellite images

library(terra)
library(imageRy)

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

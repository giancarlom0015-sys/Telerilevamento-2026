library(terra)
library(imageRy)
library(viridis)

# listing files
im.list()

# importing data
mato1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992 <- flip(mato1992)

# l1=NIR l2=red l3=green
im.plotRGB(mato1992, 1, 2, 3) 
im.plotRGB(mato1992, 2, 1, 3)
im.plotRGB(mato1992, 2, 3, 1)

# ast significa astersatellite che ha risoluzione maggiore risperttok a lrg
# con flip giriamo l' immagine di 180 gradi che inverte il nord o sud dell' immagine

mato2006 <- im.import("matogrosso_ast_2006209_lrg.jpg") 
mato2006 <- flip(mato2006) 
im.plotRGB(mato2006, 1, 2, 3)

#esercizio mettere l eimmagini di fianco

im.multiframe(1, 2)
im.plotRGB(mato1992, 1, 2, 3) 
im.plotRGB(mato2006, 1, 2, 3)

#come si misura la biomassa? possiamo fare un indice spettraòe om cio uso varie banda

# DVI
# l1=NIR l2=red l3=green
# mettiamo un subset per indicare
dvi1992 <- mato1992[[1]] - mato1992[[2]]
dvi2006 <- mato2006[[1]] - mato2006[[2]]

plot(dvi1992)
plot(dvi2006)

# DVI by imageRy
dvi1992 = im.dvi(mato1992, 1, 2)
dvi2006 = im.dvi(mato2006, 1, 2)
plot(dvi1992, col=inferno(100))
plot(dvi2006, col=inferno(100))


# 8 bit
# NIR - red = 255 - 0 = 255 max DVI
# NIR - red = 0 - 255 = -255 min DVI
# range = -255, 255

# 2 bit-> 0-3
# NIR - red = 3 - 0 = 3 max DVI
# NIR - red = 0 - 3 = -3 min DVI

# assicurarsi che abbiano la stessa risoluzione radiometrica perchè qui cambia la risoluzione si usa questo

# NIR - red = (255 - 0) / (255 + 0) = 1 max NDVI
# NIR - red = (0 - 255) / (0 + 255) = -1 min NDVI

#applichiamolo all' immagine a a 2 bit e noto che a qualsiasi bit, si comparar tranquillamente a diversa risoluzione radiometrica

# NIR - red = (3 - 0) / (3 + 0) = 1 max NDVI
# NIR - red = (0 - 3) / (0 + 3) = -1 min NDVI

#come si fa? in questa maniera
# ndvi

ndvi1992 <- dvi1992 / (mato1992[[1]] + mato1992[[2]])
ndvi2006 <- dvi2006 / (mato2006[[1]] + mato2006[[2]]) 

#ora plottiamo tutto
im.multiframe(2,2)
plot(dvi1992)
plot(dvi2006)
plot(ndvi1992)
plot(ndvi2006)

#questa funzione

dvi1992= im.dvi(mato1992, 1, 2)


?im.dvi




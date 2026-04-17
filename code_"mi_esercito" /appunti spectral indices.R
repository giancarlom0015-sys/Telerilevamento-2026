#carichiamo le librerie
library(terra)
library(imageRy)
library(viridis)

#scarichiamo il file 

mato1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

#ora l' immagine sembra essere a testa in giù quindi adesso dobbiamo girarla con questo comando

mato1992 <- flip(mato1992)

# nella prossima, ci mette il NIR al layer 1, quindi mi sono chiesto, come potrei fare a capire da solo qual' è il layer 
# e a quale specifica radiaz. si riferisce? dunque ho scoperto che se guardiamo gli histogrammi notiamo che quello del NIR 
# va più a conto suo, è più compatto rispetto agli altri(probabilemtente perché le piante riflettono moltissimo NIR ad a bande più larghe
#lo si fa con questa funzione

im.multiframe(1,3) # che per qualche ragione non mi va mai( ho scoperto perchè, è perchè mettevo lo spazio)
hist(mato1992[[1]])
hist(mato1992[[2]])
hist(mato1992[[3]])

par(mfrow=c(1,3)) # in alternativa usa questo
hist(mato1992[[1]])
hist(mato1992[[2]])
hist(mato1992[[3]])


# l1=NIR l2=red l3=green
im.plotRGB(mato1992, 1, 2, 3)

#poi c'è questo esercizio che fa fare
# l1=NIR l2=red l3=green
im.plotRGB(mato1992, 1, 2, 3)

# Exercise: put NIR on top pof the green component of the RGB scheme
im.plotRGB(mato1992, 2, 1, 3)

# NIR ontop of the blue
im.plotRGB(mato1992, 3, 2, 1)

#ora vogliamo osservare la differenza fra la prima immagine e la seconda fatta in tampi più recenti per osservare la diversità
mato2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006 <- flip(mato2006)
im.plotRGB(mato2006, 1, 2, 3)

#e poi la si mette una fianco l' altra
im.multiframe(1,2) #per qualche ragione non mi va benissimo c'è da chiedere al prof perchè non va
im.plotRGB(mato1992, 1, 2, 3)
im.plotRGB(mato2006, 1, 2, 3)

#poi proviamo a inserire la funzione stretch
plotRGB(mato1992, 1,2,3, stretch="hist")
plotRGB(mato2006, 1,2,3, stretch="hist")

#plottiamo il NIR sul verde
im.plotRGB(mato1992, 2, 1, 3)
im.plotRGB(mato2006, 2, 1, 3)

#e plottiamo il NIR sul blue 
im.plotRGB(mato1992, 2, 3, 1)
im.plotRGB(mato2006, 2, 3, 1)

#adesso osserviamo come si comporta il DVI ricordiamoci che qui ci basiamo sulla differenza DVI=NIR-Red
# importante, come capiamo quanti bit ha l' immagine? osserviamo il range di dati, 
# se è a 8 bit, sarà a 255
# se è a 10 bit sarà 1023 ecc

# 8 bit
# NIR - red = 255 - 0 = 255 max DVI
# NIR - red = 0 - 255 = -255 min DVI

# range = -255, 255

dvi1992 <- mato1992[[1]] - mato1992[[2]]

# -------------------------------------------------------------------------
# CALCOLO DELL'INDICE NDVI (Normalized Difference Vegetation Index)
# -------------------------------------------------------------------------
# L'NDVI è un indice telerilevato utilizzato per stimare la salute della 
# vegetazione. Sfrutta la riflessione differenziale delle piante tra:
# - NIR (Infrarosso Vicino): Riflesso fortemente dalle cellule fogliari.
# - RED (Rosso): Assorbito dalla clorofilla per la fotosintesi.
#
# FORMULA: NDVI = (NIR - RED) / (NIR + RED)
#
# Nel codice seguente:
# - mato1992[[1]] rappresenta la banda NIR
# - mato1992[[2]] rappresenta la banda RED
# - dvi1992 è la differenza semplice (NIR - RED) calcolata precedentemente
#
# INTERPRETAZIONE DEI VALORI:
# - Vicino a +1: Vegetazione densa e sana
# - Vicino a 0: Suolo nudo, rocce
# - Valori negativi: Acqua o neve
# -------------------------------------------------------------------------

ndvi1992 <- dvi1992 / (mato1992[[1]] + mato1992[[2]])
ndvi2006 <- dvi2006 / (mato2006[[1]] + mato2006[[2]])

im.multiframe(1, 2)
plot(ndvi1992, col=inferno(100))
plot(ndvi2006, col=inferno(100))

par(mfrow=c(1,2))
plot(ndvi1992, col=inferno(100))
plot(ndvi2006, col=inferno(100))

#--------------------
#tramite imageRy
#--------------------

# DVI by imageRy
dvi1992 = im.dvi(mato1992, 1, 2)
dvi2006 = im.dvi(mato2006, 1, 2)
plot(dvi1992, col=inferno(100))
plot(dvi2006, col=inferno(100))

# NDVI via imageRy
ndvi1992 = im.ndvi(mato1992, 1, 2)
ndvi2006 = im.ndvi(mato2006, 1, 2)
plot(ndvi1992, col=mako(100))
plot(ndvi2006, col=mako(100))

# Exercise: plot DVIs and NDVIs for the two dates in two rows and columns
im.multiframe(2, 2)
plot(dvi1992, col=inferno(100))
plot(dvi2006, col=inferno(100))
plot(ndvi1992, col=magma(100))
plot(ndvi2006, col=magma(100))



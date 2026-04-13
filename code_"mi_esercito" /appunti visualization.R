# installo i pacchetti se serve altrimenti richiami le librerie

library(terra) 
library(imageRy)
library(devtools)
library(viridis)
library(ggplot2)
library(patchwork)
library(GGally)

#usiamo questa funzione per visualizzare i file nel nostro dataset

im.list()

# una volta fatto questo decido il file immagine che ho e vado a importarlo.
# il file importato proviene da github(credo boh) comunque per farlo arrivare da github e non dal CRAN,
# c'è bisgno didevtools che in pratica lo prende e lo rende disponibile su R

# con la funizione im.import ci limitermo al solo importare l' immagine e non a visualizzarla.

b2 <- im.import("sentinel.dolomites.b2.tif") 

# per visualizzare l' immagine si usa plot(b2)

plot(b2)

# ora vogliamo cambiare colore? no? vabbe lo faremo comunque.
# usiamo il sito Rchart https://r-charts.com/colors/ per avere i colori desiderati.
# inseriamo il numero del colore copiando e incollando dal sito. per esempio voglio aggiungere il "tomato, turquoise, violetred.
# il numero (100) sta a indicare le sfumature che ci saranno, immagina una colonna di 100 sfumature che si sviluppano fra tomato, turquoise, violetred 

# fai comunque molto attenzione alla punteggiatura che è quella che ti frega

cl <- colorRampPalette(c("tomato", "turquoise", "violetred"))(100)
plot(b2, col=cl) 

# con questa funzione avresti solamente 3 colori e ovviamente pare una roba strana 

cl <- colorRampPalette(c("tomato", "turquoise", "violetred"))(3)
> plot(b2, col=cl)

# con viridis si può selezionare e scegliere la palette appropriata con questa funzione

plot(b2, col=inferno(100))

# la seguente è una funzione per mettere due grafici in riga e colonna par(mfrow = c(R, C))
# il fatto è che questa è complessa ed è meglio sostituibile da im.multiframe(1, 2) di imageRy 

par(mfrow=c(1,2))
plot(b2, col=inferno(100))
plot(b2, col=cl)

# questa funzione serve in seguito per chiudere il plot precedente, è una sorta di reset

dev.off()

# qui la vera funzione di divisione in colonna

im.multiframe(1,2)
plot(b2, col=inferno(100))
plot(b2, col=cl)

# c'è poi un esercizio dove vengono importate delle immagini e poi ci fai un multiframe dove queste 4 immagini vengono visualizzate con 4 colori
# ricordati di assegnare oggetto alla funzione

b3 <- im.import("sentinel.dolomites.b3.tif")
b4 <- im.import("sentinel.dolomites.b4.tif")
b8 <- im.import("sentinel.dolomites.b8.tif")

im.multiframe(2,2)

# Exercise: multiframe with the four bands, legends: in line with the wavelength
clb <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(b2, col=clb)

clg <- colorRampPalette(c("dark green", "green", "light green"))(100)
plot(b3, col=clg)

clr <- colorRampPalette(c("#8B1A1A", "red", "pink"))(100)
plot(b4, col=clr)

cln <- colorRampPalette(c("goldenrod3", "goldenrod2", "goldenrod"))(100)
plot(b8, col=cln)

# credo che la prossima funzione serva solo perché aveva finito l'esercizio e voleva equiparare tutte le immagini
# le immagini comunque sono a diversi bit, una a 2 bit l' altra 3, 4 e 8 

plot(b2, col=inferno(100))
plot(b3, col=inferno(100))
plot(b4, col=inferno(100))
plot(b8, col=inferno(100))

sentinel <- c(b2, b3, b4, b8)
plot(sentinel)
plot(sentinel, col=inferno(100))

# questo comando serve a visualizzare la banda dell'Infrarosso Vicino (B8)
# fondamentale per distinguere la vegetazione sana (molto chiara) dall'acqua o rocce (scure).
# Il simbolo $ serve a "entrare" nell'oggetto principale per estrarre e utilizzare solo una sua parte specifica (come una singola banda spettrale).

#il fatto è che comunque questo comando non mi va quindi ho provaro a scrivere > sentinel su R e mi ha detto come si chiamano i file,
# quindi ho preso il quarto che si chiama fileb0843821981.tif e inserito al posto del nome del file 

plot(sentinel$sentinel.dolomites.b8) 

#a seguire quindi tutti le nostre immagini sono state divise in layer: # layer1=b2, layer2=b3, layer3=b4, layer4=b8
# con questo comando posso decidere di visualizzarne uno in particolare

plot(sentinel[[4]])
plot(sentinel[[2]])

# proseguiamo con la fase RGB uniamo ogni oggetto importato in una funzione 

sentinel <- c(b2, b3, b4, b8)

# a questo punto è importante sapere che a ogni layer è assegnato una banda dello spettro
# 1=b2 blue
# 2=b3 green
# 3=b4 red
# 4=b8 nir
# ora plottando RGB possiamo ottenere i "natural colors" oppure i "false colors" che sarebbero colori modificati
# il false color è ottimo perche col NIR(4) sul Rosso abbiamo maggiore contrasto
#puoi usare im.multiframe, solo che per qualche ragione non mi funziona a dovere quindi uso par(mfrow=c(1,2))

par(mfrow=c(1,2))# è faoltativo, questo lo usi solo se devi visualizzare insieme (!!PER QUALCHE RAGIONE ALTERNA SOLO LE IMMAGINI!!)

im.plotRGB(sentinel, r=3, g=2, b=1) # natural colors 
im.plotRGB(sentinel, r=4, g=3, b=2) # false colors

#la seguente si usa quando tutto ciò che è vegetazione viva e sana apparirà di un rosso acceso.

plot(sentinel[[4]])
im.plotRGB(sentinel, r=4, g=3, b=2) # false colors









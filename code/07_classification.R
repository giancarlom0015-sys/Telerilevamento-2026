# r CODE TO CLASSIFY R images

library(terra)
library(imageRy)
# set wd
setwd("C:/Users/giancarlo/Downloads")

im.list()
# import
#acquisisce dati sul sole
sun <-"Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg" 

#usiamo nuova funzione, seed lo si identifica con un numero
# classify prova im.classify
sunc <- im.classify(sun, num_clusters=3) 
sunc <- im.classify(sun, num_clusters=3, seed=19) 
#immagine grand canyon importiamola
  
can <- im.import("dolansprings_oli_2013088_canyon_lrg.jpg")
# facciamo la classificazione non visionata, i training site vengono definiti sulla base dello spettro,
#l' unica cosa che richiediamo sono i numeri di gruppi
canc <- im.classify(can, num_clusters=4, seed=19)

#oviamente il numero di pixel è influente prova a vedere il numero di pixel con ncell(can) e ncell(can)
#importiamo immagine dalla working directory (scaricato immagine in download da vedere come si fa con la working directory)
download
dji <- rast("ZZZ.jpeg")                                                             

dji <- flip(dji)
plot(dji)

djic <- im.classify(dji, num_clusters=2)

#classifying mato grosso
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg") 
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")   

im.multiframe(1,2)
plot(m1992)
plot(m2006) #possiamo osservare la parte antropizzata e la parte forestale quindi accontentiamoci di due claster
m1992c <- im.classify(m1992, seed=42, num_clusters=2)#qui si notano le due classi, ora rinominamo le classi

#scrvi m1992c su R e noti che ci sono le due classi

# Assign labels #questo è copiato dal prof e trasforma le classi in nomi specifici

levels(m1992c) <- data.frame(
  value = c(1, 2),
  label = c("forest", "human")
)
# rifacciamo la stessa cosa col 2006

m2006c <- im.classify(m2006, seed=42, num_clusters=2)

# Assign labels
levels(m2006c) <- data.frame(
  value = c(2, 1),
  label = c("forest", "human")
)

#da questi grafic voglio calcolarmi le percentuali di forseta e di umano
#percentes, osserviamo la frequesza che si riferisc ai pixel x classi basta scriver

# Calculating frequencies
f1992 <- freq(m1992c) 

prop1992 <- f1992$count / ncell(m1992c)

#se poi io scrivo
prep1992 #avrò le percentuali

# rifacciamo la stessa cos aper un altro
# Calculating frequencies
f2006 <- freq(m2006c) 

prop2006 <- f2006$count / ncell(m2006c)

perc2006 <- prop2006 * 100
 #e adesso abbiamo i dati per fare un grafico e creiamo un atabellina
#dobbiamo crearci le tre colonne con data.frame
tabout <- data.frame(
  class=c("forest", "human")
  perc1992=c(83,17), #osserviamo i valori
  perc2006=c(45,55)

  )

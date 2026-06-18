# PROGETTO DI MONITORAGGIO DELLO STATO DELLA VEGETAZIONE DELLA FORESTA UMBRA

# 1  VISUALIZAZZIONE RGB
# 2  CALCOLO DEGLI INDICI SPETTRALI (DVI, NDVI, EVI)
# 3  ANLISI MULTITEMPORALE E COMPARATIVA
# 4  VISUALIZZAZZIONE GRAFICA  E ANALISI 
# 5  CONCLUSIONI


library(terra) # Pacchetto per l'analisi spaziale dei dati con vettori e dati raster
library(imageRy) # Pacchetto per manipolare, visualizzare ed esportare immagini raster in R
library(viridis) # Pacchetto per cambiare le palette di colori anche per chi è affetto da colorblindness
library(ggplot2) # per la costruzione dei grafici  
library(patchwork) # per la composizione di più plot grafici (capacità che manca a ggplot)

# Impostiamo la working directory
setwd("C:/Users/giancarlo/Desktop/TELERILEVAMENTO_ESAME")

# importiamo le immagini satellitari
wint24 <- rast("umbra_inverno_2024.tif")
sum24 <- rast("umbra_estate_2024.tif")
sum18 <- rast("umbra_estate_2018.tif")

# Plot
plot(wint24)
plot(sum24)
plot(sum18)

# plot RGB
im.multiframe(1,3)
im.plotRGB(sum24, r = 3, g = 2, b = 1, title = "Foresta Umbra - Estate 2024")
im.plotRGB(wint24, r = 3, g = 2, b = 1, title = "Foresta Umbra - Inverno 2024")
im.plotRGB(sum18,  r = 3, g = 2, b = 1, title = "Foresta Umbra - Estate 2018")
dev.off()

#======================================================================================================================0

# Indice DVI ((Difference Vegetation Index))
# NIR - RED
# Misura la quantità assoluta di vegetazione senza normalizzazionedvi_
dvi_sum24 = sum24[["B8"]] - sum24[["B4"]] # Calcolo DVI estate 24
dvi_wint24= wint24[["B8"]] - wint24[["B4"]] # Calcolo DVI inverno 24
dvi_sum18 = sum18[["B8"]] - sum18[["B4"]] # Calcolo DVI estate 16

ddvi = dvi_wint24 - dvi_sum24 # Differenza DVI fra estate/inverno 24
ddvi = dvi_sum18 - dvi_sum24 # Differenza DVI fra estati 16/24

im.multiframe(2, 3)
plot(dvi_wint24, main = "DVI Inverno 24' ", col=viridis::viridis(100)) # Visualizzazione DVI inverno
plot(dvi_sum24, main = "DVI Estate 24' ", col=viridis::viridis(100)) # Visualizzazione DVI estate 24
plot(dvi_sum18, main = "DVI Estate 18' ", col=viridis::viridis(100)) # Visualizzazione DVI estate 16

im.multiframe(2,1)
plot(ddvi, main = "ΔDVI Stagionale' ", col=viridis::inferno(100)) 
plot(ddvi, main = "ΔDVI Temporale' ", col=viridis::inferno(100)) 


#===================================================================================================================0
 # NDVI

# Indica la salute della vegetazione.
# Valori vicini a 1: vegetazione sana e rigogliosa.
# Valori vicini a 0 o negativi: suolo nudo, acqua o aree degradate.

ndvi_wint24 = (wint24[["B8"]] - wint24[["B4"]]) / (wint24[["B8"]] + wint24[["B4"]]) 
ndvi_sum24 = (sum24[["B8"]] - sum24[["B4"]]) / (sum24[["B8"]] + sum24[["B4"]])
ndvi_sum18 = (sum18[["B8"]] - sum18[["B4"]]) / (sum18[["B8"]] + sum18[["B4"]]) 

dndvi_stagionale = ndvi_sum24 - ndvi_wint24 #differenza NDVI
dndvi_temporale = ndvi_sum24 - ndvi_sum18 

im.multiframe(1,3)  #  Visualizzazione di un pannello grafico con 1 righa e 3 colonne
plot(ndvi_wint24, main="NDVI Inverno 24' ", col=viridis::viridis(100)) 
plot(ndvi_sum24, main="NDVI Estate 24'", col=viridis::viridis(100)) 
plot(ndvi_sum18, main="NDVI Estate 18'", col=viridis::viridis(100)) 

im.multiframe(1,2)
plot(dndvi_stagionale, main="ΔNDVI Stagionale", col=colorRampPalette(c("red", "white", "blue"))(100))  
# qui si nota come c'è aumento della biomassa fogliare dall' inverno all' estate
plot(dndvi_temporale, main="ΔNDVI Temporale", col=colorRampPalette(c("red", "white", "blue"))(100)) 
#Segno Positivo : Significa che il valore del 2024 è più alto di quello del 2018. C'è stato un incremento del vigore vegetativo o della biomassa fogliare.
#Segno Negativo : # Significa che il valore del 2024 è più basso del 2018. C'è stata una perdita di vigore, un potenziale degrado o uno stress idrico.
#Intorno allo Zero : Significa che la Foresta Umbra è rimasta perfettamente stabile.XX

dev.off() 

#===========================================================================================================================0
# EVI
# Calcolo EVI estate 24
evi_sum24 = 2.5 * ((sum24[[4]] - sum24[[3]]) / (sum24[[4]] + 6 * sum24[[3]] - 7.5 * sum24[[1]] + 1))
evi_sum18 = 2.5 * ((sum18[[4]] - sum18[[3]]) / (sum18[[4]] + 6 * sum18[[3]] - 7.5 * sum18[[1]] + 1))


devi_temporale = evi_sum24 - evi_sum18

im.multiframe(2,1)
plot(evi_sum18, main = "EVI Estate 18'", col= viridis::viridis(100), range = c(-1, 1))
plot(evi_sum24, main = "EVI Estate 24'", col= viridis::viridis(100), range = c(-1, 1))


# Valori Alti 0.6 / 1.0 [Colore Verde/Giallo]: Foresta densa, massima presenza di clorofilla e chiome completamente chiuse
# (Estate 2018 e 2024).
#Valori Medi 0.2 / 0.0 [Colore Blu/Viola]: Vegetazione diradata, pascoli o foresta nel minimo stagionale 
# (Inverno 2024 con i faggi spogli).
#Valori Vicini a 0: Assenza di vegetazione (suolo nudo, roccia, asfalto, acqua)

plot(devi_temporale, main = "ΔEVI Temporale", col=colorRampPalette(c("red","white","darkgreen"))(100))
# Values description: The range of values for EVI is -1 to 1, with healthy vegetation generally around 0.20 to 0.80.


#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

# ANALISI MULTITEMPORALE
NDVI

soglia = 0.7 # Soglia NDVI per distinguere vegetazione/non vegetazione
classe_invernale=classify(ndvi_wint24,  rcl=matrix(c(-Inf,soglia,0, soglia,Inf,1), ncol=3, byrow=TRUE))
classe_estiva24=classify(ndvi_sum24, rcl=matrix(c(-Inf,soglia,0, soglia,Inf,1), ncol=3, byrow=TRUE))
classe_estiva18=classify(ndvi_sum18, rcl=matrix(c(-Inf,soglia,0, soglia,Inf,1), ncol=3, byrow=TRUE))

im.multiframe(3,1)
plot(classe_invernale,  main="Classi NDVI Invernale24",  col=c("red","green"))
plot(classe_estiva24, main="Classi NDVI Estiva24", col=c("red","green"))
plot(classe_estiva18, main="Classi NDVI Estiva18", col=c("red","green"))


freq_24 = freq(classe_estiva24) 
freq_18 = freq(classe_estiva18)
freq_wint = freq(classe_invernale)

perc_24 = freq_24$count  * 100 / ncell(classe_estiva24)
perc_18 = freq_18$count * 100 / ncell(classe_estiva18)
perc_wint = freq_wint$count * 100 / ncell(classe_invernale)

tabella = data.frame(
  Classe = c("Vegetazione Diradata / Suolo", "Foresta matura"),
  Estate_2018 = round(perc_18,2),
  Estate_2024= round(perc_24,2),
  Inverno = round(perc_wint,2)
  
 )
  print(tabella)

#Classe                         sum18     sum24    wint
#1 Vegetazione Diradata / Suolo  16.1       22    14.44
#2               Foresta matura  83.9       78    85.56

#========================================================================================================================
# GRAFICO COMPARATIVO GGPLOT NDVI

df_long = melt(tabella, id.vars="Classe",                       # Converte la tabella in formato lungo per il grafico
                variable.name="Periodo",
                value.name="Percentuale")

                                
ggplot(df_long, aes(x=Classe, y=Percentuale, fill=Periodo)) +   # Crea Grafico assegnando X, Y e colore
  geom_bar(stat="identity", position="dodge", color = "black") +  # Barre affiaancate per confrontare i periodi
  geom_text(aes(label=round(Percentuale,1)),                    # Aggiunge i valori sulle barre
            position=position_dodge(width=0.9),                 # Allinea il testo sulle barre affiancate
            vjust=-0.25,                                        # Sposta leggermente sopra le barre
            size=3) +                                           # Dimensione testo
  scale_fill_manual(values = c("Estate_2018" = "#008B00",  # Colori distinti per i periodi
                               "Estate_2024" = "#00FF00",
                               "Inverno" = "lightskyblue")) +                                      
  ylim(0,100) +                                                 # Limiti asse Y 0-100%
  labs(title="Copertura forestale (NDVI > 0.6)",              # Titoli ed etichette
       y="Percentuale (%)", x="Classe NDVI") +
  theme_grey()        
#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

 #ANALISI MULTITEMPORALE EVI (ENHANCED VEGETATION HINDEX)

soglia = 0.5 # Soglia EVI per distinguere vegetazione/non vegetazione

classe_estiva24=classify(evi_sum24, rcl=matrix(c(-Inf,soglia,0, soglia,Inf,1), ncol=3, byrow=TRUE))
classe_estiva18=classify(evi_sum18, rcl=matrix(c(-Inf,soglia,0, soglia,Inf,1), ncol=3, byrow=TRUE))

im.multiframe(1,2)
plot(classe_estiva18, main="Classi EVI Estiva18", col=c("red","green"))
plot(classe_estiva24, main="Classi EVI Estiva24", col=c("red","green"))

#tabella 
freq_24 = freq(classe_estiva24) 
freq_18 = freq(classe_estiva18)

perc_24 = freq_24$count  * 100 / ncell(classe_estiva24)
perc_18 = freq_18$count * 100 / ncell(classe_estiva18)

tabella = data.frame(
  Classe = c("Vegetazione rada", "Foresta matura"),
  Estate_2018 = round(perc_18,2),
  Estate_2024= round(perc_24,2)
 
  
 )
  print(tabella)

#Classe Estate_2018 Estate_2024
#1 Vegetazione rada       44.41       52.24
#2   Foresta matura       55.59       47.76

# GRAFICO COMPARATIVO GGPLOT NDVI

df_long = melt(tabella, id.vars="Classe",                       # Converte la tabella in formato lungo per il grafico
                variable.name="Periodo",
                value.name="Percentuale")

                                
ggplot(df_long, aes(x=Classe, y=Percentuale, fill=Periodo)) +   # Crea Grafico assegnando X, Y e colore
  geom_bar(stat="identity", position="dodge", color = "black") +  # Barre affiaancate per confrontare i periodi
  geom_text(aes(label=round(Percentuale,1)),                    # Aggiunge i valori sulle barre
            position=position_dodge(width=0.9),                 # Allinea il testo sulle barre affiancate
            vjust=-0.25,                                        # Sposta leggermente sopra le barre
            size=3) +                                           # Dimensione testo
  scale_fill_manual(values = c("Estate_2018" = "#008B00",  # Colori distinti per i periodi
                               "Estate_2024" = "#00FF00")) +
                                                                    
  ylim(0,100) +                                                 # Limiti asse Y 0-100%
  labs(title="Copertura forestale (EVI > 0.5)",              # Titoli ed etichette
       y="Percentuale (%)", x="Classe NDVI") +
  theme_grey()        
#______________________________________________________________________________________________________________
#_______________________________________________________________________________________________________________



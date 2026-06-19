# PROGETTO DI MONITORAGGIO DELLO STATO DELLA VEGETAZIONE DELLA FORESTA UMBRA 🌳
## Esame telerilevamento geo-ecologico in R - 2026
### Giancarlo Maggi

/
/

# INTRODUZIONE
###
La riserva naturale Foresta Umbra è un'area naturale protetta posta all'interno del Parco nazionale del Gargano. Si estende nella zona centro-orientale del Gargano, a circa 800 metri di altitudine. La Foresta Umbra occupa un'area di circa 15.000 ettari. La vegetazione che ricopre la Foresta è composta principalmente da faggete vetuste le quali sono relitti glaciali e raggiungono grandi dimensioni nonostante le quote inferiori a cui questi alberi vivono normalmente, per queste particolarità a partire dal 7 luglio 2017 le sue faggete vetuste sono entrate a far parte del patrimonio UNESCO. Il riscldamento globale comporta diversi contributi negativi che tendono a compromettere la salute delle foreste. Tra questi, gli esempi più rilevanti sono  migrazione altitudinale delle specie vegetale e un cambiamento nella fenologia delle specie arboree.

Lo scopo del progetto è quindi quello di analizzare le variazioni multitemporali della copertura vegetale attravarso diversi indici al fine di valutare lo stato di salute e la risposta dell' ecosistemi forestale.

<p align="center">
 <img src="https://github.com/giancarlom0015-sys/Telerilevamento-2026/blob/main/Script-R/img/area_studio.jpg.png?raw=true" width="1000">
</p>
Le immagini appartengono ai seguenti archi temporali:
- Estate: 01/07/2018 - 31/08/2018
- Estate: 01/07/2024 - 31/08/2024
- Inverno: 01/01/2024 - 29/02/2024
  
Gli indici utilizzati sono:
- DVI
- NDVI
- EVI

# Metodologia🛰️ 

## Raccolta delle immagini📂 

Le immagini satellitari provengono da [**Google Earth Engine**](https://earthengine.google.com/) selezionando l'area dell'incendio e le date indicate.
> [!NOTE]
> Il codice JavaScript utilizzato è quello fornito durante il corso ed è disponibile nel file Codice.js

## Innanzitutto impostiamo la libreria
````r
library(terra)     # Pacchetto per l'analisi spaziale dei dati con vettori e dati raster
library(imageRy)   # Pacchetto per manipolare, visualizzare ed esportare immagini raster in R
library(viridis)   # Pacchetto per cambiare le palette di colori anche per chi è affetto da colorblindness
library(ggplot2)   # per la costruzione dei grafici  
library(patchwork) # per la composizione di più plot grafici (capacità che manca a ggplot)
````

## Importazione e set up della working directory
````r
setwd("C:/Users/giancarlo/Desktop/TELERILEVAMENTO_ESAME")
````

# importiamo le immagini satellitari
````r
wint24 <- rast("umbra_inverno_2024.tif") #INVERNO
sum24 <- rast("umbra_estate_2024.tif")   #ESTATE 2018
sum18 <- rast("umbra_estate_2018.tif")   #ESTATE 2018
````



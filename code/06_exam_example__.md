# Questo è il titolo del mio markdowun

area di studio

## pacchetti utilizzati

per quesssto esame usiamo questi pacchetti

``` r
library(terra) # pacchetto per ......
```
## importazione dei dati

i dati sono stati 

il codice utilizzato è il seguente; prima di tutto selezioniamo la working directory:
``` r
setwd("~/Desktop/")
getwd()
list.files()
```
per importare dei dati è stata utilizzata la funzione `rast()` del pacchetto `terra`:

richart <-rast("ISS074-E-417243.jpg")
richart <-flip(richart)
plot(richart)





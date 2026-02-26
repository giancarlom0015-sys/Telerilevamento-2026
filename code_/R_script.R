#First R scritp

2+3

michele <- 2+3
michele = 2+3

giancarlo <- 4+6
#tutte le operazioni 

giancarlo + michele 
# arrays o vettori

sonia  <- c(10, 8, 3, 1, 0)  #funzione e argomenti
giorgia <- c(3, 10, 20, 50, 100) 

plot(giorgia, sonia)
plot(giorgia, sonia, col="blue",pch=19)
plot(giorgia, sonia, col="blue",pch=19, cex=2)
plot(giorgia, sonia, col="blue",pch=19, cex=2, xlab="pollution", ylab="numero di delfini")

# installazione pachhetti
#CRAN
install.packages("terra")
library(terra)

install.packages("imageRy")

#GitHUb
Install.packages("devtools") # remote
library(devtools)
install_github("ducciorocchini/imageRy")



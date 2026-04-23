library(qrcode)
 
url <- "https://github.com/giancarlom0015-sys/Telerilevamento-2026/new/main/code"
 
qr <- qr_code(url)
 
png("github_profile_qr.png", width = 1000, height = 1000)
plot(qr)

set

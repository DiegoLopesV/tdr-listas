dados <- read.csv("airquality.csv")

pdf("figura.pdf", width = 7, height = 5)
boxplot(
  Ozone ~ Month,
  data = dados,
  names = c("Maio", "Junho", "Julho", "Agosto", "Setembro"),
  xlab = "Mês",
  ylab = "Concentração de ozônio (ppb)",
  col = "lightblue",
  pch = 20
)
dev.off()

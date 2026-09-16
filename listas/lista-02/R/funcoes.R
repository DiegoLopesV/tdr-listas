## Funções do pipeline: Temp ~ Wind (airquality)

## Lê o CSV e acrescenta a coluna Mes como fator com nomes em português
ler_dados <- function(caminho) {
  nomes_meses <- c(
    "5" = "Maio", "6" = "Junho", "7" = "Julho",
    "8" = "Agosto", "9" = "Setembro"
  )
  dados <- read.csv(caminho)
  dados$Mes <- factor(
    nomes_meses[as.character(dados$Month)],
    levels = c("Maio", "Junho", "Julho", "Agosto", "Setembro")
  )
  dados
}

## Calcula a média mensal de Temp e Wind, ignorando NAs
medias_mensais <- function(dados) {
  aggregate(
    cbind(Temp, Wind) ~ Mes,
    data = dados,
    FUN = mean,
    na.action = na.pass,
    na.rm = TRUE
  )
}

## Ajusta o modelo linear Temp ~ Wind e devolve o objeto lm
ajustar_modelo <- function(dados) {
  lm(Temp ~ Wind, data = dados)
}

## Grava a dispersão Temp × Wind com a reta ajustada em um PNG e devolve o caminho
desenhar_dispersao <- function(dados, modelo, caminho) {
  png(caminho, width = 800, height = 600, res = 120)
  plot(
    Temp ~ Wind, data = dados,
    xlab = "Velocidade do vento (mph)",
    ylab = "Temperatura (°F)",
    main = "Temperatura em função do vento — New York, 1973",
    pch = 19, col = "#2c7bb6"
  )
  abline(modelo, col = "red", lwd = 2)
  dev.off()
  caminho
}

exportar_medias <- function(medias, caminho) {
  write.csv(medias, caminho, row.names = FALSE)
  caminho
}

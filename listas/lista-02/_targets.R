library(targets)
library(tarchetypes)

tar_source("R")

list(
  tar_target(arquivo, "dados/airquality.csv", format = "file"),
  tar_target(dados, ler_dados(arquivo)),
  tar_target(medias, medias_mensais(dados)),
  tar_target(modelo, ajustar_modelo(dados)),
  tar_target(figura, desenhar_dispersao(dados, modelo, "saidas/figura.png"), format = "file"),
  tar_target(csv_medias, exportar_medias(medias, "saidas/medias.csv"), format = "file")
)

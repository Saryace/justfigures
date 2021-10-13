library(tidyverse)
library(readxl)
library(ggthemr)
library(ggdist)
library(ggeconodist)
library(hrbrthemes)

educational_data <-
  readxl::read_xlsx("data/ofertapregrado2021_0.xlsx",
                    sheet = 2)

educational_data_filtered <- educational_data %>%
  filter(
    stringr::str_detect(
      `Grado Académico`,
      'Agronomía|agronomía|Agronómicas|agronómicas|
                             Agronomia|agronomia|Agronomicas|agronomicas'
    )
  ) %>%
  mutate(costo = (
    `Valor de matrícula` +
      (`Duración (en semestres)` / 2) * `Valor de arancel` +
      `Valor del Título`
  ) / 1000000) %>%
  filter(costo > 1) %>%
  filter(`Duración (en semestres)` > 3)

ggthemr('grape')

educational_data_filtered %>%
  ggplot(aes(x = factor(`Duración (en semestres)`), y = costo)) +
  geom_econodist(width = 0.25) +
  coord_flip() +
  labs(
    x = "Duración de la carrera en semestres",
    y = "Arancel total (millones de pesos)",
    title = "Arancel total de carreras agronómicas en Chile (2021)",
    subtitle = "Carreras cuyo grádo académico mencione `agronómica` o `agronómicas`",
    caption = "Datos del CNED"
  ) +
  theme(plot.margin = unit(c(2.5, 1, 2.5, 1), "cm")) +
  theme(plot.background = element_rect(fill = "paleturquoise3"))


ggsave("plots/plot29.png")

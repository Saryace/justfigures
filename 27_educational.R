library(tidyverse)
library(readxl)
library(ggthemr)
library(ggdist)

educational_data <-
  readxl::read_xlsx("data/ofertapregrado2021_0.xlsx",
                    sheet = 2)

educational_data_filtered <- educational_data %>%
  filter(
    stringr::str_detect(
      `Grado Académico`,
      'Ambiente|ambiente|Ambiental|ambiental|Ambientales|ambientales'
    )
  ) %>%
  mutate(costo = (
    `Valor de matrícula` +
      (`Duración (en semestres)` /
         2) * `Valor de arancel` +
      `Valor del Título`
  ) / 1000000) %>%
  filter(costo > 1)

ggthemr('dust')
ggplot(educational_data_filtered , aes(x = costo)) +
  stat_halfeye() +
  labs(
    y = "",
    x = "Arancel total (millones de pesos)",
    title = "Arancel total de carreras ambientales en Chile (2021)",
    subtitle = "Carreras cuyo grádo académico mencione `ambiente` o `ambiental`",
    caption = "Datos del CNED 2021"
  ) +
  scale_colour_ggthemr_d() +
  scale_x_continuous(minor_breaks = seq(0 , 30, 2), breaks = seq(0, 30, 2)) +
  theme(axis.text.y = element_blank()) +
  theme(plot.margin = unit(c(2.5, 1, 2.5, 1), "cm"))


ggsave("plots/plot27.png")

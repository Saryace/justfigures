library(tidyverse)
library(lubridate)

climate_change <-
  read.csv(file = "data/catalog.csv",
           TRUE,
           sep = ",",
           stringsAsFactors = FALSE)

climate_change_plot <- climate_change %>%
  mutate(
    date = as.character(date),
    year = str_sub(date,-2,-1),
    anio = as.numeric(year) + 2000
  ) %>%
  group_by(anio) %>%
  dplyr::summarise(n = n(),
                   pop = round(sum(population / 1000000), 1))

ggplot(data = climate_change_plot, aes(x = anio, y = n, fill = pop)) +
  geom_col() +
  scale_x_continuous(breaks = seq(2007, 2017, by = 1)) +
  geom_text(aes(label = pop),
            angle = 90,
            position = position_stack(vjust = 0.5)) +
  scale_fill_continuous(name = "People affected\n(millions)",
                        low = "beige", high = "brown") +
  labs(x = "year", y = "number of landslides per year") +
  theme(panel.background =
          element_rect(fill = "white", colour = "grey50")) +
  theme_dark() +
  theme(plot.margin = unit(c(3, 1, 3, 1), "cm")) +
  ggtitle("Worldwide occurrence of landslides per year [2007-2016]\nDataset from kaggle.com")



ggsave("plots/plot19.png")



library(ggblur)
library(magick)
library(tidyverse)
library(ggthemr)

soil_future <- read.csv(file = "data/query.csv")

ggthemr("grass")

soil_future %>% mutate(energy = 10 ^ (5.24 + 1.44 * mag)) %>%
  ggplot(aes(x = as.Date(time), y = mag)) +
  geom_point(aes(size = energy)) +
  geom_point(
    data = subset(soil_future,
                  mag > 7.9),
    shape = 21,
    size = 8,
    col = "red"
  ) +
  geom_line() +
  labs(
    x = "Years",
    y = "Richter Magnitude",
    title = "Earthquakes in Chile and its neighborhood\nover 7.0 Richter Magnitude in the last four decades",
    caption = "Data from USGS.gov"
  ) +
  scale_x_date(date_breaks = "5 years", date_labels = "%Y") +
  theme(axis.text.x = element_text(
    angle = 90,
    vjust = 0.5,
    hjust = 1
  )) +
  theme(plot.margin = unit(c(2.5, 1, 2.5, 1), "cm"))

ggplot2::ggsave("plots/plot28.png")




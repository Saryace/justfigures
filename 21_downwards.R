library(tidyverse)
library(hrbrthemes)

model <-
  loess(
    Year ~ Maximum.ozone.hole.area..square.kilometres.,
    data = ozone_area ,
    span = 0.75
  )

ozone_area <-
  read.csv(file = "data/antarctic-ozone-hole-area.csv",
           TRUE,
           sep = ",",
           stringsAsFactors = FALSE)

ggplot(data = ozone_area,
       aes(x = Year,
           y = Maximum.ozone.hole.area..square.kilometres.)) +
  geom_line() +
  scale_x_continuous(breaks = seq(1979, 2017, by = 4)) +
  stat_smooth(method = "loess", span = 0.75) +
  labs(
    x = "year",
    y = "Area (km2) of the Antarctic ozone hole",
    title = "Depletion of the ozone layer has stopped",
    caption = "Data from kaggle.com"
  ) +
  theme_ft_rc() +
  theme(plot.margin = unit(c(2.5, 1, 2.5, 1), "cm"))


ggsave("plots/plot21.png")

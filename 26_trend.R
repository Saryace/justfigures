library(tidyverse)
library(lubridate)
library(gghighlight)
library(hrbrthemes)
library(ggrepel)

soil_trend <- read.csv(file = "data/soil_science.csv")

soil_trend$names <- rownames(soil_trend)

soil_trend_plot <-
  soil_trend %>%
  rename(Data = 1, Time = 2) %>%
  slice(-1) %>%
  mutate(Time = ymd(Time), Data = as.numeric(Data))

ggplot(soil_trend_plot, aes(
  x = as.Date(Time),
  y = Data,
  label = paste(Data, "%", as.character(Time))
)) +
  geom_point() +
  geom_line() +
  geom_point(
    data = subset(soil_trend_plot,
                  Data > 90),
    shape = 21,
    size = 4,
    col = "red"
  ) +
  geom_label_repel(
    data = subset(soil_trend_plot,
                  Data > 90),
    box.padding = 0.5,
    max.overlaps = 10
  ) +
  labs(
    x = "Date (last five years)",
    y = "Relative popularity (0 - 100)",
    title = "Google search of `soil science` (worldwide)",
    subtitle = "Values over 90 are highlighted",
    caption = "Data from Google"
  ) +
  theme_modern_rc() +
  theme(axis.text.x = element_text(
    angle = 90,
    vjust = 0.5,
    hjust = 1
  )) +
  theme(plot.margin = unit(c(2.5, 1, 2.5, 1), "cm"))


ggsave("plots/plot26.png")

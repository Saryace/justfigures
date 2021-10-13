library(gggibbous)
library(ggdark)
library(glue)
library(ggtext)

moonphase <- subset(lunardist,!is.na(phase))
moonphase$percent <- ifelse(moonphase$phase == "new",
                            0,
                            ifelse(moonphase$phase == "full", 1, 0.5))

ggplot(lunardist, aes(date, y = 1)) +
  geom_line(size = 4, color = "grey40") +
  # Plotting the lower layer as a full circle also works in most cases
  geom_moon(
    data = moonphase,
    ratio = 1,
    size = 8,
    fill = "black"
  ) +
  geom_moon(
    data = moonphase,
    aes(ratio = percent),
    size = 8,
    fill = "grey70",
    right = moonphase$phase == "first quarter"
  ) +
  lims(y = c(0.995, 1.005)) +
  annotate(
    geom = "text",
    x = as.Date("2019-01-21"),
    y = 0.999,
    label = "First full moon",
    fontface = "bold",
    angle = 90,
    size = 5
  ) +
  annotate(
    geom = "text",
    x = as.Date("2019-01-21"),
    y = 1.001,
    label = "2019-01-21",
    fontface = "bold",
    angle = 90,
    size = 5
  ) +
  annotate(
    geom = "text",
    x = as.Date("2019-12-12"),
    y = 0.999,
    label = "Last full moon",
    fontface = "bold",
    angle = 90,
    size = 5
  ) +
  annotate(
    geom = "text",
    x = as.Date("2019-12-12"),
    y = 1.001,
    label = "2019-12-12",
    fontface = "bold",
    angle = 90,
    size = 5
  ) +
  theme_void()

ggsave("plots/plot24.png")

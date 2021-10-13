library(tidyverse)
library(extrafont)
library(xkcd)

font_import(".")
loadfonts()

ggplot(data = data.frame(x = c(0, 24)), aes(x)) +
  stat_function(fun = dnorm,
                n = 101,
                args = list(mean = 17, sd = 1.5)) +
  ylab("Relative concentration") +
  xlab("Hour of the day") +
  annotate(
    "text",
    x = 4,
    y = 0.008,
    label = "zzzzzz",
    family = "xkcd",
    size = 6
  ) +
  annotate(
    "text",
    x = 9,
    y = 0.008,
    label = "COFFEE-snacks",
    family = "xkcd",
    size = 6
  ) +
  annotate(
    "text",
    x = 15,
    y = 0.15,
    label = "work-anxiety-a new idea",
    family = "xkcd",
    size = 6,
    angle = 78
  ) +
  annotate(
    "text",
    x = 18.7,
    y = 0.18,
    label = "let's try tomorrow",
    family = "xkcd",
    size = 6,
    angle = -80
  ) +
  annotate(
    "text",
    x = 20.5,
    y = 0.05,
    label = "twitter",
    family = "xkcd",
    size = 6,
    angle = -70
  ) +
  annotate(
    "text",
    x = 23,
    y = 0.008,
    label = "zzz",
    family = "xkcd",
    size = 6
  ) +
  scale_x_continuous(breaks = c(seq(0, 24, 4))) +
  ggtitle("Surviving in a pandemic as a graduate student") +
  theme_xkcd() +
  theme(
    panel.grid = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  ) +
  theme(plot.margin = unit(c(4, 1, 4, 1), "cm"))

ggsave("plots/plot9.png")


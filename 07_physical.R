library(soilphysics)
library(tidyverse)

theme_set(theme_bw())

x <- seq(log10(1), log10(15000), len = 100)
h <- 10 ^ x

y1 <- psd(
  thetaS = 0.7,
  thetaR = 0.005,
  alpha = 0.021,
  n = 1.5,
  h = h
)

y2 <- psd(
  thetaS = 0.3,
  thetaR = 0.01,
  alpha = 0.066,
  n = 6,
  h = h
)

psd <- tibble(x = x, Soil1 = y1, Soil2 = y2)

psd_plot <- psd %>% pivot_longer(Soil1:Soil2, names_to = "psd")

ggplot(psd_plot, aes(x = x, y = value, pch = psd)) +
  geom_line(aes(linetype = psd), size = 2) +
  labs(y = expression(delta * theta / delta * h),
       x = "Equivalent pore radius" ~ (mu * m)) +
  annotate("text",
           x = 1.9,
           y = 0.0205,
           label = "Fine Soil") +
  annotate(
    "segment",
    x = 1.7,
    y = 0.0205,
    xend = 1.4,
    yend = 0.021,
    arrow = arrow(
      angle = 20,
      length = unit(2, "mm"),
      type = "closed"
    )
  ) +
  annotate("text",
           x = 1.9,
           y = 0.0055,
           label = "Coarse Soil") +
  annotate(
    "segment",
    x = 1.7,
    y = 0.005,
    xend = 1.6,
    yend = 0.004,
    arrow = arrow(
      angle = 20,
      length = unit(2, "mm"),
      type = "closed"
    )
  ) +
  ggtitle(
    'The unimodal soil pore size distribution based on van Genuchten’s model\nsoilphysics R package'
  ) +
  theme(legend.position = "none") +
  theme(plot.margin = unit(c(3, 2, 3, 2), "cm"))

ggsave("plots/plot7.png")

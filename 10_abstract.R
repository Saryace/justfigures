library(packcircles)
library(soilpalettes)
library(ggplot2)
library(tidyverse)


soil_psd <- tribble(
  ~ group,
  ~ value,
  "boulders",
  200,
  "very coarse gravel",
  130,
  "coarse gravel",
  40,
  "medium gravel",
  13,
  "fine gravel",
  4,
  "cs",
  1.3,
  "ms",
  0.13,
  "fs",
  0.013
)


packing <- circleProgressiveLayout(soil_psd$value, sizetype = 'area')

data <- cbind(soil_psd, packing)

dat.gg <- circleLayoutVertices(packing, npoints = 50)

ggplot() +
  geom_polygon(
    data = dat.gg,
    aes(x, y, group = id, fill = as.factor(id)),
    colour = "black",
    alpha = 0.6
  ) +
  geom_text(data = data,
            aes(x, y, size = value, label = group),
            family = "serif") +
  scale_size_continuous(range = c(1, 4)) +
  theme_void() +
  theme(legend.position = "none") +
  coord_equal() +
  scale_fill_manual(values = soil_palette("rendoll", 8)) +
  annotate("text",
           x = 2,
           y = 10,
           label = "Coarse sand") +
  annotate(
    "segment",
    x = 0,
    y = 9.5,
    xend = -0.5,
    yend = 9.0,
    arrow = arrow(
      angle = 20,
      length = unit(2, "mm"),
      type = "closed"
    )
  ) +
  theme(plot.margin = unit(c(3, 2, 3, 2), "cm"))

ggsave("plots/plot10.png")


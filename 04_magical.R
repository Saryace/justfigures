library(tidyverse)
library(magick)
library(ditherer)

soil_magical <- tribble(~ soil_id,
                        ~ top,
                        ~ bottom,
                        ~ om,
                        "A",
                        0,
                        17,
                        12,
                        "A",
                        17,
                        44,
                        8,
                        "A",
                        44,
                        55,
                        3,
                        "A",
                        55,
                        105,
                        2)

ggplot(soil_magical, aes(soil_id,  top - bottom , fill = om , label = om)) +
  geom_col(position = "stack", width = 0.3) +
  theme_void() + theme(legend.key.size = unit(0.3, "cm"),
                       legend.position = "top",
                       plot.background = element_rect(fill = "gray86")) +
  scale_fill_continuous(low = "grey",
                        high = "darkblue",
                        na.value = "grey10") +
  annotate(
    geom = "label",
    x = 0.75,
    y = -100,
    label = "A lot of OM!",
    fill = "white"
  )

ggplot2::ggsave(
  "figures/soil_magic.png",
  width = 3,
  height = 3,
  units = "cm"
)

magicplot <- dither(
    "figures/soil_magic.png",
    res = 200,
    scale = NULL,
    target_palette = grey.colors(64),
    r = 1 / 8,
    bayer_size = 3,
    dither = "ordered",
    original = F
  )

ggplot2::ggsave(
  "figures/magicplot.png",
  width = 5,
  height = 5,
  units = "cm"
)

magicplot <- image_read("figures/magicplot.png")

magegif <- image_read("figures/mage.gif")


frames <- image_composite(magicplot, magegif, gravity = "southeast")

animation <- image_animate(frames, fps = 4)

image_write(animation, "plots/plot4.gif")


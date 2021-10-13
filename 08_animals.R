library(tidyverse)
library(gganimate)
library(magick)
library(ggimage)
library(ggtextures)
library(grid)
theme_set(theme_bw())


soil_bug <- "http://clipart-library.com/data_images/494679.png"

soil_back <-
  image_read("https://pikeconservation.org/wp-content/uploads/soil-news-967x580.jpg")


soil_worm <- tibble(
  time = c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16),
  x = c(
    5,
    4.3,
    3.5,
    3.7,
    3.3,
    3.2,
    2.5,
    2.8,
    3.6,
    4.5,
    3.9,
    3.7,
    3.2,
    2.0,
    2.2,
    2.4,
    2.7
  ),
  y = c(
    -5,
    -5.7,
    -3.9,
    -4.3,
    -3.8,
    -5.1,
    -4.6,
    -4.4,
    -4.9,
    -4.3,
    -4.7,
    -6.5,
    -7.9,
    -7.0,
    -7.5,
    -8.1,
    -8.5
  ),
)

soil_plot <- ggplot(data = soil_worm,
                    aes(x = x,
                        y = -y)) +
  lims(x = c(2, 5), y = c(0, 16)) +
  annotation_custom(rasterGrob(
    soil_back,
    width = unit(1, "npc"),
    height = unit(1, "npc")
  ),-Inf,
  Inf,
  -Inf,
  Inf) +
  geom_path(
    color = "bisque3",
    lineend = "butt",
    linejoin = "round",
    size = 4,
    alpha = 0.5
  ) +
  geom_image(aes(image = soil_bug),
             size = 0.05) + theme_void() +
  transition_reveal(along = time)

anim_save("plots/plot8.gif", soil_plot)


library(medfate)
library(ggdendro)
library(tidyverse)
library(magick)
library(grid)

data(exampleforestUS)

soil_data <- exampleforestUS$treeData

tree <-
  image_read(
    "http://clipart-library.com/images_k/tree-clipart-transparent/tree-clipart-transparent-15.png"
  )

g_pic <- rasterGrob(tree, interpolate = TRUE)

soil_data_plot <- soil_data %>% select(Height, CrownWidth) %>%
  mutate(Height = Height / 100)

ggplot(soil_data_plot, aes(y = Height, x = CrownWidth)) +
  geom_point(color = "darkgreen",
             size = 5,
             alpha = 0.5) +
  annotation_custom(
    g_pic,
    ymin = 0,
    ymax = 40,
    xmin = 5,
    xmax = 25
  ) +
  labs(x = "Crown Width (m)", y = "Height (m)") +
  annotate(
    "text",
    x = 16,
    y = 7,
    label = "Crown\nWidth",
    color = "black"
  ) +
  annotate(
    "text",
    x = 12.8,
    y = 20,
    label = "Height",
    angle = 90,
    color = "black"
  ) +
  annotate(
    "segment",
    x = 13,
    y = 10,
    xend = 17,
    yend = 10,
    color = "black"
  ) +
  annotate(
    "segment",
    x = 13,
    y = 0,
    xend = 13,
    yend = 40,
    color = "black"
  ) +
  theme_bw() +
  ggtitle("Data from package {medfate}") +
  theme(plot.margin = unit(c(4, 1, 4, 1), "cm"))

ggsave("plots/plot16.png")


library(dplyr)
library(ggrepel)
library(tidyverse)
library(patchwork)

shapes <- read.csv("data/shapes.txt")

data_connection <-
  tibble(
    lat = c(-33.424644, -33.52797, -33.46370, -33.43766, -33.498477),
    long = c(-70.637020, -70.75530, -70.83870, -70.81793, -70.6145018),
    Site = c("Site 1", "Site 2", "Site 3", "Site 4", "Soil Biophysics Lab")
  )

time_connection <- tibble(
  Travel = c(33, 23, 33, 24),
  Distance = c(10.5 , 22.9 , 36.1, 30.2),
  Site = c("Site 1", "Site 2", "Site 3", "Site 4")
)

cols <-
  c(
    "Site 1" = "red",
    "Site 2" = "blue",
    "Site 3" = "darkgreen",
    "Site 4" = "orange",
    "Soil Biophysics Lab" = "pink"
  )

plot1 <- ggplot(shapes) +
  geom_path(aes(shape_pt_lon, shape_pt_lat, group = shape_id),
            size = .2,
            alpha = .5,
            color = "black") +
  geom_point(data = data_connection,
             aes(x = long, y = lat, color = Site),
             size = 3) +
  geom_label_repel(data = data_connection, aes(x = long, y = lat, label = Site)) +
  coord_equal() +
  theme_void() +
  scale_colour_manual(values = cols) +
  theme(legend.position = "none")


plot2 <- time_connection %>%
  ggplot(aes(y = Travel, x = Distance)) +
  geom_point(aes(color = Site), size = 3) +
  geom_line(color = "black") +
  geom_label_repel(data = time_connection, aes(x = Distance, y = Travel, label = Site)) +
  labs(x = "Distance from the lab (km)", y = "Travel time (min)") +
  theme_bw() +
  scale_colour_manual(values = cols) +
  theme(legend.position = "none") +
  theme(plot.margin = unit(c(4, 1, 4, 1), "cm")) +
  ggtitle("Field trip travelling time")

plot1 + plot2

ggsave("plots/plot18.png")


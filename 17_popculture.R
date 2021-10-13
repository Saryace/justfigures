library(wingspan)
library(tidyverse)

max <- wingspan::birds %>%
  select(common_name,
         wingspan,
         forest,
         grassland,
         forest,
         wetland,
         victory_points) %>%
  pivot_longer(forest:wetland) %>%
  group_by(name) %>%
  filter(value == T) %>%
  slice_max(order_by = victory_points, n = 1)

wingspan::birds %>%
  select(
    common_name,
    wingspan,
    forest,
    grassland,
    forest,
    wetland,
    victory_points,
    egg_capacity
  ) %>%
  pivot_longer(forest:wetland) %>%
  filter(value == T) %>%
  ggplot(aes(x = wingspan, y = egg_capacity)) +
  geom_point(color = "#6192BB",
             size = 2,
             alpha = 0.6) +
  gghighlight::gghighlight(victory_points == 9,
                           label_key = common_name,
                           label_params = list(size = 2)) +
  coord_flip() +
  ggtitle("Birds scoring 9 points in the Wingspan boardgame are highlighted. Data from {wingspan}") +
  facet_wrap(. ~ name, scales = "free") +
  labs(y = "Egg capacity", x = "Wingspan (cm)") +
  theme_bw() +
  theme(
    panel.border = element_rect(
      colour = "#A1B6C0",
      fill = NA,
      linetype = 2
    ),
    panel.background = element_rect(fill = "#DFE0DC"),
    panel.grid.major.x = element_line(
      colour = "#B1C5C1",
      linetype = 3,
      size = 0.5
    ),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y =  element_line(
      colour = "#B1C5C1",
      linetype = 3,
      size = 0.5
    ),
    panel.grid.minor.y = element_blank(),
    axis.text = element_text(
      colour = "#826B63",
      face = "italic",
      family = "Helvetica"
    ),
    axis.title = element_text(colour = "#826B63", family = "Helvetica"),
    axis.ticks = element_line(colour = "#826B63"),
    legend.position = "bottom",
    strip.background = element_rect(fill = "#CA8E76"),
    strip.text = element_text(colour = 'white')
  ) +
  theme(plot.margin = unit(c(5, 1, 5, 1), "cm"))

ggsave("plots/plot17.png")

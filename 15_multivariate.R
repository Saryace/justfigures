library(tidyverse)
library(ggpubr)
library(ggCyberPunk)

planets <- as_tibble(msos::planets)

planets %>% mutate(
  planet = c(
    "mercury",
    "venus",
    "earth",
    "mars",
    "jupyter",
    "saturn",
    "uranus",
    "neptune",
    "pluto"
  ),
  planet = fct_reorder(planet, Distance),
  type = c(
    "inner",
    "inner",
    "inner",
    "inner",
    "outer",
    "outer",
    "outer",
    "outer",
    "outer"
  )
) %>%
  pivot_longer(Distance:Moons) %>%
  ggplot(., aes(x = planet, y = value, color = planet)) +
  geom_point() +
  geom_glowing_area() +
  theme_cyberpunk() +
  labs(y = "") +
  scale_color_cyberpunk("zune") +
  facet_wrap(. ~ name, scales = "free") +
  theme(legend.position = "none",
        axis.text.x = element_text(
          angle = 90,
          vjust = 0.5,
          hjust = 1
        )) +
  theme(plot.margin = unit(c(3, 2, 3, 2), "cm"))

ggsave("plots/plot15.png")

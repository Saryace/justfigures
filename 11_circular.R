library(ggdark)
library(tidyverse)


ft_surf <- function(time) {
  omega <- (2 * pi) / 24
  t_surf <- 12 + 4.5 * (sin(omega * (time - 8)))
  return(t_surf)
}

data_time <- tibble(time = seq(from = 0, to = 24, by = 1))

data_time <- data_time %>% mutate(t_surf = ft_surf(time))

ggplot(data_time, aes(x = time, y = t_surf, color = t_surf)) +
  geom_point(size = 6) +
  geom_line() +
  theme_bw() +
  coord_polar() +
  scale_x_continuous("", breaks = 0:24, limits = c(0, 24)) +
  scale_y_continuous("Soil surface temperature",
                     breaks = seq(6, 18, 3),
                     limits = c(6, 18)) +
  scale_colour_gradient(low = "yellow",
                        high = "red",
                        na.value = NA) +
  dark_theme_gray() +
  theme(legend.title = element_blank()) +
  theme(plot.margin = unit(c(3, 2, 3, 2), "cm"))

ggsave("plots/plot11.png")




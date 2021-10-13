library(ggdark)
library(tidyverse)

ft_surf1 <- function(time) {
  omega <- (2 * pi) / 24
  t_surf <- 15 + 7 * (sin(omega * (time - 9)))
  return(t_surf)
}

ft_surf2 <- function(time) {
  omega <- (2 * pi) / 24
  t_surf <- 8 + 4 * (sin(omega * (time - 7)))
  return(t_surf)
}

ft_surf3 <- function(time) {
  omega <- (2 * pi) / 24
  t_surf <- 4 + 4 * (sin(omega * (time - 5)))
  return(t_surf)
}


data_time <- tibble(time = seq(from = 0, to = 24, by = 1))

data_time <- data_time %>% mutate(soil1 = ft_surf1(time),
                                  soil2  = ft_surf2(time),
                                  soil3  = ft_surf3(time)) %>%
  pivot_longer(soil1:soil3)

plot12<-ggplot(data_time, aes(time, name, fill = value)) +
  geom_tile() +
  scale_fill_distiller(palette = "RdPu", name = "Soil surface\ntemperature\n°C") +
  scale_x_continuous("", limits = c(-1, 25), breaks = seq(0, 24, 1)) +
  coord_equal() +
  labs(y = "") +
  dark_theme_gray() +
  theme(legend.position = "bottom") +
  theme(plot.margin = unit(c(2, 1, 2, 1), "cm"))

plot12

ggsave("plots/plot12.png")

library(tidyverse)
library(corrr)
library(mcglm)

soil_corr <- mcglm::soil
soil_corr %>%
  dplyr::select(-COORD.X, -COORD.Y, -SILT) %>%
  corrr::correlate() %>%
  network_plot(colors = c('#2E5894', '#FFE733', 'red'),
               legend = TRUE) +
  theme(plot.margin = unit(c(3, 2, 3, 2), "cm"))


ggsave("plots/plot13.png")

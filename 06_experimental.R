library(agriTutorial)
library(ggimage)
library(tidyverse)



beet_image <- "http://clipart-library.com/image_gallery/235228.jpg"

agriTutorial::beet %>%
  group_by(nrate) %>%
  dplyr::summarise(yield = mean(yield)) %>%
  mutate(increase = yield - yield[nrate == 0]) %>%
  ggplot(aes(x = nrate, y = 10)) +
  geom_image(aes(image = beet_image, size = I(0.10 + increase / 200))) +
  geom_text(aes(
    x = nrate,
    y = 30,
    label = paste(
      "N fertilizer",
      "\n",
      nrate,
      "N/Ha",
      "\n",
      "Yield",
      "\n",
      round(yield, 1),
      "t/Ha"
    )
  ),
  family = "Courier",
  size = 5) +
  ylim(c(-15, 40)) +
  xlim(c(-10, 150)) +
  ggtitle(
    "From Petersen, R.G. (1994).Agricultural field experiments. \nDesign and analysis. New York: Marcel Dekker \nagriTutorial R package"
  ) +
  theme_void() +
  theme(plot.margin = unit(c(3, 2, 3, 2), "cm"))

ggsave("plots/plot6.png")

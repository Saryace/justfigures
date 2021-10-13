library(msos)
library(tidyverse)
library(corrmorant)
library(ggimage)
library(ggCyberPunk)

planets <- as_tibble(msos::planets)

planet_image <-
  data_frame(
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
    url = c(
      "http://clipart-library.com/img/720195.png",
      "http://clipart-library.com/images_k/space-png-transparent/space-png-transparent-24.png",
      "http://clipart-library.com/image_gallery2/Earth-Free-Download-PNG.png",
      "http://clipart-library.com/img1/1618368.png",
      "http://clipart-library.com/img1/1146288.png",
      "http://clipart-library.com/data_images/267158.png",
      "http://clipart-library.com/img1/1538449.png",
      "http://clipart-library.com/data_images/128296.png",
      "http://clipart-library.com/img/720195.png"
    )
  )

bind_cols(planets, planet_image) %>%
  ggplot(aes(log10(Distance), Temperature)) +
  geom_linesaber() +
  geom_image(aes(
    x = log10(Distance),
    y = Temperature,
    image = url,
    size = I(log(Diameter) / 100)
  )) +
  theme_cyberpunk() +
  labs(y = "Temp\n°F", x = "log[Distance in miles]") +
  theme(plot.margin = unit(c(3, 2, 3, 2), "cm"))

ggsave("plots/plot14.png")

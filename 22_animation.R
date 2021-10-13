library(tidyverse)
library(hrbrthemes)
library(gganimate)

ozone_area <-
  read.csv(file = "data/antarctic-ozone-hole-area.csv",
           TRUE,
           sep = ",",
           stringsAsFactors = FALSE)

ozone_area <- ozone_area %>%
  rename(area = Maximum.ozone.hole.area..square.kilometres.) %>%
  mutate(data = "measured") %>%
  select(Year, area, data)

years_pred <- seq(1979, 2041, by = 1)

model <-
  loess(
    area ~ Year,
    data = ozone_area ,
    span = 0.75,
    control = loess.control(surface = "direct"),
    se = T
  )

model_pred <- predict(model, newdata = years_pred)


ozone_pred <- tibble(Year = years_pred,
                     area = model_pred)



p <- ggplot(ozone_pred, aes(x = Year, y = area)) +
  geom_point(aes(group = seq_along(Year)), color = "yellow") +
  scale_x_continuous(breaks = seq(1979, 2041, by = 4)) +
  labs(
    x = "year",
    y = "Area (km2) of the Antarctic ozone hole",
    title = "Simple model for closure of ozone hole",
    caption = "Data from kaggle.com"
  ) +
  theme_ft_rc() +
  transition_time(Year) +
  shadow_mark() +
  theme(axis.text.x = element_text(
    angle = 90,
    vjust = 0.5,
    hjust = 1
  )) +
  theme(plot.margin = unit(c(4, 1, 4, 1), "cm"))

anim <- animate(p)

magick::image_write(anim, path = "data/plot22.gif")

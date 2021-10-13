library(tidyverse)
library(hrbrthemes)
library(forecast)
library(zoo)

women_stem <-
  read.csv(file = "data/SCN_DS_21042021133929346.csv",
           TRUE,
           sep = ",",
           stringsAsFactors = FALSE)

women_stem_plot <-
  women_stem %>%  filter(INDICATOR == "FRESP_THC") %>% select(Time, Value)

ts <- ts(women_stem_plot$Value, start = 2007, end = 2017)

fcast <- splinef(ts, h = 15, level = 95)

autoplot(fcast) +
  geom_hline(yintercept = 50) +
  annotate("text",
           x = 2017,
           y = 48,
           label = "goal") +
  scale_linetype_discrete(name = "Indicator",
                          labels = c("Total", "In Higher\nEducation")) +
  labs(
    x = "Year",
    y = "Percentage of women as researchers",
    title = "Women participation\nin research (Chile)\nBlue band =  95% CI",
    caption = "Data from UNESCO.org"
  ) +
  theme_ipsum() +
  theme(axis.text.x = element_text(
    angle = 90,
    vjust = 0.5,
    hjust = 1
  )) +
  theme(plot.margin = unit(c(2.5, 1, 2.5, 1), "cm"))



ggsave("plots/plot25.png")

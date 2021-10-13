library(tidyverse)
library(hrbrthemes)

women_stem <-
  read.csv(file = "data/SCN_DS_21042021133929346.csv",
           TRUE,
           sep = ",",
           stringsAsFactors = FALSE)

women_stem_plot <- women_stem %>%  filter(INDICATOR == "FRESP_THC" |
                                            INDICATOR == "FRESP_SP_THC_HIEDUSP")

ggplot(data = women_stem_plot,
       aes(x = Time, y = Value, shape = INDICATOR)) +
  geom_line(aes(linetype = INDICATOR)) +
  scale_x_continuous(breaks = seq(2006, 2017, by = 1)) +
  scale_y_continuous(breaks = seq(0, 50, by = 1)) +
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
    title = "Women participation\nin research (Chile)",
    caption = "Data from UNESCO.org"
  ) +
  theme_ipsum() +
  theme(axis.text.x = element_text(
    angle = 90,
    vjust = 0.5,
    hjust = 1
  ),
  plot.background = element_rect(fill="white")) +
  theme(plot.margin = unit(c(2.5, 1, 2.5, 1), "cm"))

ggsave("plots/plot20.png")

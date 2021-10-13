library(tidyverse)
library(ggtextures)

water_content <- tribble(
  ~ id,
  ~ drainable,
  ~ plant_aw,
  ~ unavailable,
  ~ solid_fraction,
  "Soil1",
  0.20,
  0.13,
  0.14,
  0.53,
  "Soil2",
  0.15,
  0.15,
  0.13,
  0.57,
  "Soil3",
  0.14,
  0.17,
  0.14,
  0.53
)

water_long <-
  water_content %>% pivot_longer(drainable:solid_fraction, names_to = "volumetric_value") %>%
  mutate(volumetric_value = fct_relevel(
    volumetric_value,
    c("drainable",
      "plant_aw",
      "unavailable",
      "solid_fraction")
  )) %>%
  mutate(
    images = case_when(
      volumetric_value == "drainable" ~ "figures/drain.jpg",
      volumetric_value == "plant_aw" ~ "figures/paw.jpg",
      volumetric_value == "unavailable" ~ "figures/unav.jpg",
      volumetric_value == "solid_fraction" ~ "figures/solid.jpg"
    )
  )


plot2 <- ggplot(
  water_long,
  aes(
    fill = volumetric_value,
    y = as.numeric(value),
    label = value,
    image = images,
    x = id
  )
) +
  geom_textured_bar(
    position = "fill",
    stat = "identity",
    width = 0.80,
    img_height = unit(5, "cm")
  ) +
  coord_flip() +
  scale_fill_manual(
    labels = c(
      "Drainable\nporosity",
      "Plant\navailable water",
      "Unavailable\nwater",
      "Solid phase"
    ),
    values = c("dodgerblue", "palegreen3", "slategray3", "saddlebrown")
  ) +
  geom_label(
    position = position_fill(vjust = .5),
    color = "#FFFFFF",
    show.legend  = F
  ) +
  ggtitle("Volumetric fraction of solid phase + pore phase") +
  ylim(x = c(0, 1)) +
  labs(x = "", y = "") +
  theme(
    axis.line = element_line(size = 1, colour = "black"),
    panel.grid.major = element_line(colour = "#d3d3d3"),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    plot.title = element_text(
      size = 14,
      family = "Tahoma",
      face = "bold"
    ),
    text = element_text(family = "Tahoma"),
    panel.background = element_blank(),
    legend.position = "none"
  ) +
  theme(plot.margin = unit(c(3, 2, 3, 2), "cm"))

plot2

ggsave("plots/plot2.png")

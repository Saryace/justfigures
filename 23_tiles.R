library(calendR)

png("plots/plot23.png")

calendR(
        year = 2020,
        start = "M",
        title = "Days I spent in the lab [2020]",
        special.days = c(72, 73, 143),
        special.col = "hotpink4",
        low.col = "beige",
        margin = 1
)

dev.off()


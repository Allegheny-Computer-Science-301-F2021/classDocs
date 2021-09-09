# install.packages("plotly")
library(plotly)
spinrates <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/spinrates.csv",
                      stringsAsFactors = FALSE)

p <- ggplot(spinrates, aes(x=velocity, y=spinrate)) +
  geom_tile(aes(fill = swing_miss)) +
  scale_fill_distiller(palette = "YlGnBu") +
  labs(title = "Likelihood of swinging and missing on a fastball",
       y = "spin rate (rpm)")

ggplotly(p)
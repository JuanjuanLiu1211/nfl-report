here::i_am("R/kyurhi_relationship.R")

library(ggplot2)
nfl <- read.csv(here::here("data", "nfl_leaders.csv"))

# Filter quarterbacks
qb <- subset(nfl, Pos == "QB")

# Keep only complete cases for plotting variables
qb_plot <- qb[!is.na(qb$Att) & !is.na(qb$Yds), ]

# Create scatterplot 
p <- ggplot(qb_plot, aes(x = Att, y = Yds)) +
  geom_point(size = 2.5, alpha = 0.7, color = "steelblue") +
  labs(
    title = "Passing Attempts vs. Passing Yards",
    subtitle = "NFL Quarterbacks",
    x = "Passing Attempts",
    y = "Passing Yards"
  ) +
  theme_minimal()

ggsave(
  filename = here::here("output", "figures", "kyurhi_relationship.png"),
  plot = p,
  width = 8,
  height = 6,
  dpi = 300
)
cat("Number of quarterbacks plotted:", nrow(qb_plot), "\n")

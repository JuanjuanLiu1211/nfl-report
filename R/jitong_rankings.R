# Jitong Jiang
# DATA 550 Midterm Project
# Top N Quarterbacks by Passing Yards

library(ggplot2)
library(dplyr)
library(yaml)

# Read configuration
config <- yaml::read_yaml("config.yml")
top_n <- config$default$top_n

if (!is.numeric(top_n) || length(top_n) != 1 ||
    is.na(top_n) || !is.finite(top_n) ||
    top_n < 1 || top_n != floor(top_n)) {
  stop("top_n must be a positive integer.")
}

# Read data
nfl <- read.csv("data/nfl_leaders.csv", check.names = FALSE)

# Make column names unique
names(nfl) <- make.unique(names(nfl))

# Identify the first Yds column (passing yards)
passing_yards_col <- which(names(nfl) == "Yds")[1]

if (is.na(passing_yards_col)) {
  stop("Passing yards column not found.")
}

# Convert passing yards to numeric
nfl$Passing_Yards <- suppressWarnings(
  as.numeric(gsub(",", "", as.character(nfl[[passing_yards_col]])))
)

# Filter quarterbacks and remove missing values
qb_data <- nfl %>%
  filter(
    Pos == "QB",
    !is.na(Player),
    trimws(Player) != "",
    !is.na(Passing_Yards)
  ) %>%
  arrange(desc(Passing_Yards), Player) %>%
  slice_head(n = top_n)

if (nrow(qb_data) == 0) {
  stop("No quarterbacks with valid passing yards found.")
}

# Order players by passing yards
qb_data$Player <- factor(
  qb_data$Player,
  levels = rev(unique(qb_data$Player))
)

# Create horizontal bar chart
p <- ggplot(qb_data, aes(x = Player, y = Passing_Yards)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = paste("Top", nrow(qb_data), "Quarterbacks by Passing Yards"),
    x = "Quarterback",
    y = "Passing Yards"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5)
  )

# Save figure
dir.create(
  "output/figures",
  recursive = TRUE,
  showWarnings = FALSE
)

ggsave(
  filename = "output/figures/jitong_rankings.png",
  plot = p,
  width = 9,
  height = 6,
  dpi = 300
)

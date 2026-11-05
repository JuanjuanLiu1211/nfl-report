
# NFL Quarterback Descriptive Statistics
# DATA 550 Group Project
# Coder: Yujing Liu

library(dplyr)
library(tidyr)

# Load data, preserving original column names
nfl <- read.csv(
  "data/nfl_leaders.csv",
  check.names = FALSE
)

# Make duplicate column names unique
# The first Yds column contains passing yards
names(nfl) <- make.unique(names(nfl))

# Filter quarterbacks
qb <- nfl %>%
  filter(Pos == "QB")

# Select variables
qb_vars <- qb %>%
  transmute(
    Age = as.numeric(Age),
    `Passing Attempts` = as.numeric(Att),
    `Passing Yards` = as.numeric(Yds),
    `Passing Touchdowns` = as.numeric(TD),
    Interceptions = as.numeric(Int),
    `Completion Percentage` = as.numeric(`Cmp%`)
  )

# Calculate descriptive statistics
summary_table <- qb_vars %>%
  pivot_longer(
    cols = everything(),
    names_to = "Variable",
    values_to = "Value"
  ) %>%
  group_by(Variable) %>%
  summarise(
    N = sum(!is.na(Value)),
    Mean = if (all(is.na(Value))) NA_real_
           else mean(Value, na.rm = TRUE),
    SD = if (sum(!is.na(Value)) < 2) NA_real_
         else sd(Value, na.rm = TRUE),
    Min = if (all(is.na(Value))) NA_real_
          else min(Value, na.rm = TRUE),
    Max = if (all(is.na(Value))) NA_real_
          else max(Value, na.rm = TRUE),
    .groups = "drop"
  )

# Preserve variable order
summary_table$Variable <- factor(
  summary_table$Variable,
  levels = names(qb_vars)
)

summary_table <- summary_table %>%
  arrange(Variable) %>%
  mutate(Variable = as.character(Variable))

# Save CSV output
dir.create(
  "output/tables",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  summary_table,
  "output/tables/yujing_summary.csv",
  row.names = FALSE
)

print(summary_table)


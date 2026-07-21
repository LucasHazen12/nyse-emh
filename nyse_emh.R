# NYSE Efficient Markets Hypothesis — AR(1) Test
# Originally Part of a time-series assignment, expanded into a
# standalone financial-econometrics paper.

library(dplyr)
library(ggplot2)
library(stargazer)

# Load dataset
load("nyse.Rda")

# Check structure
str(nyse)
head(nyse)

# Calculate log returns
nyse <- nyse %>%
  arrange(t) %>%
  mutate(log_price = log(price),
         log_return = c(NA, diff(log_price))) %>%
  drop_na()

# Create lagged log return for AR(1)
nyse <- nyse %>%
  mutate(lag_return = lag(log_return)) %>%
  drop_na()

# Run AR(1) regression
emh_model <- lm(log_return ~ lag_return, data = nyse)
summary(emh_model)

# Plot log returns
ggplot(nyse, aes(x = t, y = log_return)) +
  geom_line(color = "red", size = 1) +
  labs(
    title = "NYSE Weekly Log Returns (Time Series)",
    x = "Week",
    y = "Log Return"
  ) +
  theme_minimal(base_size = 14)

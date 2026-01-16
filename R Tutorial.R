# Installation ------------------------------------------------------------
# Installing R and R Studio
# https://cran.microsoft.com/ - Installing R
# https://www.rstudio.com/products/rstudio/download/ - Installing R Studio

# For Windows/PC Users, also should install RTools
# https://cran.r-project.org/bin/windows/Rtools/

# RStudio Projects --------------------------------------------------------
# IMPORTANT: Use RStudio Projects instead of setwd()
# File -> New Project -> New Directory OR Existing Directory
# Projects keep your work organized and set working directory automatically
# Your data files should live in the project folder

# R as a Calculator -------------------------------------------------------
2+2
5/15
6*3
2^3
sqrt(16)

# Logical Operators and Relations
5 > 3
3 > 5
5 >= 5 # greater than or equal to
5 == 5 # equal to requires 2 equal signs
3 != 5 # not equal to

# Objects -----------------------------------------------------------------
x <- 5

x

x+3
x^2

x <- 10
# you can assign values to objects with a single = sign, but that can lead to confusion later
x2 = 5
x2

# VERY IMPORTANT: R is CASE SENSITIVE (capitalization matters)
X <- 4
X+3

# X and x are different objects
x == X # Returns a result of FALSE

# objects can also be strings of text (characters)
myname <- "alexa"
myname

alexa <- "alexa"

myname <- alexa

myname <- "alexa"

# Functions ---------------------------------------------------------------
sqrt(100) # functions require some sort of input
?sqrt() # if you want help on a specific function
sqrt(x)

?lm()
# the ls() function lists all objects in the local environment
ls()

# the rm() function removes (deletes) objects from the local environment.
rm(x)

ls()

rm(list = ls()) # this removes all objects from the environment

# Vectors -----------------------------------------------------------------
x <- 5

y <- c(1, 2, 3)
y

length(y)

y*2
sqrt(y)

y[2]

y2 <- c(1, 2, "hello")
y2

y*2
y2*2 # Doesn't work because the data in y2 is no longer all numeric
class(y2)

# some types of data: logical, numeric, factor, character
# numeric: 1, 2, 3

# logical: TRUE or FALSE
y3 <- c(TRUE, FALSE, FALSE, 3<5, 5!=5)
y3

# character: "hello", 'what's up', "nothing much"

hello <- 1.5

y4 <- c(1, 2, hello)
class(y4)

y4

# factor: "male" or "female" (categorical information that is distinct, but not ordinal)

z <- list(1, 2, 3) # a list is a type of vector, but stores the data differently
z

z*2 # Doesn't work - you can't apply functions to lists in the same way

z[2]

# a list can come in handy if you're storing several different kinds of data
datalist <- list(c(1,2,3), 5)
datalist

# you can store lists within lists
datalist2 <- list(datalist, z)
datalist2

p <- c(1.5:5.5) # using a colon between numbers creates a sequence
p

?rep # the rep() function replicates something a certain number of times
rep(x = 1, times = 9)
rep(x = y, times = 3)
rep(x = y, each = 3)
rep(x = p, times = c(5:1))

?seq() # the seq() creates sequences in a more flexible manner
seq(from = 1, to = 5, by = 1) # a sequence that starts with 1, ends at 5, increases by 1
seq(1, 5, 2) # 1 to 5 by 2
seq(5, 1, -2) # 5 to 1 by -2
seq(1, 5, 0.5) # 1 to 5 by 0.5

# Setup: Packages and Data ------------------------------------------------
# Install pak (modern package installer - faster than base R)
# Run this once:
# install.packages("pak")

# Install packages once with pak (way faster, parallel downloads):
# pak::pak(c("tidyverse", "modelsummary"))

# Load packages every session
library(tidyverse)
library(modelsummary)

# Importing Data with readr
# congress <- read_csv("Congress Data.csv")

# For this tutorial, we'll assume you have congress data loaded
# If loading from working directory:
congress <- read_csv("Congress Data.csv")

# Data Exploration --------------------------------------------------------
class(congress)
nrow(congress) # how many rows?
ncol(congress) # how many columns?
dim(congress) # how many dimensions?
head(congress) # Show the first few results in the console
# View(congress) # pulls up the data frame in a table

# Use the $ operator to call a particular variable from a data frame
class(congress$nominate) # Variable Class

mean(congress$nominate) # Mean
median(congress$nominate) # Median
min(congress$nominate) # Minimum
max(congress$nominate) # Maximum

summary(congress$nominate) # Provides the above summary statistics
summary(congress)

table(congress$gop) # Tells you how many observations fall under each value
table(congress$state)

# Data Transformation with dplyr ------------------------------------------
# dplyr provides clean, consistent verbs for data manipulation
# Key functions: filter(), select(), mutate(), arrange(), group_by(), summarize()

# FILTER: subset rows based on conditions
congress_dem <- congress |>
  filter(gop == 0)

# Multiple conditions with filter
congress_dem_women_ny <- congress |>
  filter(gop == 0) |>
  filter(female == 1) |>
  filter(state == "NY")

# You can combine conditions in one filter
congress_dem_women_ny <- congress |>
  filter(gop == 0, female == 1, state == "NY")

# Filter for NOT equal
congress_no_ca <- congress |>
  filter(state != "CA")

# Filter using %in% for multiple values
congress_california <- congress |>
  filter(state %in% c("CA", "NY", "TX"))

# Negate with ! for "not in"
congress_not_big_states <- congress |>
  filter(!state %in% c("CA", "NY", "TX"))

# SELECT: choose specific columns
congress_names_party <- congress |>
  select(bioname, gop)

# Can also select ranges
congress_subset <- congress |>
  select(bioname, gop, state, nominate)

# MUTATE: create new variables
# Create a variable for Black Republicans
congress <- congress |>
  mutate(gop_black = if_else(gop == 1 & race == "black", 1, 0))

# case_when() for multiple conditions (cleaner than nested ifelse)
congress <- congress |>
  mutate(decade = case_when(
    career.start >= 1970 & career.start < 1980 ~ 1970,
    career.start >= 1980 & career.start < 1990 ~ 1980,
    career.start >= 1990 & career.start < 2000 ~ 1990,
    career.start >= 2000 & career.start < 2010 ~ 2000,
    career.start >= 2010 & career.start < 2020 ~ 2010,
    TRUE ~ NA_real_  # catch-all for anything else
  ))

# ARRANGE: sort the dataset
congress <- congress |>
  arrange(decade)

# Sort descending
congress_by_terms <- congress |>
  arrange(desc(terms.career))

# GROUP_BY and SUMMARIZE: aggregate data
# Average nominate score by party
congress |>
  group_by(gop) |>
  summarize(
    mean_nominate = mean(nominate),
    median_nominate = median(nominate),
    n = n()
  )

# Multiple grouping variables
congress |>
  group_by(gop, female) |>
  summarize(
    mean_nominate = mean(nominate),
    count = n()
  )

# Filter groups by size
congress_big_states <- congress |>
  group_by(state) |>
  filter(n() >= 100) |>
  ungroup()

# Combining operations with pipes
congress_analysis <- congress |>
  filter(terms.career >= 10) |>
  mutate(party = if_else(gop == 1, "Republican", "Democrat")) |>
  group_by(party, decade) |>
  summarize(
    avg_ideology = mean(nominate),
    count = n()
  ) |>
  arrange(decade, party)

# Handling missing data
# Remove rows with any NA
congress_complete <- congress |>
  drop_na()

# Remove rows with NA in specific column
congress_no_missing_terms <- congress |>
  filter(!is.na(terms.career))

# Saving Data -------------------------------------------------------------
# Save as CSV
write_csv(congress, "congress_clean.csv")

# Visualization with ggplot2 ----------------------------------------------
# ggplot2 uses a grammar of graphics: data + aesthetics + geometries + themes

# Basic histogram
ggplot(congress, aes(x = nominate)) +
  geom_histogram(bins = 30)

# Histogram by group
ggplot(congress, aes(x = nominate, fill = factor(gop))) +
  geom_histogram(bins = 30, position = "identity", alpha = 0.6) +
  scale_fill_manual(values = c("blue", "red"),
                    labels = c("Democrat", "Republican"),
                    name = "Party") +
  theme_minimal()

# Scatterplot with regression lines
mycolors <- c("blue", "red")

ggplot(congress, aes(x = terms.career, y = nominate, color = factor(gop))) +
  geom_point(alpha = 0.5) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_smooth(method = "lm", se = TRUE) +
  scale_color_manual(values = mycolors,
                     labels = c("Democrat", "Republican"),
                     name = "Party") +
  labs(
    x = "Career Terms",
    y = "Ideology (NOMINATE)",
    title = "Ideology by Career Length and Party"
  ) +
  theme_bw()

# Save plots to objects
ideology_plot <- ggplot(congress, aes(x = terms.career, y = nominate, color = factor(gop))) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE) +
  scale_color_manual(values = mycolors,
                     labels = c("Democrat", "Republican"),
                     name = "Party") +
  labs(
    x = "Career Terms",
    y = "Ideology (NOMINATE)",
    title = "Ideology by Career Length and Party"
  ) +
  theme_minimal()

ideology_plot

# Save plot to file
ggsave("ideology_plot.png", ideology_plot, width = 8, height = 6)

# Regressions -------------------------------------------------------------
# OLS regressions are run with the lm() function
# lm(y ~ x + x2 + x3, data = congress)
?lm()

# What hypotheses can we come up to explain a representative's ideology?

congress_model <- lm(nominate ~ gop + female + race + region + career.start + terms.career,
                     data = congress)
summary(congress_model)

# How to read the output?
# A 1 unit change in X leads to a _____ unit change in Y, holding the other variables constant

cor(congress$nominate, congress$gop) # Very high correlation, but do we remove it from the model?

congress_model2 <- lm(nominate ~ female + race + region + career.start + terms.career,
                      data = congress)
summary(congress_model2)

# Display models in clean table with modelsummary
modelsummary(
  list("With Party" = congress_model, "No Party" = congress_model2),
  stars = TRUE,
  output = "markdown"
)

# Can also output to other formats
# output = "latex" for LaTeX tables
# output = "congress_models.html" to save as HTML file

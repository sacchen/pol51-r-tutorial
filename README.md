# Modern R Tutorial for POL51

A cleaned-up, modernized version of the class R tutorial. No bloat, best practices only.

## Why This Exists

The original tutorial taught multiple ways to do everything (base R subsetting with brackets, `subset()`, AND dplyr). For beginners, this is confusing. You don't need to learn deprecated practices alongside modern tools.

This version teaches **one modern way per task** using the tidyverse ecosystem that you'll actually use in real work.

## How to Download These Files

**You don't need to know git or GitHub.** Just follow these steps:

### Method 1: Download ZIP (Easiest)
1. Click the green **Code** button at the top of this page
2. Click **Download ZIP**
3. Unzip the file on your computer
4. Open `R Tutorial.R` in RStudio

### Method 2: Copy-Paste
1. Click on `R Tutorial.R` above
2. Click the **Copy raw file** button (two overlapping squares icon)
3. Create a new R script in RStudio
4. Paste and save

### What is GitHub?
GitHub is a website for sharing code. Think of it like Google Drive for programmers. You're viewing this tutorial on GitHub right now, but you don't need a GitHub account to download and use it.

### What You Need
- The `R Tutorial.R` file (the actual tutorial)
- The Congress data file (get from Canvas/instructor)
- R and RStudio installed (see "Getting Started" section below)

## What Changed

### Removed
- `setwd()` - Use RStudio Projects instead (industry standard)
- Base R subsetting with brackets `data[data$x == 5, ]` - Confusing syntax
- `subset()` function - Deprecated, inconsistent behavior
- All base plotting (`plot()`, `points()`, `lines()`) - ggplot2 is standard
- `read.csv()` - Use `readr::read_csv()` (better defaults, tibbles)
- Nested `ifelse()` - Unmaintainable, use `case_when()`
- Custom operators like `%notin%` - Just use `!x %in% y`
- Duplicate package installations scattered throughout
- ~200 lines of redundant examples

### Added
- **RStudio Projects** - Proper project management (like Python venv)
- **Native pipe `|>`** - Modern R (≥4.1) syntax
- **Comprehensive dplyr** - `filter()`, `select()`, `mutate()`, `arrange()`, `group_by()`, `summarize()`
- **`case_when()`** - Readable multi-condition logic
- **ggplot2 only** - Grammar of graphics, publication-quality plots
- **modelsummary** - Modern regression tables (stargazer is unmaintained)
- **Better structure** - Clear progression from basics → tidyverse → viz → models

## Philosophy

**One modern way per task.** Learn it right the first time.

If you know Python:
- RStudio Projects = Python virtual environments
- tidyverse = pandas/matplotlib ecosystem
- `|>` pipe = method chaining
- dplyr verbs = pandas operations with cleaner syntax

## Tutorial Structure

1. **Installation + RStudio Projects** - Setup and project management
2. **R Fundamentals** - Calculator, objects, vectors, types (base R is fine here)
3. **Setup** - Package loading, data import with `readr`
4. **Data Exploration** - Summary stats, tables
5. **Data Transformation** - dplyr verbs with native pipe
6. **Visualization** - ggplot2 only, grammar of graphics
7. **Regression** - `lm()` + modelsummary for tables

## Key Differences from Original

| Task | Original (Bloated) | This Version (Modern) |
|------|-------------------|---------------------|
| Subsetting | 3 methods: brackets, `subset()`, dplyr | dplyr `filter()` only |
| Selecting columns | Brackets, names, dplyr | dplyr `select()` only |
| Creating variables | Base `ifelse()` nested hell | `mutate()` + `case_when()` |
| Sorting | `order()` with brackets | dplyr `arrange()` |
| Plotting | Base plot + ggplot2 | ggplot2 only |
| Data import | `read.csv()` | `read_csv()` (tibbles) |
| Pipe | `%>%` magrittr | `|>` native (R ≥4.1) |
| Working directory | `setwd()` hardcoded paths | RStudio Projects |
| Regression tables | stargazer (unmaintained) | modelsummary (active) |

## Why This Matters

**Learning multiple deprecated methods wastes time.** The tidyverse approach:
- More readable (English-like verbs)
- More consistent (same syntax patterns)
- Better error messages
- Industry standard for data science
- Actively maintained

You'll see tidyverse in:
- Academic papers with reproducible code
- Data science jobs
- R packages and documentation
- Stack Overflow solutions

Learning base R brackets first is like learning C before Python. Unnecessary friction.

## Getting Started

### Prerequisites
1. Install R: https://cran.microsoft.com/
2. Install RStudio: https://posit.co/download/rstudio-desktop/
3. (Windows only) Install RTools: https://cran.r-project.org/bin/windows/Rtools/

### First Time Setup
```r
# Install pak (modern, faster package installer)
install.packages("pak")

# Use pak to install everything (way faster than base R)
pak::pak(c("tidyverse", "modelsummary"))
```

**Why pak?** It downloads packages in parallel (like modern package managers) instead of one-at-a-time. Installing tidyverse takes ~30 seconds with pak vs ~5 minutes with base `install.packages()`.

### Every Session
```r
# Load packages
library(tidyverse)
library(modelsummary)

# Load your data
congress <- read_csv("Congress Data.csv")
```

## Learning Resources

**Tidyverse-first resources:**
- [R for Data Science (2e)](https://r4ds.hadley.nz/) - Free online book, modern approach
- [dplyr cheatsheet](https://github.com/rstudio/cheatsheets/blob/main/data-transformation.pdf)
- [ggplot2 cheatsheet](https://github.com/rstudio/cheatsheets/blob/main/data-visualization.pdf)
- [Posit Recipes](https://posit.cloud/learn/recipes) - Common tasks in tidyverse

**When you get stuck:**
- Google + Stack Overflow (most answers use tidyverse now)
- ChatGPT/Claude (specify "using tidyverse")

## Notes

- This tutorial uses **native pipe `|>`** (R ≥4.1). If your R is older, use `%>%` instead.
- RStudio Projects avoid hardcoded paths. Create a project for each assignment.
- tibbles (from `read_csv()`) print nicer than data.frames and have safer defaults.

## For Instructors

If you're teaching R in 2026, please consider:
- Teaching tidyverse first (not "base R then tidyverse")
- Using RStudio Projects instead of `setwd()`
- Showing one modern way per task
- Skipping deprecated functions

Students learn better with consistent, modern tools. The "learn base R for fundamentals" argument doesn't hold - most never use it after the class.

---

**Questions?** This is student-maintained. If you find issues or have suggestions, let me know.

**Original tutorial:** See git history or ask the instructor for the original bloated version if you're curious what this replaced.

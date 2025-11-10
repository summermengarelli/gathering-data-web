# ------------------------------------
# 
# R script to call to College Football Data API and visualize play-by-play data.
# Workshop: Gathering Data from the Web Using APIs
# Dan Johnson + Summer Mengarelli, Fall 2025
#
# ------------------------------------

# Libraries
## installing cfbfastR from the sportsdataverse:
if (!requireNamespace('remotes', quietly = TRUE)){
  install.packages('remotes', repos = "https://cloud.r-project.org")
}
remotes::install_github("sportsdataverse/cfbfastR")

library(cfbfastR)
library(sportyR)
library(tidyverse)

# ------------------------------------

# API KEY
## I requested a key here: https://collegefootballdata.com/key
Sys.setenv(CFBD_API_KEY = "1XuruDEn5DZHsjxGa/sZigqoKk/t2Df/+65BzVdmAAWlN2dWJGKdbYcyVlAuv8Y3")

# ------------------------------------

# Make API request for play-by-play data of 2025 season (so far)
pbp_2025 <- cfbfastR::load_cfb_pbp(seasons = 2025)

## Filter to ND vs Navy game (could have done this multiple ways)
nd_navy <- pbp_2025 %>% filter(home == "Notre Dame" & away == "Navy")

# ------------------------------------

# Prepare data to plot plays
## Create X/Y coordinates, where X maps to final location of play and Y is (for now) at center
nd_navy_plot <- nd_navy %>%
  filter(!is.na(yards_to_goal)) %>%
  mutate(
    end_x = (50 - yards_to_goal + yards_gained),
    y = 0,  
    ### Clean up play types to limit colors needed:
    play_type_clean = case_when( 
      str_detect(play_type, "Passing") ~ "Touchdown",
      str_detect(play_type, "Rushing") ~ "Touchdown",
      play_type == "Rush" ~ "Rush",
      (play_type == "Pass Reception" | play_type == "Pass Incompletion") ~ "Pass",
      str_detect(play_type, "Field Goal") ~ "Field Goal",
      str_detect(play_type, "Punt") ~ "Punt",
      play_type == "Sack" ~ "Sack",
      TRUE ~ "Other"
    )
  )

## Remove Jeremiyah Love TD so we can plot it individually later
nd_navy_plot <- nd_navy_plot %>% filter(yards_gained != 48)

## Find Love play
love_td_play <- nd_navy %>%
  filter(str_detect(play_text, regex("Love", ignore_case = TRUE)),
         play_type == "Rushing Touchdown",
         str_detect(play_text, "48"))

## Create dataframe of specific start/end X/Y coordinates of Love rush
love_td_plot <- data.frame(
  start_x = 50 - love_td_play$yards_to_goal,
  end_x = 50 - love_td_play$yards_to_goal + love_td_play$yards_gained,
  start_y = 0,
  end_y = 0
)

# ------------------------------------

# Visualize ND plays!
gg_field <- geom_football(league = "ncaa", display_range = "full") +
  geom_point(
    data = nd_navy_plot,
    aes(x = end_x, y = y, color = play_type_clean),
    size = 3, alpha = 0.7,
    position = position_jitter(width = 0, height = 20)
  ) +
  
  scale_color_manual(
    values = c(
      "Rush" = "#0C2340",        
      "Pass" = "#b3dac5",        
      "Field Goal" = "white",
      "Punt" = "gray50",
      "Sack" = "black",
      "Touchdown" = "#C99700",
      "Other" = "lightblue"
    )
  ) +
  geom_point(data = love_td_plot, aes(x = end_x, y = end_y), color = "#FFC72C", size = 5, shape = 19) +
  geom_segment(data = love_td_plot, aes(x = start_x, y = start_y, xend = end_x, yend = end_y),
               arrow = arrow(length = unit(0.2,"cm")), color = "#FFC72C", size = 1, alpha = .7) +
  geom_point(data = love_td_plot, aes(x = start_x, y = start_y), color = "#0C2340", size = 4) +
  geom_text(
    data = love_td_plot,
    aes(x = end_x - 20, y = end_y+4, label = "Love 48-yard TD"),
    color = "#FFC72C", fontface = "bold", hjust = 0
  ) +
  labs(
    title = "Notre Dame Plays Against Navy | November 8, 2025",
    color = "Play Type",
    caption = "Data: cfbfastR + CollegeFootballData API | Visualization: sportyR + ggplot2"
  ) +
  theme_void(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5)
  )

gg_field


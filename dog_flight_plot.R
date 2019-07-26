library(tidyverse)
library(showtext)

# join the cleaned dog and flight data

dogs_flights <- dogs_tidy %>% 
  inner_join(flights_tidy, by = "date_flight") %>% 
  filter(!is.na(altitude))

font_add_google("Space Mono", "Space Mono")

showtext_auto() 
p <- ggplot(dogs_flights, aes(x = date_flight, y = altitude)) +
  geom_jitter(aes(colour = flight_fate), 
              width = 1, height = 4,
              show.legend = FALSE) +
  scale_y_continuous(limits = c(0, 460)) +
  scale_x_date(date_breaks = "1 years", date_labels = "%Y") +
  labs(x = "Date of Flight",
       y = "Altitude (km)",
       title = "Soviet Space Dogs",
       subtitle = "sjhdksjhdasjdh",
       caption = "Source: @Duncan Geere | Graphic: @committedtotape") +
  theme(plot.background = element_rect(fill = "#383854", colour = "#383854"),
        panel.background = element_rect(fill = "#F7CFA0"),
        panel.grid = element_line(colour = "#D74935"),
        panel.grid.minor = element_blank(),
        text = element_text(colour = "white", family = "Space Mono"),
        axis.text = element_text(colour = "white", family = "Space Mono"),
        plot.margin = margin(10,20,10,10))

quartz()
p

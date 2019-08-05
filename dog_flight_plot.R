library(tidyverse)
library(showtext)
library(extrafont)
library(ggforce)

# join the cleaned dog and flight data

dogs_flights <- dogs_tidy %>% 
  inner_join(flights_tidy, by = "date_flight") %>% 
  filter(!is.na(altitude))

font_add_google("Space Mono", "Space Mono")

all_dogs_flights <- dogs_tidy %>% 
  inner_join(flights_tidy, by = "date_flight") %>% 
  mutate(flight_year = year(date_flight)) %>% 
  arrange(date_flight, name_latin) %>% 
  group_by(flight_year) %>% 
  mutate(year_pos = row_number())

showtext_auto() 
p <- ggplot(all_dogs_flights, aes(x = year_pos, y = flight_year)) +
  geom_line(aes(group = date_flight), colour = "white", size = 1.5) +
  geom_point(aes(fill = flight_fate), shape = 21, colour = "white", size = 4.5, stroke = 1.5) +
  geom_mark_circle(aes(filter = name_latin == 'Laika', label = 'Laika', 
                       description = "The 1st dog to orbit earth"),
                       label.family = "Space Mono",
                       label.colour = "white",
                       label.fill = "#383854",
                       con.colour = "white",
                   colour = "#383854",
                   con.type = "elbow",
                   con.cap = 0) +
  scale_y_reverse(breaks = seq(1951, 1966, 1)) +
  scale_fill_manual(values = c("Survived" = "#B98924", "Died" = "#E14435")) +
  labs(y = "", x = "", 
       fill = "Each dot represents a dog and its fate on a mission\nDogs on the same flight are connected by a line",
       title = "Soviet Space Dogs",
       subtitle = "sjdhskdjhskdh",
       caption = "Source: @Duncan Geere | Graphic: @committedtotape") +
  theme(plot.background = element_rect(fill = "#383854", colour = "#383854"),
        panel.background = element_rect(fill = "#383854", colour = "#383854"),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        text = element_text(colour = "white", family = "Space Mono"),
        axis.text = element_text(colour = "white"),
        axis.text.x = element_blank(),
        plot.title = element_text(face = "bold"),
        plot.margin = margin(10,20,10,10),
        legend.background = element_rect(fill = "#383854", colour = "white"),
        legend.key = element_rect(fill = "#383854", colour = "#383854"),
        legend.direction = "horizontal",
        legend.position = c(0.5, 0.2))  

quartz()
p

ggsave(filename = "soviet_space_dogs.png", plot = p, width = 8, height = 9)

# showtext_auto() 
# p <- ggplot(dogs_flights, aes(x = date_flight, y = altitude)) +
#   geom_jitter(aes(colour = flight_fate), 
#               width = 1, height = 4,
#               show.legend = FALSE) +
#   scale_y_continuous(limits = c(0, 460)) +
#   scale_x_date(date_breaks = "1 years", date_labels = "%Y") +
#   labs(x = "Date of Flight",
#        y = "Altitude (km)",
#        title = "Soviet Space Dogs",
#        subtitle = "sjhdksjhdasjdh",
#        caption = "Source: @Duncan Geere | Graphic: @committedtotape") +
#   theme(
#         plot.background = element_rect(fill = "#383854", colour = "#383854"),
#         panel.background = element_rect(fill = "#F7CFA0"),
#         panel.grid = element_line(colour = "#D74935"),
#         panel.grid.minor = element_blank(),
#         text = element_text(colour = "white", family = "Space Mono"),
#         axis.text = element_text(colour = "white", family = "Space Mono"),
#         plot.margin = margin(10,20,10,10))
# 
# quartz()
# p



# ggplot(all_dogs_flights, aes(x = 1, y = flight_year, fill = flight_fate,
#                              colour = flight_fate)) +
#   geom_dotplot(binaxis = "y", binwidth = 1, stackdir = "center", stackgroups = TRUE,
#                method = "histodot",
#                dotsize = 0.5,
#                show.legend = FALSE) +
#   scale_y_reverse(breaks = seq(1951, 1966, 1)) +
#   labs(y = "Year", x = "") +
#   theme(plot.background = element_rect(fill = "#383854", colour = "#383854"),
#         panel.background = element_rect(fill = "#383854", colour = "#383854"),
#         panel.grid.minor = element_blank(),
#         panel.grid.major.x = element_blank(),
#         text = element_text(colour = "white"),
#         axis.text = element_text(colour = "white"),
#         axis.text.x = element_blank(),
#         plot.margin = margin(10,20,10,10))

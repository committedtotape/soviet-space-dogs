library(tidyverse)
library(showtext)
#library(extrafont)
library(ggforce)
library(ggtext)

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
  geom_point(data = filter(all_dogs_flights, name_latin == 'Kusachka / Otvazhnaya'), 
             shape = 1, colour = "#64DCF4", size = 4.5, stroke = 2) +
  geom_mark_circle(aes(filter = name_latin == 'Laika', label = 'Laika - 3 November 1957', 
                       description = "The 1st living creature in orbit, never expected to survive"),
                   label.family = "Space Mono",
                   label.fontsize = 10,
                   label.colour = c("#E14435", "white"),
                   label.fill = "#383854",
                   label.buffer = unit(1, 'mm'),
                   con.colour = "white",
                   colour = "#383854",
                   con.type = "straight",
                   con.cap = 0) +
  geom_mark_ellipse(aes(filter = date_flight == as.Date("1951-07-29"), 
                       label = 'Dezik and Lisa - 29 July 1951', 
                       description = "The 1st deaths, due to parachute failure"),
                   label.family = "Space Mono",
                   label.fontsize = 10,
                   label.colour = c("#E14435", "white"),
                   label.fill = "#383854",
                   label.buffer = unit(1, 'mm'),
                   con.colour = "white",
                   colour = "#383854",
                   con.type = "straight",
                   con.cap = 0) +
  # geom_mark_circle(aes(filter = name_latin == 'Kusachka / Otvazhnaya' & date_flight == as.Date("1958-08-13"), 
  #                      label = 'Otvazhnaya ("Brave One")', 
  #                      description = "Made the most flights of any space dog"),
  #                  label.family = "Space Mono",
  #                  label.fontsize = 10,
  #                  label.colour = "white",
  #                  label.fill = "#383854",
  #                  label.buffer = unit(1, 'mm'),
  #                  con.colour = "white",
  #                  colour = "#383854",
  #                  con.type = "straight",
  #                  con.cap = 0) +
  geom_mark_ellipse(aes(filter = date_flight == as.Date("1960-08-19"), 
                        label = 'Belka and Strelka - 19 August 1960', 
                        description = "Spent a day in space and safely returned to earth"),
                    label.family = "Space Mono",
                    label.fontsize = 10,
                    label.colour = c("#B98924", "white"),
                    label.fill = "#383854",
                    label.buffer = unit(1, 'mm'),
                    con.colour = "white",
                    colour = "#383854",
                    con.type = "straight",
                    con.cap = 0) +
  geom_rich_text(aes(x = 4.5, y = 1959, 
                     label = "<span style='color:#64DCF4'>**Otvazhnaya ('Brave One')**</span> made the most flights of any space dog"
                     ),
                 fill = NA, label.color = NA,
                 label.padding = grid::unit(rep(0, 4), "pt"),
                 hjust = 0, family = "Space Mono", 
                 color = "white", size = 3.3) +
  scale_y_reverse(breaks = seq(1951, 1966, 1)) +
  scale_fill_manual(values = c("Survived" = "#B98924", "Died" = "#E14435")) +
  labs(y = "", x = "", 
       fill = "Each dot represents a dog and its fate on a mission\nDogs on the same flight are connected by a line",
       title = "Soviet Space Dogs",
       subtitle = "Dogs sent on sub-orbital and orbital space flights by the\nSoviet Space Program in the 1950s and 1960s",
       caption = "Source: @DuncanGeere | Graphic: @committedtotape") +
  theme(plot.background = element_rect(fill = "#383854", colour = "#383854"),
        panel.background = element_rect(fill = "#383854", colour = "#383854"),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        text = element_text(colour = "white", family = "Space Mono"),
        axis.text = element_text(colour = "white"),
        axis.text.x = element_blank(),
        plot.title = element_text(face = "bold", size = 20),
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

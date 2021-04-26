## chapter_05-VisualisationR.R
#
# This file contains all code examples from chapter 5 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

ggplot(flats)

## -- Example 2
#

ggplot(flats, aes(x=floor_size, y=flat_price)) 

## -- Example 3
#

ggplot(flats, aes(x=floor_size, y=flat_price)) +
  geom_point()

## -- Example 4
#

ggplot(flats, aes(x=floor_size, y=flat_price)) +
  geom_point() +
  geom_smooth(method="lm", se=FALSE)

## -- Example 5
#

ggplot(flats, aes(x=floor_size, y=flat_price)) +
  geom_point() +
  geom_smooth(aes(colour=location))

## -- Example 6
#

ggplot(flats, aes(x=floor_size, y=flat_price, colour=location)) +
  geom_point() +
  geom_smooth()

## -- Example 7
#

ggplot(flats, aes(x=floor_size, y=flat_price, colour=location)) +
  geom_point() +
  geom_smooth(colour="blue")

## -- Example 8
#

ggplot(flats, aes(x=flat_price))+
    geom_histogram(binwidth=100000)

## -- Example 9
#

ggplot(flats, aes(x=location,y=flat_price))+
  stat_summary(fun=mean, geom="bar")

## -- Example 10
#

ggplot(flats, aes(x=location,y=flat_price))+
  stat_summary(fun=mean, geom="bar") +
  stat_summary(fun.data=mean_cl_boot, geom="pointrange")

## -- Example 11
#

ggplot(flats, aes(x=location,y=flat_price,fill=energy_efficiency))+
  stat_summary(fun=mean, geom="bar", position="stack") 

## -- Example 12
#

ggplot(flats, aes(x=location, y=energy_efficiency))+
  geom_point(position="jitter")

## -- Example 13
#

ggplot(flats, aes(x=location, y=energy_efficiency))+
  geom_point(position=position_jitter(height=0.1, width=0.2))

## -- Example 14
#

ggplot(flats, aes(x=floor_size, y=flat_price, colour=location)) + 
  geom_point() +
  scale_x_continuous() + 
  scale_y_continuous() + 
  scale_colour_discrete() 

## -- Example 15
#

ggplot(flats, aes(x=floor_size, y=flat_price, colour=location)) + 
  geom_point() +
  scale_x_continuous(breaks = c(50, 100, 150, 200)) + 
  scale_y_continuous(n.breaks=10) + 
  scale_colour_manual(values=c("blue", "yellow", "pink", "red")) 

## -- Example 16
#

ggplot(flats, aes(x=floor_size, y=flat_price)) + 
  geom_point() +
  coord_cartesian(xlim=c(50,150))

## -- Example 17
#

ggplot(flats, aes(x=floor_size, y=flat_price)) + 
  geom_point() +
  coord_flip()

## -- Example 18
#

ggplot(flats, aes(x=year_built, y=flat_price)) + 
  geom_bar(stat="identity") +
  coord_polar()

## -- Example 19
#

ggplot(flats, 
       aes(x=floor_size, y=flat_price, colour=location)) + 
  geom_point() +
  labs(title = "The relationship between price and floor size",
       subtitle = "Floor size as a predictor for selling price",
       caption = "Source: Data from Mehmetoglu & Jakobsen (2017)",
       x = "Floor size in square meters",
       y = "Price of flat in USD",
       tag = "A",
       colour = "Flat location") 

## -- Example 20
#

ggplot(flats, aes(x=floor_size, y=flat_price))+ geom_point()+
  annotate("text", x=130, y=1600000, label="that one is expensive")+
  annotate("rect", xmin=120, xmax=140, 
           ymin=1700000, ymax=1950000, 
           color="red", alpha=0.1)

## -- Example 21
#

ggplot(flats, 
   aes(x=floor_size, y=flat_price, colour = location)) + 
  geom_point() +
   labs(title = "The relationship between price and floor size",
        x = "Floor size in square meters",
        y = "Price of flats",
        colour = "Flat location") +
  theme(plot.title = element_text(size = 10, colour = "brown"),
        axis.title.x = element_text(colour="darkblue", size = 8),
        axis.title.y = element_text(colour="darkblue", size = 8),
        axis.text.x = element_text(angle = -30, face = "bold", 
                                   vjust = 1, hjust = 0),
        axis.text.y = element_text(face = "bold"),
        plot.background = element_rect(fill = "lightgray"),
        legend.text = element_text(size = 8, face = "italic"),
        legend.title = element_text(size = 8, 
                                    colour = "darkblue"),
        legend.background = element_rect(fill = "lightgray", 
                                    colour = "brown", size = 0.5),
        panel.background = element_rect(fill = "lightgray")
    )
  

## -- Example 22
#

ggplot(flats, aes(x=floor_size, y=flat_price)) + 
      geom_point() +
      geom_smooth(method="lm", se=FALSE) +
      facet_wrap(~ location, nrow=1)

## -- Example 23
#

ggplot(flats, aes(x=floor_size, y=flat_price)) + 
      geom_point() +
      geom_smooth(method="lm", se=FALSE) +
      facet_grid(energy_efficiency~location)

## -- Example 24
#

ggplot(flats, aes(x=floor_size)) +
  geom_density()

## -- Example 25
#

ggplot(flats, aes(x=floor_size, fill=location))+
  geom_density(alpha=0.2, bw=20)+
  geom_vline(aes(xintercept=mean(floor_size)), 
             colour="red", linetype="dashed", size=0.3)+
  theme_minimal()

## -- Example 26
#

ggplot(flats, aes(x=floor_size)) +
  geom_histogram()

## -- Example 27
#

ggplot(flats, aes(x=floor_size)) +
  geom_histogram(aes(y=..density..), binwidth = 20, 
                 color = "black", fill = "white") + 
  geom_density(alpha = 0.2, fill = "lightblue") + 
  geom_vline(aes(xintercept=mean(floor_size)), 
                 colour="red", linetype = "dashed", size=0.3) +
  geom_vline(aes(xintercept=median(floor_size)), 
                 colour="green", linetype = "dashed", size=0.3) +

  theme_minimal()  

## -- Example 28
#

ggplot(flats, aes(x=floor_size)) +
  geom_dotplot()

## -- Example 29
#

ggplot(flats, aes(x=floor_size, fill=location)) +
  geom_dotplot(binwidth=10, stackgroups = TRUE, 
               binpositions = "all") +
  theme_minimal()

## -- Example 30
#

ggplot(flats, aes(sample=floor_size)) +
  geom_qq()+
  geom_qq_line()

## -- Example 31
#

ggplot(flats, aes(sample=scale(floor_size))) +
  geom_qq()+
  geom_qq_line()+
  coord_equal()

## -- Example 32
#

ggplot(flats, aes(x = location)) +
  geom_bar()

## -- Example 33
#

ggplot(flats, aes(x = location))+
         geom_bar(aes(fill= energy_efficiency)) +
         geom_text(stat = "count", aes(label = ..count..), 
                   vjust=-0.5) +
         labs(title  = "Flats by location",
              x = "Flat location", 
              y = "Frequency") +
         scale_x_discrete(limits=c("south","west",
                                   "centre","east")) +
    theme_minimal()
  

## -- Example 34
#

ggplot(flats, aes(x="", y=..count.., fill=location)) +
  geom_bar() +
   coord_polar(theta = "y", start = 0) 

## -- Example 35
#

#data management
library(dplyr)
flats2 = flats %>% 
  group_by(location) %>% 
  count() %>% 
  ungroup()%>% 
  arrange(desc(location)) %>%
  mutate(percent = round(n/sum(n),2)*100,
         labelpos = cumsum(percent)-.5*percent)

#pie chart
ggplot(data = flats2, 
       aes(x = "", y = percent, fill = location))+
  geom_bar(stat = "identity", colour="white")+
  coord_polar("y", start = 0) +
  geom_text(aes(y = labelpos, label = paste(percent,"%", 
                                            sep = "")), 
            col = "black") +
  scale_fill_manual(values=c("brown", "orange", 
                             "darkgreen", "darkgray")) +
  theme_void()


## -- Example 36
#

ggplot(flats, aes(x=location, y=flat_price)) +
  geom_boxplot()

## -- Example 37
#

ggplot(flats, aes(x=location, y=flat_price,
                 colour=location)) +
       geom_boxplot() +
       stat_summary(fun=mean, geom="point",
                   colour="blue", aes(group=1)) +
       stat_summary(fun=mean, geom="line",
                    colour="black", aes(group=1)) +
       geom_jitter(colour="grey", size=0.8, width=0.2) +
  theme_minimal()

## -- Example 38
#

ggplot(flats, aes(x=location, y=flat_price, fill=location)) +
  geom_violin()+
  stat_summary(fun.data=mean_cl_boot, geom="pointrange")

## -- Example 39
#

ggplot(flats, aes(x=floor_size, y=flat_price)) +
  geom_point()

## -- Example 40
#

ggplot(flats, aes(x=floor_size, y=flat_price)) +
  geom_point(colour="blue", shape=15) +
  geom_smooth(method="lm", colour="brown") +
  geom_hline(yintercept = mean(flats$flat_price), 
             size=0.5, colour="orange") +
  theme_minimal()


## -- Example 41
#

ggplot(flats, aes(x=floor_size, y=flat_price, colour=location)) +
  geom_point() +
  geom_smooth(method = "lm", se=FALSE)

## -- Example 42
#

ggplot(flats, aes(x=floor_size, y=flat_price, colour=location)) + 
      geom_point() +
      geom_smooth(method="lm", se=FALSE) +
      facet_wrap(~location, nrow=1)


## Script to create slope graphs by region

# Tasks: 

# 1. Determine distance quintiles for each metropolitan area
# 2. For each metro, figure out the proportion of each group located within nearest distance quintile by year
# 3. Plot the slopegraphs with ggplot2


source('R/data_prep.R')

metro[is.na(metro)] <- 0 

metro2 <- metro %>%
  group_by(metroid) %>%
  mutate(quantiles = ntile(distance, 5)) %>%
  mutate(top20 = ifelse(quantiles > 1, 2, 1)) %>%
  ungroup() %>% 
  group_by(metroid, top20) %>%
  summarise_each(funs(sum), europe_2013:total_2000)
  
group_pct <- function(val) { 
  pct <- 100 * (val / sum(val))
  pct
  }



# Let's get the whole of the top X metros and try plotting a slope graph

all <- metro %>%
  group_by(metroid) %>%
  mutate(quantiles = ntile(distance, 5)) %>%
  mutate(top20 = ifelse(quantiles > 1, 2, 1)) %>%
  ungroup() %>%
  group_by(top20) %>%
  summarise_each(funs(sum), europe_2013:total_2000) 

all2 <- all %>%
  mutate_each(funs(group_pct), europe_2013:total_2000) %>%
  gather(key = group, value = percent, -top20) %>%
  separate(group, into = c("region", "year"), sep = "_") %>%
  filter(top20 == 1, region != "total") %>%
  select(-top20) %>%
  mutate(year = as.numeric(year)) %>%
  arrange(region)

labels <- c("Canada", "E/SE Asia", "Europe", "Latin America", "Oceania", "South Asia", 
            "S-S Africa", "SW Asia/N.Africa")

l2 <- rep(labels, each = 2)

all2 <- cbind(all2, l2)

all2$label00 <- paste0(all2$l2, " ", as.character(round(all2$percent, 1)), "% ")

all2$label13 <- paste0("  ", as.character(round(all2$percent, 1)), "%")


# Now, for a try at a slope graph.  

library(ggplot2)
library(extrafont)

ggplot(all2) + 
  geom_line(aes(x = as.factor(year), y = percent, group = region, color = region), size = 2) + 
  geom_point(aes(x = as.factor(year), y = percent, color = region), size = 4) + 
  theme_minimal(base_size = 16) + 
  scale_color_brewer(palette = "Dark2") + 
  xlab("Year") + 
  geom_text(data = subset(all2, year == 2013), 
            aes(x = as.factor(year), y = percent, color = region, label = label13), 
            size = 6, hjust = 0) + 
  geom_text(data = subset(all2, year == 2000 & region != "ssafr"), 
            aes(x = as.factor(year), y = percent, color = region, label = label00), 
            size = 6, hjust = 1, vjust = 0) + 
  geom_text(data = subset(all2, year == 2000 & region == "ssafr"), 
            aes(x = as.factor(year), y = percent, label = label00), 
            color = "#a6761d", size = 6, vjust = 0.8, hjust = 1) + 
  theme(legend.position = "none", 
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(), 
        axis.ticks.y = element_blank(), 
        axis.title.y = element_blank(), 
        axis.text.y = element_blank())

# Great! Now, for small multiples.  NY, LA, Chi, DFW, Houston, DC, Philly, SF/Oak, Atlanta

keep <- c(35620, 31100, 16980, 19100, 26420, 47900, 37980, 41860, 12060)

metro_names <- c("New York", "Los Angeles", "Chicago", "Dallas", "Houston", "Washington", "Philadelphia", 
                 "San Francisco", "Atlanta")

metro_key <- data.frame(cbind(keep, metro_names)) %>%
  mutate(keep = as.numeric(as.character(keep)))

# This gives metro-wise breakdowns

metro3 <- metro2 %>%
  filter(metroid %in% keep) %>%
  group_by(metroid) %>%
  mutate_each(funs(group_pct), europe_2013:total_2000) %>%
  ungroup() %>%
  gather(key = group, value = percent, -top20, -metroid) %>%
  separate(group, into = c("region", "year"), sep = "_") %>%
  filter(top20 == 1, region != "total") %>%
  select(-top20) %>%
  mutate(year = as.numeric(year)) %>%
  left_join(metro_key, by = c("metroid" = "keep")) %>%
  arrange(region)

labels <- c("Canada", "E/SE Asia", "Europe", "Latin America", "Oceania", "South Asia", 
            "S-S Africa", "SW Asia/N.Africa")

l2 <- rep(labels, each = 18)

metro3 <- cbind(metro3, l2)

metro3$label00 <- paste0(as.character(round(metro3$percent, 1)), "% ")

metro3$label13 <- paste0("  ", as.character(round(metro3$percent, 1)), "%")

# Latin America

latam <- filter(metro3, region == "latam")

ggplot(latam) + 
  geom_line(aes(x = as.factor(year), y = percent, group = region), size = 1.5, color = "#e7298a") + 
  geom_point(aes(x = as.factor(year), y = percent), size = 3, color = "#e7298a") + 
  theme_minimal(base_size = 16) + 
  xlab("Year") + 
  geom_text(data = subset(latam, year == 2013), 
            aes(x = as.factor(year), y = percent, label = label13), 
            size = 4, hjust = 0, color = "#e7298a") + 
  geom_text(data = subset(latam, year == 2000), 
            aes(x = as.factor(year), y = percent, label = label00), 
            size = 4, hjust = 1, color = "#e7298a") + 
  facet_wrap(~metro_names) + 
  theme(panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(), 
        axis.ticks.y = element_blank(), 
        axis.title.y = element_blank(), 
        axis.text.y = element_blank()) + 
  ggtitle("Percent of Latin American immigrants living in nearest fifth of Census tracts")

# E/SE Asia

ese <- filter(metro3, region == "eseasia")

ggplot(ese) + 
  geom_line(aes(x = as.factor(year), y = percent, group = region), size = 1.5, color = "#d95f02") + 
  geom_point(aes(x = as.factor(year), y = percent), size = 3, color = "#d95f02") + 
  theme_minimal(base_size = 16) + 
  xlab("Year") + 
  geom_text(data = subset(ese, year == 2013), 
            aes(x = as.factor(year), y = percent, label = label13), 
            size = 4, hjust = 0, color = "#d95f02") + 
  geom_text(data = subset(ese, year == 2000), 
            aes(x = as.factor(year), y = percent, label = label00), 
            size = 4, hjust = 1, color = "#d95f02") + 
  facet_wrap(~metro_names) + 
  theme(panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(), 
        axis.ticks.y = element_blank(), 
        axis.title.y = element_blank(), 
        axis.text.y = element_blank()) + 
  ggtitle("Percent of East and SE Asian immigrants living in nearest fifth of Census tracts")




# ggplot(metro3) + 
#   geom_line(aes(x = as.factor(year), y = percent, group = region, color = region), size = 2) + 
#   geom_point(aes(x = as.factor(year), y = percent, color = region), size = 4) + 
#   theme_minimal(base_size = 16) + 
#   scale_color_brewer(palette = "Dark2") + 
#   xlab("Year") + 
#   geom_text(data = subset(metro3, year == 2013), 
#             aes(x = as.factor(year), y = percent, color = region, label = label13), 
#             size = 6, hjust = 0) + 
#   geom_text(data = subset(metro3, year == 2000), 
#             aes(x = as.factor(year), y = percent, color = region, label = label00), 
#             size = 6, hjust = 1, vjust = 0) + 
#   facet_wrap(~metro_names) + 
#   theme(panel.grid.major.y = element_blank(),
#         panel.grid.minor.y = element_blank(), 
#         axis.ticks.y = element_blank(), 
#         axis.title.y = element_blank(), 
#         axis.text.y = element_blank())

# Example:   

# library(ggplot2)
# library(scales)
# months<-24
# year1<-c(1338229205,5212325386,31725112511)
# year3<-c(1372425378,8836570075,49574919628)
# group<-c("Group C", "Group B", "Group A")
# a<-data.frame(year1,year3,group)
# l11<-paste(a$group,comma_format()(round(a$year1/(3600*24*30.5))),sep="\n")
# l13<-paste(a$group,comma_format()(round(a$year3/(3600*24*30.5))),sep="\n")
# p<-ggplot(a) + geom_segment(aes(x=0,xend=months,y=year1,yend=year3),size=.75)
# p<-p + theme(panel.background = element_blank())
# p<-p + theme(panel.grid=element_blank())
# p<-p + theme(axis.ticks=element_blank())
# p<-p + theme(axis.text=element_blank())
# p<-p + theme(panel.border=element_blank())
# p<-p + xlab("") + ylab("Amount Used")
# p<-p + theme(axis.title.y=element_text(vjust=3))
# p<-p + xlim((0-12),(months+12))
# p<-p + ylim(0,(1.2*(max(a$year3,a$year1))))
# p<-p + geom_text(label=l13, y=a$year3, x=rep.int(months,length(a)),hjust=-0.2,size=3.5)
# p<-p + geom_text(label=l11, y=a$year1, x=rep.int( 0,length(a)),hjust=1.2,size=3.5)
# p<-p + geom_text(label="Year 1", x=0,     y=(1.1*(max(a$year3,a$year1))),hjust= 1.2,size=5)
# p<-p + geom_text(label="Year 3", x=months,y=(1.1*(max(a$year3,a$year1))),hjust=-0.1,size=5)
p
library("jsonlite")

# https://datahub.io/core/co2-fossil-global#r

json_file <- 'https://datahub.io/core/co2-fossil-global/datapackage.json'
json_data <- fromJSON(paste(readLines(json_file), collapse=""))

# print all tabular data(if exists any)
for(i in 1:length(json_data$resources$datahub$type)){
  if(json_data$resources$datahub$type[i]=='derived/csv'){
    path_to_file = json_data$resources$path[i]
    data <- read.csv(url(path_to_file))
  }
}


library(ggplot2)
p1 <- ggplot() +
  geom_point(data = data, aes(x = Year, y = Total),
             size = 1) +
  ylab(bquote(CO[2] ~ "emission [Mmt C]") ) +
  theme(axis.text = element_text(size = 9),
        plot.caption = element_text(hjust = 0, face = "italic", size = 7),
        plot.caption.position = "plot") +
  labs(caption = bquote(CO[2] ~"Emission from Fossil fuels Million metric tons. Data from: https://datahub.io/core/co2-fossil-global#r") )




json_file <- 'https://datahub.io/core/global-temp/datapackage.json'
json_data <- fromJSON(paste(readLines(json_file), collapse=""))

# print all tabular data(if exists any)
for(i in 1:length(json_data$resources$datahub$type)){
  if(json_data$resources$datahub$type[i]=='derived/csv'){
    path_to_file = json_data$resources$path[i]
    data <- read.csv(url(path_to_file))
  }
}

p2 <- ggplot() +
  geom_line(data = data, aes(x = as.Date(Date), y = Mean),
             size = 1) +
  ylab(paste0("global mean T [", intToUtf8(176), "C]") ) +
  xlab("Year") +
  theme(axis.text = element_text(size = 9),
        plot.caption = element_text(hjust = 0, face = "italic", size = 7),
        plot.caption.position = "plot") +
  labs(caption = paste0("Average global mean T anomalies [", intToUtf8(176), "C] ",  "relative to a base period. GISTEMP base period: 1951-1980. GCAG base period: 20th century average. Data from: https://datahub.io/core/global-temp#r") )


json_file <- 'https://datahub.io/core/sea-level-rise/datapackage.json'
json_data <- fromJSON(paste(readLines(json_file), collapse=""))

# print all tabular data(if exists any)
for(i in 1:length(json_data$resources$datahub$type)){
  if(json_data$resources$datahub$type[i]=='derived/csv'){
    path_to_file = json_data$resources$path[i]
    data <- read.csv(url(path_to_file))
  }
}

p3 <- ggplot() +
  geom_line(data = data, aes(x = as.Date(Year), y = CSIRO.Adjusted.Sea.Level*2.54),
            size = 1) +
  ylab("Cum. sea level [cm]") +
  xlab("Year") +
  theme(axis.text = element_text(size = 9),
        plot.caption = element_text(hjust = 0, face = "italic", size = 8),
        plot.caption.position = "plot") +
  labs(caption = "Comulative changes in sea level for the world’s oceans based on the combination of long-term tide gauge measurements and recent satellite measurements. Data from: https://datahub.io/core/sea-level-rise#r")

library(ggpubr)

p <- ggarrange(p1, p2, p3, ncol = 1)

tiff("/home/konrad/Documents/0Uni/programming/climatechange/climatechange.tiff",
     width = 880)
print(p)
dev.off()

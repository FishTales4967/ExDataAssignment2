plot3 <- {
  ##
  ## Plot total annual emissions by source for Baltimore only across time using ggplot2
  ##
  library(dplyr)
  library(ggplot2)
  
  NEI <- readRDS("summarySCC_PM25.rds")
  bmore <- subset(NEI,fips=="24510")
  # creating lg_emiss for emissions in log units. adding small constant, .001, to avoid log of 0
  bmore <- mutate(bmore,lg_miss=log10(Emissions+.001),type=as.factor(type),year=as.factor(year))
  #create labels and graph data file
  g <- ggplot(bmore,aes(year,lg_miss))
  xlabel <- "NONPOINT median is little changed since 1999, but other types decreased "
  ylabel <- "Emissions (log units)"
  maintitle <- "Baltimore Emissions over time by type of emission"
  print(g + geom_boxplot()+labs(list(title=maintitle,x=xlabel, y=ylabel))+facet_grid(.~type))
  dev.copy(png, file="plot3.png")
  dev.off()
}
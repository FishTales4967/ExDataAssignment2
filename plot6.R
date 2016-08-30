plot6 <- {
  ##
  ## Plot total annual emissions for Baltimore vs Los Angeles across time
  ##
  library(dplyr)
  library(ggplot2)
 
  #setwd("I:\myRLib\rprog-Course4_Week4\Data")
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  #Select records related to two cities, Baltimore and LA
  bmore <- as.data.frame(subset(NEI,fips=="24510")) %>% mutate(city="Baltimore")
  LA <- as.data.frame(subset(NEI,fips=="06037")) %>% mutate(city="LosAngeles")
  cities <- rbind(bmore,LA) %>% select(c(SCC,city,Emissions,year))  %>% group_by(city)
  #Filter SCC codes related to  Motor Vehicles
  Mtr_Veh <- SCC[SCC$SCC.Level.One == "Mobile Sources",]
  Mtr_Veh <- Mtr_Veh[grep("[Vv]eh|Motorcycle",Mtr_Veh$Short.Name),c(1,3)]
  #filter the emissions data for only rows related to Motor Vehicles
  MtrVehRec <- cities[cities$SCC %in% Mtr_Veh[,1],]
  # compute total emissions for motor vehicles by year and city
  sumby_yr <- with(MtrVehRec,aggregate(x=Emissions,by=list(year=year,city=city),sum)) %>% rename(TotalEmissions=x)
  
  #create plot object
  xlabel <- "Relative to 1999, Baltimore total emissions fell over time, but LA increased"
  ylabel <- "Sum of Annual Emissions "
  maintitle <- " Motor Vehicle emissions over time, Baltimore vs Los Angeles"
  print(qplot(as.factor(year),TotalEmissions,data=sumby_yr, color=city,main=maintitle,xlab=xlabel, ylab=ylabel))

  dev.copy(png, file="plot6.png")
  dev.off()
  
}
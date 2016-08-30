plot5 <- {
  ##
  ## Plot motor vehicle emissions for Baltimore only across time 
  ## question is poorly specified so I plotted distributions
  ##
  library(dplyr)
  library(ggplot2)
  #setwd("I:\myRLib\rprog-Course4_Week4\Data")
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  #Select records related to Baltimore
  bmore <- as.data.frame(subset(NEI,fips=="24510"))

  #Filter SCC codes related to  Motor Vehicles
  Mtr_Veh <- SCC[SCC$SCC.Level.One == "Mobile Sources",]
  Mtr_Veh <- Mtr_Veh[grep("[Vv]eh|Motorcycle",Mtr_Veh$Short.Name),c(1,3)]
  #filter the data for only rows related to Motor Vehicles
  MtrVehRec <- bmore[bmore$SCC %in% Mtr_Veh[,1],]
  # expressing emissions in log units but adding small constant, .001, to avoid log of 0
  k <-ggplot(MtrVehRec,aes(as.factor(year),log10(Emissions+.001)))
  
  xlabel <- "Median of Emissions Distribution has dropped over time, but recent increases"
  ylabel <- "Emissions (log units)"
  maintitle <- "Baltimore only, Motor Vehicle emissions over time"
  print(k + geom_boxplot()+labs(list(title=maintitle,x=xlabel, y=ylabel)))
  dev.copy(png, file="plot5.png")
  dev.off()
}
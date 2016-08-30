plot1 <- {
  ##
  ## Plot total annual emissions for all locations across time using base plot
  ##
  library(dplyr)
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  # total emissions by year
  totNEI <- with(NEI,aggregate(Emissions,by=list(year=year),sum))  
  # create total emissions in units of million 
  totNEI <- mutate(totNEI, TotalEmissions=x/1000000)
  ylabel <- "Total PM25 Emissions (in Millions)"
  png("plot1.PNG", width=480,height=480,unit="px")
  with(totNEI, plot(year,TotalEmissions,xlab="Year",ylab=ylabel,pch=8,col="red"))
  title(main="Total Annual Emissions, All Locations")
  dev.off()
}
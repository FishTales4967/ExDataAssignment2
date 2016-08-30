plot2 <- {
  ##
  ## Plot total annual emissions for Baltimore only across time using base plot
  ##
  library(dplyr)
  NEI <- readRDS("summarySCC_PM25.rds")
  # select Baltimore only
  bmore <- subset(NEI,fips=="24510")
  # create values for sum of annual emissions by year
  sumby_yr <- with(bmore,aggregate(x=Emissions,by=list(year=year),sum)) %>% rename(TotalEmissions=x)
  png("plot2.PNG")
  with(sumby_yr,(plot(year,TotalEmissions,pch=8,col="red", xlab="Measurement Year",ylab="PM25 Annual Emissions Total")))
  title(main="Baltimore only, Annual PM25 Emissions ")
  title(sub="Annual emissions lower in follow-up years than initial year",adj=0,col.sub="blue")
  dev.off()
}
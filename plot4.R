plot4 <- {
  ##
  ## Plot emissions for coal combustion across time  
  ## Question is ill-defined so I plotted the distributions
  ##
  library(dplyr)
  library(ggplot2)
 
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  #Select codes related to Coal
  coalcodes <- SCC[grep("[Cc]oal",SCC$Short.Name),c(1,3)]
  #Filter again for codes related to  Combustion ("Comb")
  coalcomb <- coalcodes[grep("[Cc]omb",coalcodes$Short.Name),]
  #filter the data for only rows related to Coal AND Combustion
  coalrec <- NEI[NEI$SCC %in% coalcomb[,1],]
  # expressing emissions in log units but adding small constant, .001, to avoid log of 0
  g<-ggplot(coalrec,aes(as.factor(year),log10(Emissions+.001)))
  
  xlabel <- "Median of Emissions Distribution has dropped over time, but outliers still exist"
  ylabel <- "Emissions (log units)"
  maintitle <- "Combustion-related coal emissions over time"
  print(g + geom_boxplot()+labs(list(title=maintitle,x=xlabel, y=ylabel)))
  dev.copy(png, file="plot4.png")
  dev.off()
}
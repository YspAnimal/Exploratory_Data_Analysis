#Work in default working directory
#Download file, unzip it if it does not exist
setwd("C:/Users/soloveynv/Documents/R Scripts/Coursera/Exploratory_Data_Analysis/Exploratory_Data_Analysis_CourseProject2")
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destFile <- "exdatadataNEI_data.zip"
if (!file.exists(destFile)){
  download.file(URL, destfile = destFile, mode='wb')
  unzip(destFile)
}

#Read files to data.frame using readRDS() function
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#User dplyr package to summarise Emissions data
#I use log() function to make more readable result
library(dplyr)
library(plyr)
NEIBaltimor <- filter(NEI, fips == "24510")
NEILA <- filter(NEI, fips == "06073")
#First make subset of SCC data contains only motor vehicle sources
SCC <- SCC[grep("vehicle", SCC$EI.Sector, ignore.case=T), ]
#Second make subset of NEI data for coal combustion
NEIBaltimor <- NEIBaltimor[NEIBaltimor$SCC %in% SCC$SCC, ]
NEILA <- NEILA[NEILA$SCC %in% SCC$SCC, ]
#Summarise result by type and year
NEIBaltimor <- ddply(NEIBaltimor, "year", summarise, Emissions = log(sum(Emissions)))
NEILA <- ddply(NEILA, "year", summarise, Emissions = log(sum(Emissions)))

#Open graphic device PNG and Draw figure
library(ggplot2)
png(filename = "plot6.png", width = 480, height = 480, units = "px")
ggplot() + 
  #At first create plot by type 
  geom_line(aes(year, Emissions, color = "Baltimore City"), NEIBaltimor)+ 
  #At second add aggregate result by year
  geom_line(aes(year, Emissions, color = "Los Angeles"), NEILA)+
  labs(x = "Year")+
  labs(y = expression("log Emissions"))+
  labs(title = "Total PM2.5 emissions from motor vehicle by City")
dev.off()

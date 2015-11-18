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

#Use dplyr package to subsetting and summarise Emissions data per year and type by state
#I use log() function to make more readable result
library(dplyr)
NEISubset <- filter(NEI, fips == "24510")
NEISubset <- ddply(NEISubset, type~year, summarise, Emissions = log(sum(Emissions)))

#Open graphic device PNG and Draw figure
library(ggplot2)
png(filename = "plot3.png", width = 480, height = 480, units = "px")
qplot(year, Emissions, data = NEISubset, color = type, main = "Total PM2.5 emissions in the Baltimore City by type") + geom_smooth()
dev.off()

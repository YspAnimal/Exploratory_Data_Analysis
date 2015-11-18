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

#Use dplyr package to subsetting and summarise Emissions data per year by state
#I use log() function to make more readable result
library(dplyr)
NEISubset <- filter(NEI, fips == "24510")
NEISubset <- ddply(NEISubset, "year", summarise, Emissions = log(sum(Emissions)))

#Open graphic device PNG and Draw figure
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(NEISubset$year, NEISubset$Emissions, type = "l", main = "Total PM2.5 emissions in the Baltimore City", xlab = "Year", ylab = "Total emissions (Log)")
points(NEISubset$year, NEISubset$Emissions, pch=15)
axis(1, at = seq(1999, 2008, by = 1))
dev.off()










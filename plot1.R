#set my working directory
setwd("C:/Users/soloveynv/Documents/R Scripts/Coursera/Exploratory_Data_Analysis")
#Download file, unzip it if it does not exist
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFile <- "power_consumption.zip"
if (!file.exists(destFile)){
  download.file(URL, destfile = destFile, mode='wb')
  unzip(destFile)
}
#Try to read subset of data using SQL methods 
library(RSQLite)
# Create/Connect to a database
con <- dbConnect(RSQLite::SQLite(), dbname = ":memory:")

# read txt file into temp sql database
dbWriteTable(con, name="household_power_consumption", value="household_power_consumption.txt", 
             row.names=F, header=T, sep = ";")

# Query your data as you like
PowerDataFeb <- dbGetQuery(con, "SELECT * FROM household_power_consumption WHERE (Date = '1/2/2007' or Date = '2/2/2007')")
#Close connection
dbDisconnect(con)


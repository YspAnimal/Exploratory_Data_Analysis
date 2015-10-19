#Work in default working directory
#Download file, unzip it if it does not exist
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFile <- "power_consumption.zip"
if (!file.exists(destFile)){
  download.file(URL, destfile = destFile, mode='wb')
  unzip(destFile)
}
#Try to read subset of data using SQL methods(just for practice) 
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

#Convert the Date and Time variables to Date/Time classes 
PowerDataFeb$Date <- as.Date(PowerDataFeb$Date, format = "%d/%m/%Y")
PowerDataFeb$timetemp <- paste(PowerDataFeb$Date, PowerDataFeb$Time)
PowerDataFeb$Time <- strptime(PowerDataFeb$timetemp, format = "%Y-%m-%d %H:%M:%S")

#Open graphic device PNG and Draw figure Histogram
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(PowerDataFeb$Global_active_power, col = "red", main = "Global Active Power", xlab = "Globa Active Power (kilowatts)")
dev.off()

















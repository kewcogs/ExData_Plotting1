# Create plot for Global Active Power histogram
# Part 1 (of 4) Exploratory Data Analysis assignment 1

library(data.table)

DataFileName = "./data/household_power_consumption.txt"

# Read in data table, filtering out lines not in 
#   date range 2007-02-01 to 2007-02-02
DataFileFilter = paste('grep "^[12]/2/2007"', DataFileName)
data <- fread(DataFileFilter, header=F, sep=";",
              colClasses=c("character", "character", rep("numeric",7)))
# filtering loses column names - apply column names from original file
headers <- fread(DataFileName, sep=";", nrows=0, header=T)
setnames(data, colnames(data), colnames(headers))

# add combined DateTime column derived from Date and Time columns
data[,"DateTime":=as.POSIXct(paste(Date,Time), format="%d/%m/%Y %T")]

# draw line plot of Global Active Power over time to .png file
png(filename="plot2.png", width=480, height=480) #set up graphics device
with(data, plot(DateTime, Global_active_power, 
                type="l",
                xlab="",
                ylab="Global Active Power (kilowatts)"))
dev.off()  # close PNG device
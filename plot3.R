# Create plot for Energy sub-metering vs Time
# Part 3 (of 4) Exploratory Data Analysis assignment 1

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

# draw line plot of Energy sub-metering over time to .png file
png(filename="plot3.png", width=480, height=480) #set up graphics device
with(data, plot(DateTime, Sub_metering_1, 
                type="l",
                col="black",
                xlab="",
                ylab="Energy sub metering"))
with(data, lines(DateTime, Sub_metering_2, col="red"))
with(data, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lwd=2,
       col=c("black","red","blue"),
       legend=c("Sub_metering_1", "Sub_metering_3", "Sub_metering_3"))
dev.off()  # close PNG device
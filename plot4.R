# Create multiple plots 
# Part 4 (of 4) Exploratory Data Analysis assignment 1

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

# draw multiple plots to .png file
png(filename="plot4.png", width=480, height=480) #set up graphics device

par(mfcol = c(2,2))  # 4 plots arranged 2 by 2

# First plot - top left
with(data, plot(DateTime, Global_active_power, 
                type="l",
                xlab="",
                ylab="Global Active Power"))

# Second plot - bottom left
with(data, plot(DateTime, Sub_metering_1, 
                type="l",
                col="black",
                xlab="",
                ylab="Energy sub metering"))
with(data, lines(DateTime, Sub_metering_2, col="red"))
with(data, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lwd=2, bty="n",
       col=c("black","red","blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Third plot - top right
with(data, plot(DateTime, Voltage, 
                type="l", col="black", xlab="datetime"))

# Fourth plot - bottom right
with(data, plot(DateTime, Global_reactive_power, 
                type="l", col="black", xlab="datetime"))

dev.off()  # close PNG device
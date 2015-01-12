# Generate plot #2
# 
# Author: dani
###############################################################################

library(graphics)

dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household.zip"
file <- "household_power_consumption.txt"
startDate = as.Date("2007-02-01")
endDate = as.Date("2007-02-02")

# Download and unzip
download.file(dataURL, zipFile, method = "curl")
unzip(zipFile)

# Extract data
data <- read.table(file, header = TRUE, sep = ";", na.strings = "?")
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S", tz = "GMT")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- data[data$Date >= startDate & data$Date <= endDate, ]

# Graph
par(mfrow = c(2, 2))
with(data, {
    plot(DateTime, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
    plot(DateTime, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
    plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
    lines(DateTime, Sub_metering_2, type = "l", col = "red")
    lines(DateTime, Sub_metering_3, type = "l", col = "blue")
    legend("topright", names(data)[7:9], col = c("black", "red", "blue"), lty = 1)
    plot(DateTime, Global_reactive_power, xlab = "datetime", type = "l")
})
dev.copy(png, file = "plot4.png")
dev.off()

# Generate plot #1
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
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red")
title(main = "Global Active Power")
dev.copy(png, file = "plot1.png")
dev.off()
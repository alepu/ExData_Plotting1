library(data.table)

format_date <- "%d/%m/%Y"  # format for the date

# reads the file in tempdata and then select only the interesting rows and
# check for NA
filename = "household_power_consumption.txt"
tempdata <- as.data.frame(fread(filename, sep = ";", na.strings = c("NA","?")))
tempdata[,1] <- as.Date(tempdata[,1], format_date)
eldata <- subset(tempdata, (Date == "2007-02-01" | Date == "2007-02-02") 
                 & !is.na(tempdata$Sub_metering_1)
                 & !is.na(tempdata$Sub_metering_1)
                 & !is.na(tempdata$Sub_metering_1))

# Time series
eldata$Time = strptime(paste(eldata$Date,eldata$Time), '%Y-%m-%d %H:%M:%S')

# Generates the plot
plot(eldata$Time, eldata$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(eldata$Time,eldata$Sub_metering_1 )
lines(eldata$Time,eldata$Sub_metering_2, col = "red" )
lines(eldata$Time,eldata$Sub_metering_3, col = "blue" )
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"))

# Creating the png file
dev.copy(png, "plot3.png", width=480, height=480)
dev.off()

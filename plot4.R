library(data.table)

format_date <- "%d/%m/%Y"  # format for the date

filename = "household_power_consumption.txt"

# reads the file in tempdata and then select only the interesting rows and
# check for NA
tempdata <- as.data.frame(fread(filename, sep = ";", na.strings = c("NA","?")))
tempdata[,1] <- as.Date(tempdata[,1], format_date)
eldata <- subset(tempdata, (Date == "2007-02-01" | Date == "2007-02-02") 
                 & !is.na(tempdata$Global_active_power)
                 & !is.na(tempdata$Sub_metering_1)
                 & !is.na(tempdata$Sub_metering_1)
                 & !is.na(tempdata$Sub_metering_1))

X <- strptime(paste(eldata$Date,eldata$Time), '%Y-%m-%d %H:%M:%S')

# Generates the plot
par(mar = c(5,4,2,2),mfcol = c(2,2))

plot(X, eldata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(X, eldata$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(X,eldata$Sub_metering_1 )
lines(X,eldata$Sub_metering_2, col = "red" )
lines(X,eldata$Sub_metering_3, col = "blue" )
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), col = c("black", "red", "blue"), bty = "n")

plot(X, eldata$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(X, eldata$Global_reactive_power,type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# Creating the png file
dev.copy(png, "plot2.png", width=480, height=480)
dev.off()

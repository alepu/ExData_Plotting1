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

X <- (1:length(eldata$Time)) # creates the X vector

# Generates the plot
png("plot4.png", width = 480, height = 480, units = "px")

par(mar = c(5,4,2,2),mfcol = c(2,2))

plot(X, eldata$Global_active_power, xaxt = "n", type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
axis(side = 1, at = c(0,length(X)/2,length(X)), labels=c("Thu","Fri","Sat")) 

plot(X, eldata$Sub_metering_1, xaxt = "n", type = "n", xlab = "", ylab = "Energy sub metering")
lines(X,eldata$Sub_metering_1 )
lines(X,eldata$Sub_metering_2, col = "red" )
lines(X,eldata$Sub_metering_3, col = "blue" )
axis(side = 1, at = c(0,length(X)/2,length(X)), labels=c("Thu","Fri","Sat"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"))

plot(X, eldata$Voltage, xaxt = "n", type = "l", xlab = "datetime", ylab = "Voltage")
axis(side = 1, at = c(0,length(X)/2,length(X)), labels=c("Thu","Fri","Sat")) 

plot(X, eldata$Global_reactive_power, xaxt = "n", type = "l", xlab = "datetime", ylab = "Global_reactive_power")
axis(side = 1, at = c(0,length(X)/2,length(X)), labels=c("Thu","Fri","Sat")) 

dev.off()
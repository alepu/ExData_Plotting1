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

X <- (1:length(eldata$Date))  # creates the X vector

# Generates the plot
png("plot3.png", width = 480, height = 480, units = "px")

plot(X, eldata$Sub_metering_1, xaxt = "n", type = "n", xlab = "", ylab = "Energy sub metering")
lines(X,eldata$Sub_metering_1 )
lines(X,eldata$Sub_metering_2, col = "red" )
lines(X,eldata$Sub_metering_3, col = "blue" )
axis(side = 1, at = c(0,length(X)/2,length(X)), labels=c("Thu","Fri","Sat"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"))

dev.off()

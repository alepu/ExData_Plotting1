library(data.table)

format_date <- "%d/%m/%Y"  # format for the date

# reads the file in tempdata and then select only the interesting rows and
# check for NA

filename = "household_power_consumption.txt"
tempdata <- as.data.frame(fread(filename, sep = ";", na.strings = c("NA","?")))
tempdata[,1] <- as.Date(tempdata[,1], format_date)
eldata <- subset(tempdata, (Date == "2007-02-01" | Date == "2007-02-02") & 
                         !is.na(tempdata$Global_active_power))

# Generates the plot
png("plot1.png", width = 480, height = 480, units = "px")
hist(eldata$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", col = "red", main = "Global Active Power")
dev.off()


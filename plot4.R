# this code first reads in the household_power_consumption.txt file which contains 
# measurements of electric power consumption in one household with a one-minute 
# sampling rate over a period of almost 4 years. 

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./household_power_consumption.zip")
unzip("./household_power_consumption.zip")

power_consumption <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", 
                                stringsAsFactors = FALSE, na.strings = "?")
pow_con_feb <- subset(power_consumption, Date == "1/2/2007" | Date == "2/2/2007")
pow_con_feb <- unite(pow_con_feb, Timestamp, Date, Time, sep = " ")
pow_con_feb$Timestamp <- as.POSIXct(pow_con_feb$Timestamp, format = "%d/%m/%Y %H:%M:%S")

# Next the code constructs a matrix of four plots depicting 
# 1) Global Active Power 
# 2) Voltage
# 3) Energy sub metering
# 4) Global Reactive Power
# over a two-day period in February, 2007, and saves it into 
# a .PNG file of size 480 pixels by 480 pixels.

png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2,2), mar = c(5,4,4,1))
with(pow_con_feb, plot(Timestamp, Global_active_power, type = "l", xlab = "", 
                       ylab = "Global Active Power"))
with(pow_con_feb, plot(Timestamp, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(pow_con_feb, points(Timestamp, Sub_metering_2, col = "red", type = "l"))
with(pow_con_feb, points(Timestamp, Sub_metering_3, col = "blue", type = "l"))
legend("topright", col = c("black", "red", "blue"), xjust = 1, lwd = 1, bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
with(pow_con_feb, plot(Timestamp, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
with(pow_con_feb, plot(Timestamp, Global_reactive_power, type = "l", 
xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()
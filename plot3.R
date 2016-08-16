# This code first downloads the "household_power_consumption.zip" file from the url provided.
# The data provides measurements of electric power consumption in one household with a one-minute 
# sampling rate over a period of almost 4 years.
# The file is unzipped and read in for further processing. All the files are stored in the
# user's current working directory to make the code portable. 

library(tidyr) 	# load 'tidyr' for data.frame processing

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./household_power_consumption.zip")
unzip("./household_power_consumption.zip")

power_consumption <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", 
                                stringsAsFactors = FALSE, na.strings = "?")

# the data is subsetted to consider only the two dates of 1st and 2nd February, 2007
pow_con_feb <- subset(power_consumption, Date == "1/2/2007" | Date == "2/2/2007")

# combination of Date and Time columns, and conversion to POSIXct format.
pow_con_feb <- unite(pow_con_feb, Timestamp, Date, Time, sep = " ")
pow_con_feb$Timestamp <- as.POSIXct(pow_con_feb$Timestamp, format = "%d/%m/%Y %H:%M:%S")

# Next the code constructs a line plot depicting energy sub-metering for three
# separate cases over a two-day period in February, 2007, and saves it into a .PNG file 
# of size 480 pixels by 480 pixels.

png(filename = "plot3.png", width = 480, height = 480)
with(pow_con_feb, plot(Timestamp, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(pow_con_feb, points(Timestamp, Sub_metering_2, col = "red", type = "l"))
with(pow_con_feb, points(Timestamp, Sub_metering_3, col = "blue", type = "l"))
legend("topright", col = c("black", "red", "blue"), xjust = 1, lwd = 1,
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()
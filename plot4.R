library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile="data.zip")
unzip("data.zip")

# Load the data into a table
data <- read.table("household_power_consumption.txt",
                   header=TRUE,
                   sep=";",
                   na.strings="?",
                   colClasses=c("character","character", "numeric","numeric",
                                "numeric","numeric","numeric","numeric",
                                "numeric"))

# Subset for the dates of interest
data <- filter(data, Date=="1/2/2007"|Date=="2/2/2007")

# Convert dates from character to type Date
x<-paste(data$Date, data$Time)
data$Date<-strptime(x, "%d/%m/%Y %H:%M:%S")

# plot the relevant graph
png("plot4.png",width=480, height=480, bg="transparent" )
par(mfrow=c(2,2))
plot(data$Date, 
     data$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power(kilowatts)")

plot(data$Date,
     data$Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage")

plot(data$Date, 
     data$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering")
points(data$Date, 
       data$Sub_metering_2,
       type="l",
       col="red")
points(data$Date, 
       data$Sub_metering_3,
       type="l",
       col="blue")
legend.txt<-c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend.col<-c("black", "red", "blue")
legend("topright",
       legend=legend.txt,
       col=legend.col,
       lwd=1,
       bty="n",
       cex=.94)

plot(data$Date,
     data$Global_reactive_power,
     type="l",
     xlab="datetime",
     ylab="Globa_reactive_power")

dev.off()

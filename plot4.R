library(data.table)
library(dplyr)
library(lubridate)

# get data
data<-read.table(unz('power_consumption.zip', 'household_power_consumption.txt'),sep = ";", header = T)

#format data
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
data$Time <- strptime(data$Time,format = "%H:%M:%S")
data$Time <- as.ITime(data$Time)

#subset based on date
subdata <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

#manipulate data
subdata$DateTime <- as.POSIXct(paste(subdata$Date,subdata$Time),format="%Y-%m-%d %H:%M:%S")

par(mfrow=c(2,2))

plot(subdata$DateTime,as.numeric(as.character(subdata$Global_active_power)),type="l",ylab=
       "Global Active Power", xlab = "")

plot(subdata$DateTime,as.numeric(as.character(subdata$Voltage)),type="l",ylab=
       "Voltage", xlab = "datetime")

plot(subdata$DateTime,as.numeric(as.character(subdata$Sub_metering_1)),type="l",ylab="Energy sub metering)", xlab = "")
lines(subdata$DateTime,as.numeric(as.character(subdata$Sub_metering_2)),type="l", col = "red")
lines(subdata$DateTime,as.numeric(as.character(subdata$Sub_metering_3)),type="l", col = "blue")
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lty = 1)

plot(subdata$DateTime,as.numeric(as.character(subdata$Global_reactive_power)),type="l",ylab=
       "Global_reactive_power", xlab = "datetime")



#dev.copy(png, file = "plot4.png")
#dev.off

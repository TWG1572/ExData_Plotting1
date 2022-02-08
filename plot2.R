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
  

plot(subdata$DateTime,as.numeric(as.character(subdata$Global_active_power)),type="l",ylab=
       "Global Active Power (kilowatts)", xlab = "")


dev.copy(png, file = "plot2.png")
dev.off


library(data.table)

# get data
data<-read.table(unz('power_consumption.zip', 'household_power_consumption.txt'),sep = ";", header = T)

#format data
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
data$Time <- strptime(data$Time,format = "%H:%M:%S")
data$Time <- as.ITime(data$Time)

#subset based on date
subdata <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

hist(as.numeric(as.character(subdata$Global_active_power)),col="red", main = "Global Active Power", ylab="Frequency", xlab = "Global Active Power(kilowatts)")

dev.copy(png, file = "plot1.png")
dev.off


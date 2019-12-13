#Read dataset
hpcdata <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?",comment.char="",check.names=F, quote='\"', stringsAsFactors=F)
#Format date column
hpcdata$Date <- as.Date(hpcdata$Date, format="%d/%m/%Y")
#Subset the data accordingly
subsethpcdata <- subset(hpcdata, subset=(Date=="2007-02-01" | Date=="2007-02-02"))
#Include time as posixct to datetime variable
datetime<- paste(subsethpcdata$Date, subsethpcdata$Time)
subsethpcdata$datetime <- as.POSIXct(datetime)
#Create plot and save to the file
par(mfcol=c(2,2),mar=c(4, 4, 1, 1),oma = c(0.2, 0.2, 0.2, 0.2))
plot(subsethpcdata$datetime, subsethpcdata$Global_active_power, type="l", xlab="", ylab="Global Active Power",cex.lab=0.8,cex.axis=0.8)
with(subsethpcdata,{
  plot(datetime,Sub_metering_1,type = "l",xlab = "",ylab = "Energy sub metering",col="black",cex.lab=0.8,cex.axis=0.8)
  lines(datetime,Sub_metering_2,col='Red')
  lines(datetime,Sub_metering_3,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),cex=0.6,bty = "n")
})
plot(subsethpcdata$datetime,subsethpcdata$Voltage,type="l",xlab="datetime",ylab="Voltage",cex.lab=0.8,cex.axis=0.8)
plot(subsethpcdata$datetime,subsethpcdata$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power",cex.lab=0.8,cex.axis=0.8)
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
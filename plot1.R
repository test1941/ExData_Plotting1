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
hist(subsethpcdata$Global_active_power, main = "Global Active Power",col="red",xlab = "Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
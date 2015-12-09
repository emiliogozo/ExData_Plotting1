#the input file
inFile <- "../household_power_consumption.txt"

#read the csv
csv <- read.csv(inFile,sep=";",na.strings="?")

#add a datetime column from date and time columns
csv$DateTime <- strptime(paste(csv$Date,csv$Time),format="%d/%m/%Y %H:%M:%S")

#filter the data
dt1 <- strptime("01/02/2007", format="%d/%m/%Y")
dt2 <- strptime("02/02/2007 23:59:00", format="%d/%m/%Y %H:%M:%S")
csv <- csv[csv$DateTime >= dt1 & csv$DateTime <= dt2,]

#plot
with(csv, {
	plot(DateTime,Sub_metering_1,type="l",col="black",
		xlab=NA, ylab="Energy sub metering")
	lines(DateTime,Sub_metering_2, col="red")
	lines(DateTime,Sub_metering_3, col="blue")
	legend("topright", lty=1, col=c("black", "red", "blue"), legend=names(csv)[7:9])
	})
	
#save as png
dev.copy(png,"plot3.png",width=480,height=480)
#close grDevice
dev.off()

q("no")

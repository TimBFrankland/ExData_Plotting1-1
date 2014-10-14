#Read the first 100 rows to get the data types of each column
hpc <- read.table("C:\\Users\\Tim\\Downloads\\household_power_consumption.txt", 
                  sep=";", colClasses=c("character","character",rep("numeric",7)),header=TRUE
                  ,fill=TRUE, na.strings=c("","?","NA"))

#Change date column to a date
hpc$Date<-as.Date(hpc$Date,"%d/%m/%Y")

#Subset the dataset
hpcsub<-subset(hpc,hpc$Date=="2007-02-01"|hpc$Date=="2007-02-02")

hpcsub$datetime<-as.POSIXct(paste(hpcsub$Date, hpcsub$Time), format="%Y-%m-%d %H:%M:%S")

#Set document so that it has space for 4 charts by mfrow=c(2,2), then set margins
#make dimensions 480x480
#Use "with" statement to get multiple charts in one sheet
#add label to y-axis
#Add two other data series sub_metering_2 & 3 by lines statement
#Add key with legend statment with black, red, and blue matched to 
#sub_metering_1,2,&3
png(filename = "Plot4.png",width = 480, height = 480)
par(mfrow=c(2,2),mar=c(5,4,2,1))
with(hpcsub, {plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
plot(datetime,Voltage,type="l",xlab="datetime",ylab="Voltage")
plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(datetime,Sub_metering_2, col="red")
lines(datetime,Sub_metering_3, col="blue")
legend("topright", pch =c(NA,NA,NA), lty=c(1,1,1), col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
plot(datetime,Global_reactive_power,type="l", xlab="datetime",ylab="Global_reactive_power")})  
dev.off()


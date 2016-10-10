#Download and unzip the data
plot1<-function(){
rm(list=ls())
if (!file.exists("./Week1Project")){dir.create("./Week1Project")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./Week1Project/household_power_consumption.zip",method="curl")
unzip("./Week1Project/household_power_consumption.zip", exdir="./Week1Project/powerconsumption")

#read the data
power<-read.table(paste(getwd(),"/Week1Project/powerconsumption/household_power_consumption.txt",sep=""),
sep=";",header=TRUE,na.string="?")


#combine the date and time, and convert it into Date/Time classes in R: POSIXlt
power$DateTime<-strptime(paste(power$Date,power$Time),format="%d/%m/%Y %H:%M:%S")

#Select only the data from 02/01/2007 and 02/02/2007
powersub<-subset(power,format(power$DateTime,"%Y/%m/%d")=="2007/02/01"|
                         format(power$DateTime,"%Y/%m/%d")=="2007/02/02")

#set the plot size width = 480 pixel, height = 480 pixel
#pin use inch as unit, and in r 1 inch = 72 pixel.
#Also set the margin size and the plot background.
par(pin=c(480/72,480/72),mar=c(4,4,3,3), bg="white")

#make the plot
hist(powersub$Global_active_power,breaks=13,main="Global Active Power",
     col="red", border="black",xlab="Global Active Power (kilowatts)", 
     ylab="Frequency",xaxp=c(0,6,3),yaxp=c(0,1200,6))
   
#save it to png file.
dev.copy(png, "plot1.png")
dev.off()
}
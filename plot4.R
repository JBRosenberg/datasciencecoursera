plot4<-function()
{
  ##Read data
  doc<-read.csv("household_power_consumption.csv",sep=";")
  
  ##Separate data for relevant dates
  doc01<-subset(doc,Date=="1/2/2007")
  doc02<-subset(doc,Date=="2/2/2007")
  relData<-rbind(doc01,doc02)
  
  #Convert factor to Char to numeric
  relData$Sub_metering_1<-as.numeric(as.character(relData$Sub_metering_1))
  relData$Sub_metering_2<-as.numeric(as.character(relData$Sub_metering_2))
  relData$Sub_metering_3<-as.numeric(as.character(relData$Sub_metering_3))
  
  relData$Voltage<-as.numeric(as.character(relData$Voltage))
  relData$Global_active_power<-as.numeric(as.character(relData$Global_active_power))
  relData$Global_reactive_power<-as.numeric(as.character(relData$Global_reactive_power))
  
  #Convert time (using lubridate pkg)
  conTime<-paste(relData$Date,relData$Time)
  formattedTime<-parse_date_time(conTime,"dmy hms")
  
  par(mfrow=c(2,2))
  
  #plot Graph#1
  plot(formattedTime,relData$Global_active_power,ylab="Global Active Power",
       xlab="",type='l')
  
  #Plot Graph#2
  plot(formattedTime,relData$Voltage,ylab="Voltage", xlab="datetime", type='l')
  
  #Plot Graph#3
  plot(formattedTime,relData$Sub_metering_1,ylab="Energy sub metering",
       xlab="",type='l')
  lines(formattedTime,relData$Sub_metering_2, col="red")
  lines(formattedTime,relData$Sub_metering_3, col="blue")
  legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         lty=c(1,1,1), col=c("black","red","blue"), cex=1, bty="n")
  
  #Plot Graph#4
  plot(formattedTime,relData$Global_reactive_power, xlab="datetime",
  ylab="Global_reactive_power", ylim=c(0,0.5),cex=1, type='h', lwd=.05)
}  
  
  
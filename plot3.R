plot3<-function()
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
  
  #Convert time (using lubridate pkg)
  conTime<-paste(relData$Date,relData$Time)
  formattedTime<-parse_date_time(conTime,"dmy hms")
  
  #Plot line graph
  plot(formattedTime,relData$Sub_metering_1,ylab="Energy sub metering",
       xlab="",type='l')
  lines(formattedTime,relData$Sub_metering_2, col="red")
  lines(formattedTime,relData$Sub_metering_3, col="blue")
  legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         lty=c(1,1,1), col=c("black","red","blue"))
  
  
}
plot2<-function()
{
  ##Read data
  doc<-read.csv("household_power_consumption.csv",sep=";")
  
  ##Separate data for relevant dates
  doc01<-subset(doc,Date=="1/2/2007")
  doc02<-subset(doc,Date=="2/2/2007")
  relData<-rbind(doc01,doc02)
  
  #Convert factor to Char to numeric
  relData$Global_active_power<-as.character(relData$Global_active_power)
  relData$Global_active_power<-as.numeric(relData$Global_active_power)
  
  #Convert time (using lubridate pkg)
  conTime<-paste(relData$Date,relData$Time)
  formattedTime<-parse_date_time(conTime,"dmy hms")
  
  #Plot line graph
  plot(formattedTime,relData$Global_active_power,ylab="Global Active Power (kilowatts)",
       xlab="",type='l')
  
  
}
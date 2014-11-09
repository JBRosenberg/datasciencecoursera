plot1<-function(){
  
  ##Read data
  doc<-read.csv("household_power_consumption.csv",sep=";")
  
  ##Separate data for relevant dates
  doc01<-subset(doc,Date=="1/2/2007")
  doc02<-subset(doc,Date=="2/2/2007")
  relData<-rbind(doc01,doc02)
  
  #Convert factor to Char to numeric
  relData$Global_active_power<-as.character(relData$Global_active_power)
  relData$Global_active_power<-as.numeric(relData$Global_active_power)
  
  ##create Histogram
  hist(relData$Global_active_power,col="red", xlab="Global Active Power (kilowatts)",
       main="Global Active Power")
  
}
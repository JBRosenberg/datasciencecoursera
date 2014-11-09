best<-function(state,outName)
{
  #Read data
  outcome<-read.csv("~/CourseWork/outcome-of-care-measures.csv",header=FALSE)
  
  
  ##Handle incorrect state error
  stateVec<-unique(outcome[,7])
  if(!is.element(state,stateVec))
  {
    stop("invalid state")
  }
  
  
  ##Handle incorrect outcome argument error 
  causeVec<-c("heart failure", "heart attack", "pneumonia")
  if(!is.element(outName, causeVec))
  {
    stop("invalid outcome")
  }
  
  #Convert mortality rates to type numeric
  outcome[,11]<-as.numeric(outcome[,11])
  outcome[,17]<-as.numeric(outcome[,17])
  outcome[,23]<-as.numeric(outcome[,23])
  
  #Subset data for entered State
  stateData<-subset(outcome,V7==state,)
  
  if(outName=="heart attack")
  {
    #Convert mortality rates to type numeric
    stateData[,11]<-as.numeric(stateData[,11])
    
    ##Index minimum value and return hospital name at index
    index<-min(stateData[,11],na.rm=TRUE)
    resMat<-stateData[stateData[,11]==index,]
    resMat<-resMat[order(resMat$V2),]
    res<-resMat[1,2]
  }
  
  else if(outName=="heart failure")
  {
    #Convert mortality rates to type numeric
    stateData[,17]<-as.numeric(stateData[,17])
    index<-min(stateData[,17],na.rm=TRUE)
    resMat<-stateData[stateData[,17]==index,]
    resMat<-resMat[order(resMat$V2),]
    res<-resMat[1,2]
  }
  
  else if(outName=="pneumonia")
  {
    #Convert mortality rates to type numeric
    stateData[,23]<-as.numeric(stateData[,23])
    index<-min(stateData[,23],na.rm=TRUE)
    resMat<-stateData[stateData[,23]==index,]
    resMat<-resMat[order(resMat$V2),]
    res<-resMat[1,2]
  }
  
  return(as.character(res))
  
  
}
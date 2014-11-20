run_analysis<-function()
{
  #Extract test dataset/labels
  ls_test<-list.files("~/CourseWork/UCI Har Dataset/test",full.names=TRUE)
  subject_test<-read.table(ls_test[2], colClasses="numeric")
  
  #Retrieve test dataset
  x_test<-read.table(ls_test[3], colClasses="numeric")
  
  #Retrieve test labels dataset
  y_test<-read.table(ls_test[4], colClasses="numeric")
  
  #Extract training dataset/labels
  ls_train<-list.files("~/CourseWork/UCI Har Dataset/train",full.names=TRUE)
  subject_train<-read.table(ls_train[2])
  
  #Retrieve train dataset
  x_train<-read.table(ls_train[3])
  
  #Retrieve train labels dataset
  y_train<-read.table(ls_train[4])
  
  #Combine all of test data into one set
  test_total<-cbind(subject_test,x_test)
  test_total<-cbind(test_total,y_test)
  
  #Combine all of train data in one set
  train_total<-cbind(subject_train, x_train)
  train_total<-cbind(train_total,y_train)
  
  #Merge train and test sets into one
  total_data<-rbind(test_total,train_total)
  
  #Name Subject and Activity column
  colnames(total_data)[1]<-"Subject No."
  colnames(total_data)[563]<-"Activity"
  
  #Add descriptive activity names
  total_data$ActivityName<-factor(total_data$Activity,labels=c("Walking","Walking_Upstairs",
                            "Walking_Downstairs","Sitting","Standing","Laying"))
 
  
  #Create sequence that corresponds to mean and stdev columns
  meanSDevSeq<-c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,
       266:271,345:350,424:429,503:504,516:517,529:530,542:543)
  #Increment Sequence to account for subject column
  colSeq<-c(1,meanSDevSeq+1,563,564)
  
  #Extract mean and stdev
  total_data<-total_data[,colSeq]
  
  #Create vector of corresponding column names
  dataNames<-c("Subject","tBodyAccelMeanX","tBodyAccelMeanY",
            "tBodyAccelMeanZ","tBodyAccelStdX","tBodyAccelStdY",
            "tBodyAccelStdZ","tGravityAccelMeanX","tGravityAccelMeanY",
            "tGravityAccelMeanZ","tGravityAccelStdX","tGravityAccelStdY",
            "tGravityAccelStdZ","tBodyAccelJerkMeanX","tBodyAccelJerkMeanY",
            "tBodyAccelJerkMeanZ","tBodyAccelJerkStdX","tBodyAccelJerkStdY",
            "tBodyAccelJerkStdZ","tBodyGyroMeanX","tBodyGyroMeanXY",
            "tBodyGyroMeanZ","tBodyGyroStdX","tBodyGyroStdY",
            "tBodyGyroStdZ","tBodyGyroJerkMeanX",
            "tBodyGyroJerkMeanY","tBodyGyroJerkMeanZ","tBodyGyroJerkStdX",
            "tBodyGyroJerkStdY","tBodyGyroJerkStdZ","tBodyAccelMagMean",
            "tBodyAccelMagStd","tGravityAccelMagMean","tBodyAccelMagStd",
            "tBodyAccelJerkMean","tBodyAccelJerkStd","tBodyGyroMagMean",
            "tBodyGyroMagStd","tBodyGyroJerkMagMean","tBodyGyroJerkMagStd",
            "fBodyAccelMeanX","fBodyAccelMeanY","fBodyAccelMeanZ",
            "fBodyAccelStdX","fBodyAccelStdY","fBodyAccelStdZ",
            "fBodyAccelJerkMeanX","fBodyAccelJerkMeanY","fBodyAccelJerkMeanZ",
            "fBodyAccelJerkStdX","fBodyAccelJerkStdY","fBodyAccelJerkStdZ",
            "fBodyGyroMeanX","fBodyGyroMeanY","fBodyGyroMeanZ",
            "fBodyGyroStdX","fBodyGyroStdY","fBodyGyroStdZ",
            "fBodyAccelMagMean","fBodyAccelMagStd","fBodyAccelJerkMagMean",
            "fBodyAccelJerkMagStd","fBodyGyroMagMean","fBodyGyroMagStd",
            "fBodyGyroJerkMagMean","fBodyGyroJerkMagStd",
            "ActivityCode","ActivityName")
  
  #Assign column names to columns
  colnames(total_data)<-dataNames
  total_data<-total_data[order(total_data$Subject,total_data$ActivityName),]

  #Creates Tidy Data Set 2
  set2<-data.frame()
  #Loop for all subjects and subset their data
  for(i in 1:30)
  {
    subData<-total_data[which(total_data$Subject==i),]
    
    #Loop for all of said subject's activity and subset that data
    #Average values for all variables and add to resulting dataframe
    for(j in 1:6)
    {
      dubSub<-subData[which(subData$ActivityCode==j),]
      meanData<-colMeans(dubSub[,2:67])
      iterationInput<-c(i,j,meanData)
      set2<-rbind(set2,iterationInput)
    }
  } 
  
  #Rename Columns
  colnames(set2)<-c("Subject","ActivityName","tBodyAccelMeanX","tBodyAccelMeanY",
                              "tBodyAccelMeanZ","tBodyAccelStdX","tBodyAccelStdY",
                              "tBodyAccelStdZ","tGravityAccelMeanX","tGravityAccelMeanY",
                              "tGravityAccelMeanZ","tGravityAccelStdX","tGravityAccelStdY",
                              "tGravityAccelStdZ","tBodyAccelJerkMeanX","tBodyAccelJerkMeanY",
                              "tBodyAccelJerkMeanZ","tBodyAccelJerkStdX","tBodyAccelJerkStdY",
                              "tBodyAccelJerkStdZ","tBodyGyroMeanX","tBodyGyroMeanY",
                              "tBodyGyroMeanZ","tBodyGyroStdX","tBodyGyroStdY",
                              "tBodyGyroStdZ","tBodyGyroJerkMeanX",
                              "tBodyGyroJerkMeanY","tBodyGyroJerkMeanZ","tBodyGyroJerkStdX",
                              "tBodyGyroJerkStdY","tBodyGyroJerkStdZ","tBodyAccelMagMean",
                              "tBodyAccelMagStd","tGravityAccelMagMean","tBodyAccelMagStd",
                              "tBodyAccelJerkMean","tBodyAccelJerkStd","tBodyGyroMagMean",
                              "tBodyGyroMagStd","tBodyGyroJerkMagMean","tBodyGyroJerkMagStd",
                              "fBodyAccelMeanX","fBodyAccelMeanY","fBodyAccelMeanZ",
                              "fBodyAccelStdX","fBodyAccelStdY","fBodyAccelStdZ",
                              "fBodyAccelJerkMeanX","fBodyAccelJerkMeanY","fBodyAccelJerkMeanZ",
                              "fBodyAccelJerkStdX","fBodyAccelJerkStdY","fBodyAccelJerkStdZ",
                              "fBodyGyroMeanX","fBodyGyroMeanY","fBodyGyroMeanZ",
                              "fBodyGyroStdX","fBodyGyroStdY","fBodyGyroStdZ",
                              "fBodyAccelMagMean","fBodyAccelMagStd","fBodyAccelJerkMagMean",
                              "fBodyAccelJerkMagStd","fBodyGyroMagMean","fBodyGyroMagStd",
                              "fBodyGyroJerkMagMean","fBodyGyroJerkMagStd")
 
 #Once again, add activity lables
 set2$Activity<-factor(set2$ActivityName,labels=c("Walking","Walking_Upstairs",
                                                              "Walking_Downstairs","Sitting","Standing","Laying"))
 #Replace codes with labels and subset accordingly
 set2$ActivityName<-set2$Activity
 set2<-set2[,1:68]

 return(set2)
  
}
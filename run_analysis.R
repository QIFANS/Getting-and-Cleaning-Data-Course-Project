stest<-read.table(file = "UCI HAR Dataset/test/subject_test.txt")
ltest<-read.table(file = "UCI HAR Dataset/test/c")
test<-read.table(file = "UCI HAR Dataset/test/X_test.txt")

strain<-read.table(file = "UCI HAR Dataset/train/subject_train.txt")
ltrain<-read.table(file = "UCI HAR Dataset/train/y_train.txt")
train<-read.table(file = "UCI HAR Dataset/train/X_train.txt")


#Merge test data and train data
data<-rbind(test,train)
features<-read.table(file = "UCI HAR Dataset/features.txt")
colnames(data)<-c(as.character(features[,2]))

#Exrtract the features
selected<-grep("mean|std",features[,2])
data1<-data[,selected]
features1<-as.character(features[,2][selected])

#name the activities in the data set
subject<-rbind(stest,strain)
label$V1[label$V1==1]<-"WALKING"
label$V1[label$V1==2]<-"WALKING_UPSTAIRS"
label$V1[label$V1==3]<-"WALKING_DOWNSTAIRS"
label$V1[label$V1==4]<-"SITTING"
label$V1[label$V1==5]<-"STANDING"
label$V1[label$V1==6]<-"LAYING"

label<-rbind(ltest,ltrain)
data1<-cbind(subject,label,data1)
colnames(data1)<-c("subject","activity",features1)
data1<-data1[order(data1$subject,data1$activity),]
write.table(data1,file = "wearabledataset.txt",row.names = F)

data2<-aggregate(data1[,c(-1,-2)],by=list(data1$activity,data1$subject),mean)
data2<-cbind(subject=data2[,2],activity=data2[,1],round(data2[,c(-1,-2)],6))
write.table(data2,"wearabledataset_mean_by_group.txt",row.names = F)




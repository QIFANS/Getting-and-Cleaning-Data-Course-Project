stest<-read.table(file = "UCI HAR Dataset/test/subject_test.txt")
ltest<-read.table(file = "UCI HAR Dataset/test/y_test.txt")
test<-read.table(file = "UCI HAR Dataset/test/X_test.txt")

strain<-read.table(file = "UCI HAR Dataset/train/subject_train.txt")
ltrain<-read.table(file = "UCI HAR Dataset/train/y_train.txt")
train<-read.table(file = "UCI HAR Dataset/train/X_train.txt")

# Clean them by giving more descriptive names using gsub function
features<-read.table(file = "UCI HAR Dataset/features.txt",col.names = c("id","name"))
feature_names <- gsub("BodyBody","Body",features$name)
feature_names <- gsub("tBody","TimeforBody",feature_names)
feature_names <- gsub("fBody","FFTforBody",feature_names)
feature_names <- gsub("Acc","Acceleration",feature_names)
feature_names <- gsub("tGravity","TimeforGravity",feature_names)
feature_names <- gsub("-X","inX",feature_names)
feature_names <- gsub("-Y","inY",feature_names)
feature_names <- gsub("-Z","inZ",feature_names)
feature_names <- gsub("-mean","Mean",feature_names)
feature_names <- gsub("-std","Std",feature_names)

#Merge test data and train data
data<-rbind(test,train)
colnames(data)<-feature_names

#Exrtract the features
selected<-grep("Mean\\(\\)|Std\\(\\)",feature_names)
data1<-data[,selected]
features1<-feature_names[selected]

##NCOL用于vector
#name the activities in the data set
subject<-rbind(stest,strain)

# Activity: read training and test & bind them together
label<-rbind(ltest,ltrain)
activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", header=FALSE, sep='', colClasses=c("numeric", "factor"))
#factor(x=一个向量x,levels=sort(unique(x))向量的等级,labels=和levels对应的名字)可以把向量里的编程labels里的
label <- factor(label[[1]], activityLabels[[1]], activityLabels[[2]])

data1<-cbind(subject,label,data1)
colnames(data1)<-c("subject","activity",features1)
data1<-data1[order(data1$subject,data1$activity),]
write.table(data1,file = "wearabledataset.txt",row.names = F)

data2<-aggregate(data1[,c(-1,-2)],by=list(data1$activity,data1$subject),mean)
data2<-cbind(subject=data2[,2],activity=data2[,1],round(data2[,c(-1,-2)],6))
write.table(data2,"wearabledataset_mean_by_group.txt",row.names = F)

##write.table(names(data1),"features.txt")




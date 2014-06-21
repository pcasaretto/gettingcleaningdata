if(!file.exists("UCI HAR Dataset/features.txt")) {
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}

features = read.table("UCI HAR Dataset/features.txt")
activity_labels = read.table("UCI HAR Dataset/activity_labels.txt")

subject_test = read.table("UCI HAR Dataset/test/subject_test.txt")

X_test = read.table("UCI HAR Dataset/test/X_test.txt")
names(X_test) = features$V2

y_test = read.table("UCI HAR Dataset/test/y_test.txt")

test_named_activities = as.vector(activity_labels$V2[match(y_test$V1, as.factor(activity_labels$V1))])

test = X_test

test$Activity = test_named_activities
test$Subject  = subject_test$V1

subject_train = read.table("UCI HAR Dataset/train/subject_train.txt")

X_train = read.table("UCI HAR Dataset/train/X_train.txt")
names(X_train) = features$V2

y_train = read.table("UCI HAR Dataset/train/y_train.txt")

train_named_activities = as.vector(activity_labels$V2[match(y_train$V1, as.factor(activity_labels$V1))])

train = X_train

train$Activity = train_named_activities
train$Subject  = subject_train$V1


complete = rbind(train,test)

library(plyr)

result = ddply(.data = complete, .variables = c("Activity","Subject"), .fun = function(x) { colMeans(subset(x, select = -c(Activity, Subject))) })

write.csv(result, file = "tidy.csv")

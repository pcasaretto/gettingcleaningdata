# unzip the file if it exists
if(!file.exists("UCI HAR Dataset/features.txt")) {
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}

#Read the features and activity labels
features = read.table("UCI HAR Dataset/features.txt")
activity_labels = read.table("UCI HAR Dataset/activity_labels.txt")

# Read test subject information
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt")

# Read test measurements and use the feature labels as column names
X_test = read.table("UCI HAR Dataset/test/X_test.txt")
names(X_test) = features$V2

# Read the activities data for each measurement
y_test = read.table("UCI HAR Dataset/test/y_test.txt")

# Transform the activities indices into labels
test_named_activities = as.vector(activity_labels$V2[match(y_test$V1, as.factor(activity_labels$V1))])

# Copies test data into a new variable
test = X_test

# Auguments the test data with the newly calculated vectors
test$Activity = test_named_activities
test$Subject  = subject_test$V1

# Do it all over again for the train set

subject_train = read.table("UCI HAR Dataset/train/subject_train.txt")

X_train = read.table("UCI HAR Dataset/train/X_train.txt")
names(X_train) = features$V2

y_train = read.table("UCI HAR Dataset/train/y_train.txt")

train_named_activities = as.vector(activity_labels$V2[match(y_train$V1, as.factor(activity_labels$V1))])

train = X_train

train$Activity = train_named_activities
train$Subject  = subject_train$V1

# Merges the two sets

complete = rbind(train,test)

library(plyr)

# Calculate the mean for every column (excluding Activity and Subject) for the
# data.frame factored over Activity and Subject
result = ddply(.data = complete, .variables = c("Activity","Subject"), .fun = function(x) { colMeans(subset(x, select = -c(Activity, Subject))) })

write.csv(result, file = "tidy.csv")

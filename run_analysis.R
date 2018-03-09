library(reshape2)

# preprocess labels and features
activity_labels <- read.csv("data/activity_labels.txt", sep="", header=FALSE)
activity_labels[,2] <- as.character(activity_labels[,2])
features <- read.csv("data/features.txt", sep="", header=FALSE)
wanted_features_rows <- grep(".*mean.*|.*std.*", features[,2])
wanted_features <- features[wanted_features_rows,2]
wanted_features = gsub('-mean', 'Mean', wanted_features)
wanted_features = gsub('-std', 'Std', wanted_features)
wanted_features <- gsub('[-()]', '', wanted_features)

# load & merge the data
train <- read.table("data/train/X_train.txt")[wanted_features_rows]
train_activity <- read.table("data/train/Y_train.txt")
train_subject <- read.table("data/train/subject_train.txt")
train <- cbind(train_subject, train_activity, train)

test <- read.table("data/test/X_test.txt")[wanted_features_rows]
test_activity <- read.table("data/test/Y_test.txt")
test_subject <- read.table("data/test/subject_test.txt")
test <- cbind(test_subject, test_activity, test)

joint_data <- rbind(train, test)
colnames(joint_data) <- c("subject", "activity", wanted_features)

# turn activities & subjects into factors
joint_data$activity <- factor(joint_data$activity, levels = activity_labels[,1], labels = activity_labels[,2])
joint_data$subject <- as.factor(joint_data$subject)

# order data
melt_data <- melt(joint_data, id = c("subject", "activity"))
mean_data <- dcast(melt_data, subject + activity ~ variable, mean)

# save data
write.table(mean_data, "tidy_data.txt", row.names = FALSE, quote = FALSE)

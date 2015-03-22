library(dplyr)
#library(stringr)
library(tidyr)

if(!file.exists("./dataset")){
  #Creates a new folder called "data" if you do not have one already.
  dir.create("./dataset")
}

#downloads the file
fileUrl1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl1,destfile="./dataset/dataset.zip", method="curl")
#unzips the downloaded file in the (new) data directory
unzip("./dataset/dataset.zip", exdir="./dataset")
file.remove("./dataset/dataset.zip")

features <- read.table("./dataset/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

X_train <- read.table("./dataset/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./dataset/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./dataset/UCI HAR Dataset/train/subject_train.txt")
colnames(X_train) <- features$V2
colnames(y_train) <- "Activity"
colnames(subject_train) <- "Subject"
train <- cbind(subject_train, y_train, X_train)

X_test <- read.table("./dataset/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./dataset/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./dataset/UCI HAR Dataset/test/subject_test.txt")
colnames(X_test) <- features$V2
colnames(y_test) <- "Activity"
colnames(subject_test) <- "Subject"
test <- cbind(subject_test, y_test, X_test)

df <- rbind(train, test)

columns <- grepl("mean|std|Subject|Activity", colnames(df)) & !grepl("meanFreq", colnames(df))

newdf <- df[, columns]

activity_names <- read.table("./dataset/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
colnames(activity_names) <- c("Activity", "ActivityDescription")

##newdf <- tbl_df(newdf)
mergedDF <- merge(activity_names,newdf, by_x="Activity", by.y = "Activity", all = TRUE)

dfnames <- names(mergedDF)
dfnames <- str_replace_all(dfnames, "Acc", "-acceleration-")
# Change Gyro to gyroscope
dfnames <- str_replace_all(dfnames, "Gyro", "-gyroscope-")
# Change Mag to magnitude
dfnames <- str_replace_all(dfnames, "Mag", "-magnitude")  
dfnames <- str_replace_all(dfnames, "^t", "time-")
# Change f at the beginning to frequency
dfnames <- str_replace_all(dfnames, "^f", "frequency-")
# Replace tBody with time-body
dfnames <- str_replace_all(dfnames, "tBody", "time-body-")
# Replace BodyBody with body
dfnames <- str_replace_all(dfnames, "BodyBody", "body")
# Clean up by removing any "--" and change to "-"
dfnames <- str_replace_all(dfnames, "--", "-")
dfnames <- tolower(dfnames)
names(mergedDF) <- dfnames

ttidy <- mergedDF %>% gather(sensor, Value, 4:69, -activitydescription)
#ttidy1 <- ttidy %>% group_by(subject, activitydescription, sensor)%>% summarize(mean = mean(Value))
ttidy1 <- ttidy %>% group_by(sensor, activitydescription, subject )%>% summarize(mean = mean(Value))


#write.table(ttidy1, "tidy_data.txt", row.names = FALSE)
write.table(ttidy1, "tidy_data.txt")


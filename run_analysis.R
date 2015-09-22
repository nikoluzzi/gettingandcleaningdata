library(dplyr)
library(plyr)
library(tidyr)

##Read the files
xTestPath <- "./UCI HAR Dataset/test/X_test.txt"
yTestPath <- "./UCI HAR Dataset/test/y_test.txt"
subjectTestPath <- "./UCI HAR Dataset/test/subject_test.txt"

xTrainPath <- "./UCI HAR Dataset/train/X_train.txt"
yTrainPath <- "./UCI HAR Dataset/train/y_train.txt"
subjectTrainPath <- "./UCI HAR Dataset/train/subject_train.txt"

featuresPath <- "./UCI HAR Dataset/features.txt"
activityPaths <- "./UCI HAR Dataset/activity_labels.txt"

xTestData <- read.table(xTestPath)
yTestData <- read.table(yTestPath)
subjectTestData <- read.table(subjectTestPath)

xTrainData <- read.table(xTrainPath)
yTrainData <- read.table(yTrainPath)
subjectTrainData <- read.table(subjectTrainPath)

allTest <- bind_cols(xTestData,yTestData,subjectTestData)
allTrain <- bind_cols(xTrainData,yTrainData,subjectTrainData)

##Create the tbl that binds Test and Train data.
allData <- bind_rows(allTest,allTrain)

##Fetching the column index
features <- read.table(featuresPath)

##Filtering only what is mean or std. Taking meanFreq out of the set since it's the mean of Frequence measurement.
filteredFeatures <- filter(features, grepl('mean[^Freq]|std',V2))


##Create a vector to subset Alldata.
## First add the variables 
subsetVector <- filteredFeatures[,1]
subsetNames <- as.character(filteredFeatures[,2])

## Then append the Activity and Subject row number to the subset variable
subsetVector <- c(subsetVector,562,563)

##Subset the whole data, using the subsetVector, to keep only the columns wanted, including activity and subjects
data <- allData[,subsetVector]

##Fetch activity labels name
activityLabels <- read.table(activityPaths, stringsAsFactors = FALSE)
##Clean the names.
activityLabels <- mapvalues(activityLabels$V2, from=activityLabels$V2, to = tolower(activityLabels$V2))

## Apply the activity names
data$activity <- mapvalues(data$activity, from = c(1, 2, 3,4,5,6), to = activityLabels)


##subsetNames <- tolower(subsetNames)
subsetNames <- gsub("-","",subsetNames)
subsetNames <- gsub("\\(\\)","",subsetNames)
subsetNames <- c(subsetNames,"activity","subject")

names(data) <- subsetNames
data2 <- data %>% group_by(activity, subject) %>% summarise_each(c("mean"))
write.table(data2, file="summarizeddata.txt", row.name=FALSE )




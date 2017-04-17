#Read in all of the data
stest <- read.table("./subject_test.txt")
xtest <- read.table("./X_test.txt")
ytest <- read.table("./Y_test.txt")
strain <- read.table("./subject_train.txt")
xtrain <- read.table("./X_train.txt")
ytrain <- read.table("./Y_train.txt")
features <- read.table("./features.txt")
activity <- read.table("./activity_labels.txt")

#combine test and training data
testdata <- cbind(stest, ytest, xtest)
traindata <- cbind(strain, ytrain, xtrain)
testandtrain <- rbind(testdata,traindata)

#added column names to help sort
names(testandtrain) <- c("subject", "actno", as.character(features[,2]))

#remeoved all columns that were not means or standard deviations
testandtrain <- testandtrain[,grepl("subject", names(testandtrain)) | grepl("actno", names(testandtrain)) | grepl("mean\\(\\)", names(testandtrain))|grepl("std\\(\\)", names(testandtrain))]

#clean up labels
names(testandtrain) <- tolower(names(testandtrain))
names(testandtrain) <-gsub("-","",names(testandtrain))
names(testandtrain) <-gsub("\\(","",names(testandtrain))
names(testandtrain) <-gsub("\\)","",names(testandtrain))

#add descriptive acitivity names
colnames(activity) <- c("actno", "activity")
testandtrain <- merge(testandtrain,activity, by="actno")
testandtrain <- select(testandtrain, -(actno))

library(sqldf) #load sqldf package
output <- sqldf('select subject,activity, avg(tbodyaccmeanx), avg(tbodyaccmeany), avg(tbodyaccmeanz), avg(tbodyaccstdx), avg(tbodyaccstdy) , avg(tbodyaccstdz) , avg(tgravityaccmeanx), avg(tgravityaccmeany), avg(tgravityaccmeanz)      , avg(tgravityaccstdx) , avg(tgravityaccstdy) , avg(tgravityaccstdz) , avg(tbodyaccjerkmeanx)      , avg(tbodyaccjerkmeany)     , avg(tbodyaccjerkmeanz)      , avg(tbodyaccjerkstdx), avg(tbodyaccjerkstdy), avg(tbodyaccjerkstdz), avg(tbodygyromeanx) , avg(tbodygyromeany)  , avg(tbodygyromeanz)  , avg(tbodygyrostdx), avg(tbodygyrostdy), avg(tbodygyrostdz)  , avg(tbodygyrojerkmeanx)     , avg(tbodygyrojerkmeany)     , avg(tbodygyrojerkmeanz)     , avg(tbodygyrojerkstdx)      , avg(tbodygyrojerkstdy)     , avg(tbodygyrojerkstdz)      , avg(tbodyaccmagmean) , avg(tbodyaccmagstd)  , avg(tgravityaccmagmean)     , avg(tgravityaccmagstd)     , avg(tbodyaccjerkmagmean), avg(tbodyaccjerkmagstd), avg(tbodygyromagmean), avg(tbodygyromagstd), avg(tbodygyrojerkmagmean), avg(tbodygyrojerkmagstd), avg(fbodyaccmeanx), avg(fbodyaccmeany), avg(fbodyaccmeanz), avg(fbodyaccstdx), avg(fbodyaccstdy), avg(fbodyaccstdz), avg(fbodyaccjerkmeanx), avg(fbodyaccjerkmeany), avg(fbodyaccjerkmeanz), avg(fbodyaccjerkstdx), avg(fbodyaccjerkstdy), avg(fbodyaccjerkstdz), avg(fbodygyromeanx), avg(fbodygyromeany), avg(fbodygyromeanz), avg(fbodygyrostdx), avg(fbodygyrostdy), avg(fbodygyrostdz), avg(fbodyaccmagmean), avg(fbodyaccmagstd), avg(fbodybodyaccjerkmagmean), avg(fbodybodyaccjerkmagstd), avg(fbodybodygyromagmean), avg(fbodybodygyromagstd), avg(fbodybodygyrojerkmagmean), avg(fbodybodygyrojerkmagstd) from testandtrain group by testandtrain.subject, testandtrain.activity')
names(output) <-gsub("\\(","",names(output))
names(output) <-gsub("\\)","",names(output))

#write out to file
write.table(output, file="MyTidy.txt", row.names = FALSE, col.names = TRUE, sep = ",")

#output <- head(testandtrain)
#print(output)

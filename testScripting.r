
#packages
library(tidyverse)
library(readODS)

#Loading in working data from working directory. Will require an edit depending
#on the placement of the working data files in the experimenter's filesystem.
#For us, the working git repo is located in ~/gitrepos/student-data-analysis and
#its associated subdirectories.

onex_att <- read_ods(path="~/gitrepos/student-data-analysis/workingData/1x-att.ods",sheet=1)
twoz_att <- read_ods(path="~/gitrepos/student-data-analysis/workingData/2z-att.ods",sheet=1)
#onex_gra <- read_ods(path="~/gitrepos/student-data-analysis/workingData/1x-gra.ods",sheet=1)
#twoz_gra <- read_ods(path="~/gitrepos/student-data-analysis/workingData/2z-gra.ods",sheet=1)


#Compute new statistics: Attendance (TO BE GENERALIZED WITH ID VARIABLES)
#
#For now, these two lines take the average of the attendance calculated
#from line 6 and out to the ends of their respective data frames, appending
#a new column on the end of the data frame with the new statistic for average
#attendance by student.
onex_att$meanAttendanceDaily <- rowMeans(onex_att[,c(6:length(onex_att))], na.rm=TRUE)
twoz_att$meanAttendanceDaily <- rowMeans(twoz_att[,c(6:length(twoz_att))], na.rm=TRUE)

#Daily Averages (this is just for me, this is probably junk code)
colMeans(onex_att[c(6:length(onex_att))], na.rm=T)
colMeans(twoz_att[c(6:length(twoz_att))], na.rm=T)


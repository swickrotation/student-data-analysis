
#packages
library(tidyverse)
library(readODS)
library(ggplot2)

#Loading in working data from working directory. Will require an edit depending
#on the placement of the working data files in the experimenter's filesystem.
#For us, the working git repo is located in ~/gitrepos/student-data-analysis and
#its associated subdirectories, being workingData, from which we load individual
#files.

classOne_attendance <- read_ods(path="~/gitrepos/student-data-analysis/workingData/1x-att.ods",sheet=1)
classTwo_attendance <- read_ods(path="~/gitrepos/student-data-analysis/workingData/2z-att.ods",sheet=1)
classOne_grades <- read_ods(path="~/gitrepos/student-data-analysis/workingData/1x-gra.ods",sheet=1)
classTwo_grades <- read_ods(path="~/gitrepos/student-data-analysis/workingData/2z-gra.ods",sheet=1)


#Compute new statistics: Attendance (TO BE GENERALIZED WITH ID VARIABLES)
#
#
#Daily Averages (this is just for me, this is probably junk code)
dailyMeanAttendance_classOne<-data.frame(colMeans(classOne_attendance[c(6:length(classOne_attendance))], na.rm=T))
dailyMeanAttendance_classTwo<-data.frame(colMeans(classTwo_attendance[c(6:length(classTwo_attendance))], na.rm=T))

#For now, these next two lines take the average of the attendance calculated
#from line 6 and out to the ends of their respective data frames and creates a
#rmnew data frame housing the total attendance data by-student.
meanAttendanceByStudent_classOne <- data.frame(rowMeans(classOne_attendance[,c(6:length(classOne_attendance))], na.rm=TRUE))
meanAttendanceByStudent_classTwo <- data.frame(rowMeans(classTwo_attendance[,c(6:length(classTwo_attendance))], na.rm=TRUE))


#Calculate the correlation between attendance and final grades in each class.
#The final grade is the 95th column in both dataframes, whereas the mean
#attendance has but one column. As of the sampling data on 7 January 2023,
#we can see that class one has a moderate positive correlation whereas class
#two has a positive but rather weak correlation between tutorial attendance and
#final marks (~0.621 and ~0.158, respectively).
#
cor(classOne_grades[95],meanAttendanceByStudent_classOne[1])
cor(classTwo_grades[95],meanAttendanceByStudent_classTwo[1])

#Plot some figures just for fun

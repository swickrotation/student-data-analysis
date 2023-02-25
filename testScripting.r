
# Import packages
library(tidyverse)
library(readODS)

#not sure if I'm actually using these ones but they are generally handy to have
#and thus are worth importing anyway
library(ggplot2)
library(dplyr)

#Loading in working data from working directory. Will require an edit depending
#on the placement of the working data files in the experimenter's filesystem.
#For us, the working git repo is located in ~/gitrepos/student-data-analysis and
#its associated subdirectories, being workingData, from which we load individual
#files.


#In the current framework, the attendance data is given with a mark of
#presence or absence "P (1/1)" or "A (0/1)". I chaged those over in google
#sheets to simple 1/0 to calculate the average attendance rate. As of 
#23-02-2023, this can be handled in pre-processing using preProcessing.r. 

classOne_attendance <- readRDS("~/gitrepos/student-data-analysis/demodata/classOne_attendance.Rda")
classTwo_attendance <- readRDS("~/gitrepos/student-data-analysis/demodata/classTwo_attendance.Rda")

#Similar to the above, the percentage scores given by the data aggregator have
#spaces in between the % sign and the number, which makes R read the cell
#entries as strings by default. This too was simply easier for me to change
#before processing. I'm sure there's either some built-in regular expression
#support in R but I could not be arsed to find it.

classOne_grades <- readRDS("~/gitrepos/student-data-analysis/demodata/classOne_grades.Rda")
classTwo_grades <- readRDS("~/gitrepos/student-data-analysis/demodata/classTwo_grades.Rda")


#Compute new statistics: Attendance (TO BE GENERALIZED WITH ID VARIABLES)
#
#
#Daily Averages (this is just for me, this is probably junk code)

##dailyMeanAttendance_classOne<-data.frame(colMeans(classOne_attendance %>% select('26 Sep 2022 12.00AM All students':'16 Dec 2022 12.00AM All students')))
##colnames(dailyMeanAttendance_classOne)[1]  <- "Daily Mean Attendance"

##dailyMeanAttendance_classTwo<-data.frame(colMeans(classTwo_attendance %>% select('26 Sep 2022 12.00AM All students':'15 Dec 2022 12.00AM All students')))
##colnames(dailyMeanAttendance_classTwo)[1]  <- "Daily Mean Attendance"


#For now, these next two blocks take the average of the attendance calculated
#from the first day of classes to the last, calculating over the namespace of
#the columns effective 22-02-2023 from updates by WSG. We also consolidate the 
#data to a single frame for ease of use using the column bind function available
#in the base package of R.

#classOne
meanAttendanceByStudent_classOne <- data.frame(rowMeans(classOne_attendance %>% select('26 Sep 2022 12.00AM All students':'16 Dec 2022 12.00AM All students')))
colnames(meanAttendanceByStudent_classOne)[1] <- "Mean Attendance by Student"
classOneData <- cbind(classOne_grades, meanAttendanceByStudent_classOne)

#classTwo
meanAttendanceByStudent_classTwo <- data.frame(rowMeans(classTwo_attendance %>% select('26 Sep 2022 12.00AM All students':'15 Dec 2022 12.00AM All students')))
colnames(meanAttendanceByStudent_classTwo)[1] <- "Mean Attendance by Student"
classTwoData <- cbind(classTwo_grades, meanAttendanceByStudent_classTwo)


#Calculate the correlation between attendance and final grades in each class.
#As of 16 February, 2023 the standing code takes inputs as the titles of the
#columns in dataframes. The previous version required knowing which column in
#the dataframe held the data you were looking for (i.e. counting out to the
#95th column to find the total grade in percentage.) Attendance has but one 
#column. As of the sampling data on 7 January 2023,we can see that class one has
#a moderate positive correlation whereas class two has a positive but rather 
#weak correlation between tutorial attendance and final marks (~0.621 and 
#~0.158, respectively).
#
cor(classOneData[["Course total (Percentage)"]],classOneData[["Mean Attendance by Student"]])
cor(classTwoData[["Course total (Percentage)"]],classTwoData[["Mean Attendance by Student"]])

#PLOTS
#
#These first two figures plot the mean daily attendance each student by their
#final performance in the course, and includes a linear regression line of best
#fit.

#Figure 1
plot(classOneData[["Mean Attendance by Student"]], 
     classOneData[["Course total (Percentage)"]],
     xlab = "x = Mean Attendance", 
     ylab= "y =Course Average", 
     main="Class One Average by Attendance with Linear Regression"
)
abline(lm(classOneData[["Course total (Percentage)"]]~classOneData[["Mean Attendance by Student"]]),
       col=2, 
       lwd=1
)
coefClassOne <- signif(coef(lm(classOneData[["Course total (Percentage)"]]~classOneData[["Mean Attendance by Student"]])),
                       digits=3
                )
text(0.36, 0.3,  paste("y = ", coefClassOne[1], "+", coefClassOne[2], "x"))

#Figure 2
plot(classTwoData[["Mean Attendance by Student"]],
     classTwoData[["Course total (Percentage)"]],
     xlab = "x = Mean Attendance",
     ylab= "y =Course Average",
     main="Class Two Average by Attendance with Linear Regression"
)


abline(lm(classTwoData[["Course total (Percentage)"]]~classTwoData[["Mean Attendance by Student"]]),
       col=2,
       lwd=1
)

coefClassTwo <- signif(coef(lm(classTwoData[["Course total (Percentage)"]]~classTwoData[["Mean Attendance by Student"]])),
                       digits=3
                )

text(0.41, 0.50,  paste("y = ", coefClassTwo[1], "+", coefClassTwo[2], "x"))

#These box-and-whisker figures show the average grades based on attendance on
#particular days in class. We might expect that students who attended an exam
#revision session would perform better on their finals than those who
#missed the same.
boxplot(
  classOneData[["Course total (Percentage)"]]~classOne_attendance[["11 Nov 2022 12.00AM All students"]],
  xlab="Presence",
  ylab="Final Grade",
  main="Comparative Final Average over Particular Attendance"
)

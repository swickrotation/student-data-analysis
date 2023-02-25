
#import libraries
library(readODS)
library(dplyr)
library(readr)

#We set the working directory to that from where we are loading the initial
#dataframes. This will be different on your machine.

setwd("~/gitrepos/student-data-analysis/demodata/")


#import attendance records
classOne_attendance <- read_ods(path="~/gitrepos/student-data-analysis/demodata/1x-att_Original.ods",sheet=1)
classTwo_attendance <- read_ods(path="~/gitrepos/student-data-analysis/demodata/2z-att_Original.ods",sheet=1)

#import grade data
classOne_grades <- read_ods(path="~/gitrepos/student-data-analysis/demodata/1x-gra_Original.ods",sheet=1)
classTwo_grades <- read_ods(path="~/gitrepos/student-data-analysis/demodata/2z-gra_Original.ods",sheet=1)

#We delete the rows pertaining to both students who enroled late and who dropped
#the class. We invoke the dplyr library's filter function to do this.

classOne_attendance <- classOne_attendance %>% filter(!if_any(everything(), ~grepl('nrolment',.)))
classTwo_attendance <- classTwo_attendance %>% filter(!if_any(everything(), ~grepl('nrolment',.)))

classOne_grades <- classOne_grades %>% filter(!if_any(everything(), ~grepl('nrolment',.)))
classTwo_grades <- classTwo_grades %>% filter(!if_any(everything(), ~grepl('nrolment',.)))

#Now we replace the attendance strings with numerical values: 0 for absent, 1 
#for present, so that we may more simply calculate our statistics of concern.
classOne_attendance[] <- lapply(classOne_attendance, gsub, pattern="A (0/1)", replacement="0", fixed=TRUE)
classOne_attendance[] <- lapply(classOne_attendance, gsub, pattern="P (1/1)", replacement="1", fixed=TRUE)

classTwo_attendance[] <- lapply(classTwo_attendance, gsub, pattern="A (0/1)", replacement="0", fixed=TRUE)
classTwo_attendance[] <- lapply(classTwo_attendance, gsub, pattern="P (1/1)", replacement="1", fixed=TRUE)

#Now we remove the extraneous rows from the grade data. This cannot be done in
#the same way as there is no general identifying string indicating a dropped
#course or late registration. The code below identifies the row difference by
#surname, which is included in both frames. It then removes the difference.

#There may be a "cleaner" way to perform this operation than the following, but
#the below is quite readable and rather simple.

diff_classOne <- anti_join(classOne_grades, classOne_attendance, by="Surname")
classOne_grades <- classOne_grades[!(classOne_grades$Surname %in% diff_classOne$Surname),]

diff_classTwo <- anti_join(classTwo_grades, classTwo_attendance, by="Surname")
classTwo_grades <- classTwo_grades[!(classTwo_grades$Surname %in% diff_classTwo$Surname),]

#We rename the rows of the class two grades as for some reason the extraneous
#students are misaligned between these two sets. Probably doesn't effect
#anything, but just for consistency, we write (for all of them, just to
#generalise)

row.names(classOne_attendance) <- c(1:nrow(classOne_attendance))
row.names(classTwo_attendance) <- c(1:nrow(classTwo_attendance))
row.names(classOne_grades) <- c(1:nrow(classOne_grades))
row.names(classTwo_grades) <- c(1:nrow(classTwo_grades))


#Next up is removing the spaces between the % symbols and the numbers they
#should be attached to. If we didn't do this, our calculations in testScripting
#would treat those cell values as strings --- a little harder to perform
#calculations on those!

classOne_grades[] <- lapply(classOne_grades, gsub, pattern=" %", replacement="%", fixed=TRUE)
classTwo_grades[] <- lapply(classTwo_grades, gsub, pattern=" %", replacement="%", fixed=TRUE)

#Now the last, and likely trickiest part. The data provided from the aggregator
#is not typed correctly on import --- all the columns with numbers in them are
#values as characters. We need to fix that in order to actually compute the
#desired statistics. This is straightforward for the attendance records as those
#are complete from import.

classOne_attendance[] <- lapply(classOne_attendance, function(x) {
  x1 <- type.convert(as.character(x))
    if(is.factor(x1))
      as.character(x1) else x1
})

classTwo_attendance[] <- lapply(classTwo_attendance, function(x) {
  x1 <- type.convert(as.character(x))
  if(is.factor(x1))
    as.character(x1) else x1
})

#The grade records need some extra processing to turn the dashes into zeroes for
#the purposes of our assessment. In the way we have written here, it should not
#alter any hyphenated names.
classOne_grades[] <- lapply(classOne_grades, function(x) {gsub("^-$","0",x)})
classTwo_grades[] <- lapply(classTwo_grades, function(x) {gsub("^-$","0",x)})

#Now we attempt to numericise the grade columns.

classOne_grades[] <- lapply(classOne_grades, function(x) {
  x1 <- type.convert(as.character(x))
  if(is.factor(x1))
    as.character(x1) else x1
})

classTwo_grades[] <- lapply(classTwo_grades, function(x) {
  x1 <- type.convert(as.character(x))
  if(is.factor(x1))
    as.character(x1) else x1
})

#We define a function to pass over the percentages
is.percentage <- function(x) any(grepl("%$", x))

#We use that function now to turn those percentages into decimals
classOne_grades <- classOne_grades %>% mutate_if(is.percentage, ~as.numeric(sub("%", "", .))/100)
classTwo_grades <- classTwo_grades %>% mutate_if(is.percentage, ~as.numeric(sub("%", "", .))/100)

#Having completed our pre-processing, we save the files to our working
#directory. You can now safely load the data and execute the code in
#testcripting.r!

save(classOne_attendance, file="classOne_attendance.ods")
save(classOne_grades, file="classOne_grades.ods")

save(classTwo_attendance, file="classTwo_attendance.ods")
save(classTwo_grades, file="classTwo_grades.ods")


#import libraries
library(readODS)
library(dplyr)

#We set the working directory to that from where we are loading the initial
#dataframes

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

#Having completed our pre-processing, we save the files to our working
#directory

save(classOne_attendance, file="classOne_attendance.ods")
save(classOne_grades, file="classOne_grades.ods")

save(classTwo_attendance, file="classTwo_attendance.ods")
save(classTwo_grades, file="classTwo_grades.ods")

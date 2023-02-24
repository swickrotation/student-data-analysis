
#import libraries
library(readODS)
library(dplyr)


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



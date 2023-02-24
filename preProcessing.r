
#import libraries
library(readODS)


#import attendance records
classOne_attendance <- read_ods(path="~/gitrepos/student-data-analysis/demodata/1x-att_Original.ods",sheet=1)
classTwo_attendance <- read_ods(path="~/gitrepos/student-data-analysis/demodata/2z-att_Original.ods",sheet=1)

#import grade data
classOne_grades <- read_ods(path="~/gitrepos/student-data-analysis/demodata/1x-att_Original.ods",sheet=1)
classTwo_grades <- read_ods(path="~/gitrepos/student-data-analysis/demodata/2z-att_Original.ods",sheet=1)

#We delete the rows pertaining to both students who enroled late and who dropped
#the class

classOne_attendance <- classOne_attendance %>% filter(!if_any(everything(), ~grepl('nrolment',.)))
classTwo_attendance <- classTwo_attendance %>% filter(!if_any(everything(), ~grepl('nrolment',.)))

classOne_grades <- classOne_grades %>% filter(!if_any(everything(), ~grepl('nrolment',.)))
classTwo_grades <- classTwo_grades %>% filter(!if_any(everything(), ~grepl('nrolment',.)))

#one time package install
# prerequisite: rtools
#install.packages("tidyverse")
#install.packages("readODS")


#packages
library(tidyverse)
library(readODS)

#load test data
onex_att <- read_ods(path="~/gitrepos/student-data-analysis/demodata/1x-att.ods",sheet=1)
onex_gra <- read_ods(path="~/gitrepos/student-data-analysis/demodata/1x-gra.ods",sheet=1)
twoz_att <- read_ods(path="~/gitrepos/student-data-analysis/demodata/2z-att.ods",sheet=1)
twoz_gra <- read_ods(path="~/gitrepos/student-data-analysis/demodata/2z-gra.ods",sheet=1)

# Student Data Analysis
## Intended for use by lecture staff at NUIM

The collation and evalutation of student records and performance indicators
is helpful when trying to determine factors most effecting overall outcome
and course performance. The code here written provides some basic structure
an experimenter may wish to use to perform such an analysis.

All data processing was performed in the R programming language and using the
RStudio IDE.  If starting from scratch with R, it is recommened to use RStudio
for troubleshooting purposes and its comprehensive support.

## Packages

##### Necessary

The following packages are needed for the code to run as-written:

-  tidyverse
-  readODS
-  effsize
-  dplyr

##### Optional

These packages are not required by the code as-written but are often called
and generally helpful to have available at the experimenter's discretion:

- ggplot2

##### Dependencies

The above packages require these resources be installed. It is possible that
this list is not exhaustive, but any experimenter using RStudio will be told
which packages are necessary if the scripts fail to build.

-  libxml2
-  libxml2-dev
-  openssl
-  libssl-dev
-  libcurl4-openssl-dev
-  rtools[^1]


[^1]: May only be necessary to avoid warning messages about not being able to
compile from sourcecode


## Workflow

The data is aggregated with some third-party software, I believe Moodle in
this case. While a handy utility, it does not provide data that is directly
usable in R without some pathological coding. I found it simpler to
pre-process the data from Moodle directly. For the workflow, this means:

- sending the data through preprocessing.r
- using testscripting.r for analysis

# student-data-analysis
Analysis for generated sample data for use by Maynooth university lecturers with privately-held data.


Most data processing was performed in the R programming language and using the RStudio IDE.
If starting from scratch with R, it is recommened to use RStudio for troubleshooting purposes and its
comprehensive support.

Necessary packages (to be updated):
  tidyverse
  readODS
  effsize
  dplyr

--------------

Useful to have but optional for code as-written:
  ggplot2

The dependencies of the above include but may not be limited to:
  libxml2
  libxml2-dev
  openssl
  libssl-dev
  libcurl4-openssl-dev
  rtools*


* may only be necessary to avoid warning messages about not being able to
  compile from sourcecode


WORKFLOW:
    The data is aggregated with some third-party software, I believe Moodle in
    this case. While a handy utility, it does not provide data that is directly
    usable in R without some pathological coding. I found it simpler to
    pre-process the data from Moodle directly. For the workflow, this means
    
    -sending the data through preprocessing.r
    -using testscripting.r for analysis

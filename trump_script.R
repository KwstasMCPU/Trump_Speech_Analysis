library(readr)
library(dplyr)
library(lubridate)
library(stringr)
# set working directory
setwd("C:/Users/kwsta/master_projects/Math513/CRW")
#
# list of files in a directory
txt_files_ls <- list.files("data")
#
single_speech <- data_frame(speech = c(), location = c(), date = c())

# loop in the list of files
# because we are lazy we use Regular expressions
location_pattern <- "[A-z]+(?=-|[A-Z])"
day_pattern <- "[[:digit:]]+"
speech_ls = c(1:10)
for (i in 1: length(txt_files_ls)){
  
  file_path <- paste("data",txt_files_ls[i], sep = '/')
  location_name <- str_extract(txt_files_ls[i], location_pattern)
  
  single_day <- str_extract(txt_files_ls[i], day_pattern)
  speech_date <- paste("2020-09", single_day, sep = '-')
  
  
  read_speech <- data_frame(speech = read_tsv(file_path, col_names=FALSE),location = c(location_name), date = c(as_date(speech_date)))
  single_speech <- rbind(single_speech, read_speech)
                   
}
single_speech


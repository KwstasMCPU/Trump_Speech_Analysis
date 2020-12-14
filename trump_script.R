library(readr)
library(dplyr)
library(lubridate)
library(stringr)
# set working directory
setwd("C:/Users/kwsta/master_projects/Math513/CRW")
#
# list of files in a directory
# we get all the file names in the data directory (where the .txt files are stored) and store them into a list
txt_files_ls <- list.files("data")
#
# we initialize a data_frame in order to populate it
single_speech <- data_frame(speech = c(), location = c(), date = c())


# because we are lazy we use Regular expressions in order to give the locatio and dates values
location_pattern <- "[A-z]+(?=-|[A-Z])" # this pattern matches all letters until the next char is uppercase or -, so "OhioSep21_2020.txt" returns "Ohio"
day_pattern <- "[[:digit:]]+" # this pattern matches the first digits from a string until the next char is not a digit, "Ohio21_2020.txt" returns "21"
# loop in the list of files
for (i in 1: length(txt_files_ls)){
  
  file_path <- paste("data",txt_files_ls[i], sep = '/') # we create the file path using string string concatenation
  location_name <- str_extract(txt_files_ls[i], location_pattern) # we extract the location name from the file name
  
  single_day <- str_extract(txt_files_ls[i], day_pattern) # we extract the day of the speech from the file name
  speech_date <- paste("2020-09", single_day, sep = '-') # we create the speech data with string concatenation
  
  
  read_speech <- data_frame(speech = read_tsv(file_path, col_names=FALSE),location = c(location_name), date = c(as_date(speech_date)))
  single_speech <- rbind(single_speech, read_speech)
                   
}
single_speech <- single_speech %>%
  arrange(date)


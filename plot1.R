download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="household_power_consumption.zip",mode = 'wb')
unzip("household_power_consumption.zip")

library(readr)
library(tidyverse)
library(lubridate)

power <- read_delim("household_power_consumption.txt", ";", na = "?", col_types = "ctddddddd") %>%
  filter(Date %in% c("1/2/2007","2/2/2007")) %>%
  mutate(Date = dmy(Date))

png("plot1.png")
hist(power$Global_active_power, 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()

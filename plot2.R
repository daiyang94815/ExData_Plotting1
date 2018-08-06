download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="household_power_consumption.zip",mode = 'wb')
unzip("household_power_consumption.zip")

library(readr)
library(tidyverse)
library(lubridate)

power <- read_delim("household_power_consumption.txt", ";", na = "?", col_types = "ctddddddd") %>%
  filter(Date %in% c("1/2/2007","2/2/2007")) %>%
  mutate(Date = dmy(Date),
         Date_Time = make_datetime(year(Date),
                                   month(Date),
                                   day(Date),
                                   hour(Time),
                                   minute(Time),
                                   second(Time)))

png("plot2.png")
with(power, plot(Date_Time, Global_active_power,
                type = "l", xlab = "",
                ylab = "Global Active Power (kilowatts)"))
dev.off()
  

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

png("plot3.png")
with(power, plot(Date_Time, Sub_metering_1,
                type = "n", xlab = "",
                ylab = "Energy sub metering"))
with(power, lines(Date_Time, Sub_metering_1))
with(power, lines(Date_Time, Sub_metering_2,
                  col = "red"))
with(power, lines(Date_Time, Sub_metering_3,
                  col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1), col = c(1,"red","blue"))
dev.off()


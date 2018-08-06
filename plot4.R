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

png("plot4.png")
par(mfrow = c(2,2))
with(power, plot(Date_Time, Global_active_power,
                 type = "l", xlab = "",
                 ylab = "Global Active Power"))
with(power, plot(Date_Time, Voltage,
                 type = "l", xlab = "datetime"))
with(power, plot(Date_Time, Sub_metering_1,
                 type = "n", xlab = "",
                 ylab = "Energy sub metering"))
with(power, lines(Date_Time, Sub_metering_1))
with(power, lines(Date_Time, Sub_metering_2,
                  col = "red"))
with(power, lines(Date_Time, Sub_metering_3,
                  col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1), col = c(1,"red","blue"), bty = "n")
with(power, plot(Date_Time, Global_reactive_power,
                 type = "l", xlab = "datetime"))
dev.off()


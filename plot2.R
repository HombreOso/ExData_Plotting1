library(data.table)
importedFile <- fread("./exdata_data_household_power_consumption/household_power_consumption.txt", na.strings = "?")
importedFile[, DateTime := as.Date(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
library(dplyr)
data2days <- filter(importedFile, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime <= as.Date("2007-02-02 23:59:59"))
names(data2days)
dim(data2days)
head(data2days)
table(data2days$DateTime)

data2days$WeekDay <- strftime(data2days$DateTime, format='%a')
table(data2days$WeekDay)

data2days$DT <- paste(data2days$Date, data2days$Time)

data2days$DT <- as.POSIXct(data2days$DT, format="%d/%m/%Y %H:%M:%S", tz="UTC")

head(data2days$DT)
plot(data2days$DT, data2days$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.print(png, file = "plot2.png", width = 480, height = 480)


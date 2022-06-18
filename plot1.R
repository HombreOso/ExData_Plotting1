install.packages("data.table")
library(data.table)
importedFile <- fread("./exdata_data_household_power_consumption/household_power_consumption.txt", na.strings = "?")
importedFile[, DateTime := as.Date(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
install.packages("dplyr")
library(dplyr)
data2days <- filter(importedFile, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime <= as.Date("2007-02-02 23:59:59"))
names(data2days)
dim(data2days)
head(data2days)
table(data2days$DateTime)
hist(data2days$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.print(png, file = "plot1.png", width = 480, height = 480)





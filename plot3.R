library(data.table)
library(dplyr)

# import data from txt file

importedFile <- fread("./exdata_data_household_power_consumption/household_power_consumption.txt", na.strings = "?")
# build a new column DateTime as DateTime objects
importedFile[, DateTime := as.Date(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
# to save memory, we extract the data only for two days: 2007-02-01 and 2007-02-02
data2days <- filter(importedFile, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime <= as.Date("2007-02-02 23:59:59"))
# check column names of the resulting dataframe
names(data2days)
# size of the dataframe
dim(data2days)
# look at some items of the dataframe
head(data2days)
# make sure that only two days have been imported
table(data2days$DateTime)

# add a column with weekday names using the function strftime
# the format "%a" stands for shortened weekday names
data2days$WeekDay <- strftime(data2days$DateTime, format='%a')
# make sure everything is correct
table(data2days$WeekDay)
data2days$DT <- paste(data2days$Date, data2days$Time)

# convert strings to DateTime objects using as.POSIXct function 
data2days$DT <- as.POSIXct(data2days$DT, format="%d/%m/%Y %H:%M:%S", tz="UTC")
head(data2days$DT)

# open png device with specified size 480x480 px
png(file = "plot3.png", bg = "white", h=480, w=480)

# prepare the plot
plot(data2days$DT, data2days$Sub_metering_1, type="n", ylab = "Energy sub metering", xlab="")
# adding plots for sub-meterings
lines(data2days$DT, data2days$Sub_metering_1)
lines(data2days$DT, data2days$Sub_metering_2, col="red")
lines(data2days$DT, data2days$Sub_metering_3, col="blue")
# attach the legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1))

# switch to the default device
dev.off()
# install and load packages needed for data extraction from txt file
install.packages("data.table")
library(data.table)
install.packages("dplyr")
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

# make the plot1 on the windows device
hist(data2days$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

# copy the plot to png device
dev.print(png, file = "plot1.png", width = 480, height = 480)





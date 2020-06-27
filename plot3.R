df <- read.table('C:/Users/Timon/Documents/School 2019-2020/Coding/Exploratory data analysis/Week1/household_power_consumption.txt', header = TRUE, sep = ';')
head(df)
library(dplyr)
library(tidyr)

#prepare data
Data <- mutate(df,Date.Time=paste(df$Date,df$Time)) %>%
  select(-c('Date', 'Time'))
Data$Date.Time <- as.POSIXct(strptime(Data$Date.Time, format = '%Y-%m-%d %H:%M:%S'))
filtData <- subset(Data, Date.Time >= strptime('2007-2-1', '%Y-%m-%d') & Date.Time < strptime('2007-2-3', '%Y-%m-%d'))

head(filtData)
tail(filtData)

#make all other columns numeric
filtData$Global_reactive_power <- as.numeric(as.character(filtData$Global_reactive_power))
filtData$Global_active_power <- as.numeric(as.character(filtData$Global_active_power))
filtData$Global_intensity <- as.numeric(as.character(filtData$Global_intensity))
filtData$Voltage <- as.numeric(as.character(filtData$Voltage))
filtData$Sub_metering_1 <- as.numeric(as.character(filtData$Sub_metering_1))
filtData$Sub_metering_2 <- as.numeric(as.character(filtData$Sub_metering_2))
filtData$Sub_metering_3 <- as.numeric(as.character(filtData$Sub_metering_3))

#plot 3
png(file = 'Plot3.png',  width = 480, height = 480)

with(filtData, plot(Date.Time, Sub_metering_1,  ylab = 'Energy sub metering', xlab = '', type = 'n'))
with(filtData, lines(Date.Time, Sub_metering_3,  col = 'blue', type = 'l'))
with(filtData, lines(Date.Time, Sub_metering_2,  col = 'red', type = 'l'))
with(filtData, lines(Date.Time, Sub_metering_1,  col = 'black', type = 'l'))
legend('topright', lwd = 2 , col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
dev.off()

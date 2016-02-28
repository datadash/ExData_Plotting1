loadPowerData <- function() {
  if(file.exists("two-day-power-data.txt")) {
    power.data <- read.table("two-day-power-data.txt", header=T, sep=";", na.strings = c("?"), stringsAsFactors = F, row.names = NULL)
  } else {
    power.data <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings = c("?"), stringsAsFactors = F)
    power.data$Time <- strptime(paste(power.data$Date, power.data$Time), "%d/%m/%Y %H:%M:%S")
    power.data <- subset(power.data, power.data$Time >= '2007-02-01 00:00:00' & power.data$Time < '2007-02-03 00:00:00')
    write.table(power.data, "two-day-power-data.txt", sep = ";")
    power.data
  }
}



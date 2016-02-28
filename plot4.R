source('loadPowerData.R')
library(reshape2)
power.data <- loadPowerData()
power.data$Time <- strptime(power.data$Time, "%Y-%m-%d %H:%M:%S")

submeter.data <- subset(power.data, select = c(Time, Sub_metering_1, Sub_metering_2, Sub_metering_3))
submeter.data$Time <- as.character(submeter.data$Time)
submeter.data <- melt(submeter.data, id.vars = c('Time'), variable.name = 'Submeter')
submeter.data$Time <-  strptime(submeter.data$Time, "%Y-%m-%d %H:%M:%S")

par(mfrow = c(2, 2))

with(power.data, plot(Time, Global_active_power, xlab="", ylab = "Global Active Power (killowatts)", pch=20, type="o", cex = 0.2))
with(power.data, plot(Time, Voltage, xlab="datetime", ylab = "Voltage", pch=20, type="o", cex = 0.2))
with(submeter.data, plot(Time, value, pch=20, type="o", cex = 0.2, col=Submeter, xlab="", ylab = "Engergy sub metering"))
legend("topright", pch ="--", 
       col=as.numeric(substr(levels(submeter.data$Submeter), 14,15)), 
       legend = as.character(levels(submeter.data$Submeter)))
with(power.data, plot(Time, Global_reactive_power, xlab="datetime", ylab = "Global Reactive Power", pch=20, type="o", cex = 0.2))

dev.copy(png, width=480, height=480, file = "plot4.png")
dev.off()
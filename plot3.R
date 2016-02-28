source('loadPowerData.R')
library(reshape2)
power.data <- loadPowerData()
submeter.data <- subset(power.data, select = c(Time, Sub_metering_1, Sub_metering_2, Sub_metering_3))
submeter.data$Time <- as.character(submeter.data$Time)
submeter.data <- melt(submeter.data, id.vars = c('Time'), variable.name = 'Submeter')
submeter.data$Time <-  strptime(submeter.data$Time, "%Y-%m-%d %H:%M:%S")

with(submeter.data, plot(Time, value, pch=20, type="o", cex = 0.2, col=Submeter, xlab="", ylab = "Engergy sub metering"))

legend("topright", pch ="--", cex = 0.8, 
       col=as.numeric(substr(levels(submeter.data$Submeter), 14,15)), 
       legend = as.character(levels(submeter.data$Submeter)))
dev.copy(png, width=480, height=480, file = "plot3.png")
dev.off()
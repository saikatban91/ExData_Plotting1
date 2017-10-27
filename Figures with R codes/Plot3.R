##Open the data on notepad++ to see how many rows to skip and then read with the correct 
##separator, with specifying which characters constitute as NA
house <- read.table("household_power_consumption.txt", 
                    skip = 66638, nrow = 2879, sep = ";", na.strings = "?", 
                    stringsAsFactors = F)
##read the first row only and then assign the column names to the vectorised names that 
## was read from the table
house_names <- read.table("household_power_consumption.txt", sep = ";", nrow = 1, header = F)
colnames(house) <- unlist(house_names)
##Merge date and time columns and convert them to as.POSIXct objects and arrange them 
## and change the name accordingly
house$DateTime <- as.POSIXct(paste(house$Date, house$Time), format = "%d/%m/%Y %H:%M:%S")
house[,1] <- house[, "DateTime"]
house <- house[,-2]
house <- house[, -9]
colnames(house)[1] <- "DateTime"
##Plot Energy sub metering as a function of weekdays over the two time period
plot(house$Sub_metering_1 ~ house$DateTime, type = "l", xlab = "", ylim = c(0,40), 
     col = "black", ylab = "Energy sub metering")
par(new = T)
plot(house$Sub_metering_2 ~ house$DateTime, type = "l", xlab = "", ylim = c(0,40), 
     col = "red", ylab = "Energy sub metering")
par(new = T)
plot(house$Sub_metering_3 ~ house$DateTime, type = "l", xlab = "", ylim = c(0,40), 
     col = "blue", ylab = "Energy sub metering")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = 
         paste("Sub_metering_", c(1,2,3)), y.intersp = 0.5, cex = 1)
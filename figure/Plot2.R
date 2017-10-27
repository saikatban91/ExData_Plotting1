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
##Plot global active power as a function of weekdays over the two time period
plot(house$Global_active_power ~ house$DateTime, type = "l", xlab = "", 
ylab = "Global Active Power (kilowatts)")


library(data.table)

# Download data file if needed
if (!file.exists("household_power_consumption.txt")) {
    
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data.zip", method = "curl", quiet = TRUE)
    
}
unzip("data.zip")
# Read data
data_file <- "household_power_consumption.txt"
all_data <- read.table(data_file, header = TRUE, na.strings = "?", sep = ";")
# Specify the data in the particular range
data <- all_data[(all_data$Date == "1/2/2007" | all_data$Date == "2/2/2007"),]

# Format the Date column as a date class
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
# Add a new column to the data table, by pasting together the values of the Date column and the Time column
dateTime <- paste(data$Date, data$Time)
# Reformat the DateTime coumn to a calendar date
data$DateTime <- as.POSIXct(dateTime)

plot(data$Global_active_power~data$DateTime, 
     type="l",
     ylab="Global Active Power (kilowatts)", 
     xlab="")


dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

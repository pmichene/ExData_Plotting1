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

with(data, {
    # Plot submeter 1 as a function of the DateTime variable
    plot(Sub_metering_1~DateTime, 
         type="l",
         ylab="Energy sub metering", 
         xlab="")
    # Add submeter 2 and 3 and additional lines in different colors
    lines(Sub_metering_2~DateTime, col='Red')
    lines(Sub_metering_3~DateTime, col='Blue')
            })
# format the legend
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

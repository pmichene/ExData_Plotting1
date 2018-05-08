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

# Set the parameters for making 4 graphs in one device
par(mfcol=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
    # Same as plot2
    plot(Global_active_power~DateTime, 
         type="l", 
         ylab="Global Active Power", 
         xlab="")
    # Same as plot3
    plot(Sub_metering_1~DateTime, 
         type="l", 
         ylab="Energy sub metering", 
         xlab="")
    # Add the other lines as in plot3
    lines(Sub_metering_2~DateTime,col='Red')
    lines(Sub_metering_3~DateTime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    # Plot voltage as it relates to DateTime
    plot(Voltage~DateTime, 
         type="l", 
         ylab="Voltage", 
         xlab="")
    # Plot Global reactive power as it relates to DateTime
    plot(Global_reactive_power~DateTime, 
         type="l", 
         ylab="Global_Rective_Power",
         xlab="")
})
# Copy the plot from the graphics device and save to a .png file
dev.copy(png, file="plot4.png", height=480, width=480)
# Close the Device
dev.off()
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

# Plot the data as a histogram
hist(data$Global_active_power, 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", 
     main="Global Active Power", 
     col="red")

# Copy the histogram from the open graphics device, to a .png file
dev.copy(png, file="plot1.png", height=480, width=480)
# Close the graphics device
dev.off()

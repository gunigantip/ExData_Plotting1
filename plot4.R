# Plot 4: Subplots of Global Active Power, Global reactive power, Energy and voltage
# Using the base plotting system, construct a plot and save it to a PNG file
# with a width of 480 pixels and a height of 480 pixels.


# Read in the power consumption data set
# First two columns are Date and Time
# "?" is the NA characted in this set, so designate it as such
data <- read.csv("household_power_consumption.txt",
                 sep=";",
                 colClasses=c(rep("character",2),rep("numeric",7)),
                 na.strings="?")

# Combine the date and time variables to one Date/Time class
data$Timestamp <- strptime(paste(data$Date,data$Time),
                           format="%d/%m/%Y %H:%M:%S")

# Drop the now-unnecessary date and time cols
data$Date=NULL
data$Time=NULL

# We will only be using data from the dates 2007-02-01 and 2007-02-02.
# So, read the data from just those dates rather than reading in the entire dataset
sub_data = subset(data,as.Date(data$Timestamp) >= "2007-02-01" 
                  & as.Date(data$Timestamp) < "2007-02-03")

# Start the png device
png(filename="plot4.png", height=480, width=480)

# Create a 2x2 split

par(mfrow=c(2,2))

# SUBPLOT 1 - same as Plot 2

plot(sub_data$Timestamp,
     sub_data$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")

# SUBPLOT 2 - voltage vs time

plot(sub_data$Timestamp,
     sub_data$Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage")

# SUBPLOT 3 - same as Plot 3

# Plot the first sub-meter
plot(sub_data$Timestamp,
     sub_data$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering")

# Plot the second sub-meter
lines(sub_data$Timestamp,
      sub_data$Sub_metering_2,
      type="l",
      col="red")

# Plot the third sub-meter
lines(sub_data$Timestamp,
      sub_data$Sub_metering_3,
      type="l",
      col="blue")

# Add the legend
legend(x="topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1),lwd=2,col=c("black","red","blue"),bty="n")

# SUBPLOT 4

plot(sub_data$Timestamp,
     sub_data$Global_reactive_power,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")


# Save the figure
dev.off()
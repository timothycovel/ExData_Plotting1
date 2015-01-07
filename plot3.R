plot3 <- function(){
  # plot3() reproduces the plot3.png from https://github.com/rdpeng/ExData_Plotting1 in the current directory
  # you can recreate the plot3.png using this script and the household_power_consumption.txt data source by issuing the following commands:
  
  # source("plot3.R")
  # plot3()
  
  #if the data set is not available, download and unzip it
  if (! file.exists("household_power_consumption.txt")){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    file <- "household_power_consumption.zip"
    download.file(url, file, method = "curl")
    
    unzip(file)
  }
  
  #################################
  ## cool date formatting method ##
  #################################
  #http://stackoverflow.com/questions/13022299/specify-date-format-for-colclasses-argument-in-read-table-read-csv
  setClass('myDate')
  setAs("character", "myDate", function(from) as.Date(from, format="%d/%m/%Y")) #
  #################################
  
  
  # Read in a subset of the data from the file for just the date range we need, plus the headers
  # To save resources I am preprocessing data using the R pipe() function in order to filter the set to only the data we need
  # Remember to set seperators to semicolon and set the column classes appropriately
  # powerdataset will be the data.frame object we use for building the plots 
  
  powerdataset <- read.csv(
    pipe("egrep 'Date|^1/2/2007|^2/2/2007' household_power_consumption.txt"),
    sep=";", na.strings="?", colClasses=c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
  )
  
  # is there a better way to pre-process the dataset before it is read without a pipe? please comment if you know!
  
  
  # we need a datetime field, we have Date and Time, so merge them with pase() and use strptime() as recommended in the instructions
  powerdataset$datetime <- paste(powerdataset$Date, powerdataset$Time)
  powerdataset$datetime <- strptime(powerdataset$datetime, format="%Y-%m-%d %H:%M:%S")
  
  # create the png
  png(filename="plot3.png", width=480, height=480, units="px")
  
  # create the basic line plot of type "l"
  plot(powerdataset$datetime, powerdataset$Sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering")
  
  # add additional data for Sub_metering_2 and Sub_metering_3
  lines(powerdataset$datetime, powerdataset$Sub_metering_2, col="red")
  lines(powerdataset$datetime, powerdataset$Sub_metering_3, col="blue")
  
  # add the legend
  legend(x="topright", c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"), 
         lty=c(1,1,1), lwd=c(1,1,1),col=c("black","red","blue"))
  
  #SUPER IMPORTANT, this actually writes the data to the file.
  dev.off()
  
  print("plot3 written to plot3.png")
}
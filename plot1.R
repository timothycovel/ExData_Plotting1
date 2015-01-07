plot1 <- function(){
  # plot1() reproduces the plot1.png from https://github.com/rdpeng/ExData_Plotting1 in the current directory
  # you can recreate the plot1.png using this script and the household_power_consumption.txt data source by issuing the following commands:
  
  # source("plot1.R")
  # plot1()
  
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


  #simple histogram
  #hist(powerdataset$Global_active_power)

  #tell R to make a png for the output, set width and height in pixels
  png(filename="plot1.png", width=480, height=480, units="px")

  #run the histogram, set column color and labels
  hist(powerdataset$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(Kilowatts)")
  
  
  #SUPER IMPORTANT, this actually writes the data to the file. 
  dev.off()
  
  print("plot1 written to plot1.png")
}
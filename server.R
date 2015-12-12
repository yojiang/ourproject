library(shiny)
library(ggmap)
library(ggplot2)

#set the work directory
setwd("C:/jiangyong/in  syracuse/course/2015 FALL/data driven/project/our project") 

function(input, output){
  #read in data
  mydata <- read.csv("./data/Errors from Immigrant Eligibility Data.csv")

  #transform center addresses to geocode
  center.address <- as.character( mydata$ADDRESS )
  mygeocode <- geocode(center.address, source = "google")
  
  #combine geocode to mydata
  mydata <- cbind( mydata, mygeocode)
  
  #create new york city map from google
  mymap <- get_map(location = "New York", maptype = "roadmap")
  
  #clean up documentation
  mydata$Documentation <- as.character(mydata$Documentation)
  mydata$Documentation <- gsub("I-551 CU6","I-551 CU", mydata$Documentation)
  mydata$Documentation <- gsub("I-551 CU7","I-551 CU", mydata$Documentation) 
  mydata$Documentation <- gsub("I-551 F11","I-551 F", mydata$Documentation) 
  mydata$Documentation <- gsub("I-551 F16","I-551 F", mydata$Documentation) 
  mydata$Documentation <- gsub("I-551 F21","I-551 F", mydata$Documentation) 
  mydata$Documentation <- gsub("I-551 F26","I-551 F", mydata$Documentation) 
  mydata$Documentation <- gsub("I-551 F27","I-551 F", mydata$Documentation) 
  mydata$Documentation <- gsub("I-551 F28","I-551 F", mydata$Documentation) 
  mydata$Documentation <- gsub("I-551 F29","I-551 F", mydata$Documentation) 
  mydata$Documentation <- gsub("I-551 F43","I-551 F", mydata$Documentation) 
  mydata$Documentation <- gsub("I-551 F44","I-551 F", mydata$Documentation) 
  mydata$Documentation <- gsub("I-688B 12a4","I-688B", mydata$Documentation) 
  mydata$Documentation <- gsub("I-688B 12a5","I-688B", mydata$Documentation) 
  mydata$Documentation <- gsub("I-766 a10*", "I-766 a10", mydata$Documentation) 
  mydata$Documentation <- gsub("I-94 212d5", "I-94", mydata$Documentation) 
  mydata$Documentation <- gsub("I-94 K3 and I-130", "I-94", mydata$Documentation) 
  mydata$Documentation <- gsub("prima facie", "Prima Facie", mydata$Documentation) 
  
  #output 
  output$plot <- renderPlot({
    
    #create subset based on input
    dat <- mydata[mydata$Last.MKB.staff.training..yrs.==input$year & mydata$Documentation ==input$Documentation, ]
    
    #combine map with mygeocode
    mymap <- ggmap(mymap) + 
      geom_point( data=dat, aes(x=lon, y=lat), size=5, col="red", alpha=0.5 )
    
    #output map
    print(mymap)
  })
}











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
  
  #output 
  output$plot <- renderPlot({
    
    #create subset based on input
    dat <- mydata[mydata$Last.MKB.staff.training..yrs.==input$year, ]
    
    #combine map with mygeocode
    mymap <- ggmap(mymap) + 
      geom_point( data=dat, aes(x=lon, y=lat), size=5, col="red", alpha=0.5 )
    
    #output map
    print(mymap)
  })
}











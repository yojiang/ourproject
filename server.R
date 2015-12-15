library(shiny)
library(ggmap)
library(ggplot2)




shinyServer(function(input, output){
  #read in data
  mydata <- read.csv("errors.csv")
  
  #transform center addresses to geocode
  center.address <- as.character( mydata$ADDRESS )
  mygeocode <- geocode(center.address, source = "google")
  
  #combine geocode to mydata
  mydata <- cbind( mydata, mygeocode)
  
  #create new york city map from google
  mymap <- get_map(location = "New York", maptype = "roadmap")
  
  #clean up type of documentation
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
  
  #Defining errors by documentation for dataframe
  
  doc <- table (mydata$Documentation, mydata$Center)
  
  #create number of errors by staff
  Concourse1 <- sum(mydata$Center == "Concourse" & mydata$Last.MKB.staff.training..yrs. == 1)
  Concourse2 <- sum(mydata$Center == "Concourse" & mydata$Last.MKB.staff.training..yrs. == 2)
  Concourse3 <- sum(mydata$Center == "Concourse" & mydata$Last.MKB.staff.training..yrs. == 3)
  Concourse4 <- sum(mydata$Center == "Concourse" & mydata$Last.MKB.staff.training..yrs. == 4)
  Concourse5 <- sum(mydata$Center == "Concourse" & mydata$Last.MKB.staff.training..yrs. == 5)
  Concourse6 <- sum(mydata$Center == "Concourse" & mydata$Last.MKB.staff.training..yrs. == 6)
  Concourse7 <- sum(mydata$Center == "Concourse" & mydata$Last.MKB.staff.training..yrs. == 7)
  Concourse8 <- sum(mydata$Center == "Concourse" & mydata$Last.MKB.staff.training..yrs. == 8)
  
  concourse.errors <- c(Concourse1, Concourse2, Concourse3, Concourse4, Concourse5, Concourse6, Concourse7, Concourse8)
  
  ConeyIsland1 <- sum(mydata$Center == "Coney_Island" & mydata$Last.MKB.staff.training..yrs. == 1)
  ConeyIsland2 <- sum(mydata$Center == "Coney_Island" & mydata$Last.MKB.staff.training..yrs. == 2)
  ConeyIsland3 <- sum(mydata$Center == "Coney_Island" & mydata$Last.MKB.staff.training..yrs. == 3)
  ConeyIsland4 <- sum(mydata$Center == "Coney_Island" & mydata$Last.MKB.staff.training..yrs. == 4)
  ConeyIsland5 <- sum(mydata$Center == "Coney_Island" & mydata$Last.MKB.staff.training..yrs. == 5)
  ConeyIsland6 <- sum(mydata$Center == "Coney_Island" & mydata$Last.MKB.staff.training..yrs. == 6)
  ConeyIsland7 <- sum(mydata$Center == "Coney_Island" & mydata$Last.MKB.staff.training..yrs. == 7)
  ConeyIsland8 <- sum(mydata$Center == "Coney_Island" & mydata$Last.MKB.staff.training..yrs. == 8)
  
  coneyisland.errors <- c(ConeyIsland1, ConeyIsland2, ConeyIsland3, ConeyIsland4, ConeyIsland5, ConeyIsland6, ConeyIsland7, ConeyIsland8)
  
  years <- c(1,2,3,4,5,6,7,8)
  
  crotona1 <- sum(mydata$Center == "Crotona" & mydata$Last.MKB.staff.training..yrs. == 1)
  crotona2 <- sum(mydata$Center == "Crotona" & mydata$Last.MKB.staff.training..yrs. == 2)
  crotona3 <- sum(mydata$Center == "Crotona" & mydata$Last.MKB.staff.training..yrs. == 3)
  crotona4 <- sum(mydata$Center == "Crotona" & mydata$Last.MKB.staff.training..yrs. == 4)
  crotona5 <- sum(mydata$Center == "Crotona" & mydata$Last.MKB.staff.training..yrs. == 5)
  crotona6 <- sum(mydata$Center == "Crotona" & mydata$Last.MKB.staff.training..yrs. == 6)
  crotona7 <- sum(mydata$Center == "Crotona" & mydata$Last.MKB.staff.training..yrs. == 7)
  crotona8 <- sum(mydata$Center == "Crotona" & mydata$Last.MKB.staff.training..yrs. == 8)
  
  crotona.errors <- c(crotona1, crotona2, crotona3, crotona4, crotona5, crotona6, crotona7, crotona8)
  
  eastny1 <- sum(mydata$Center == "East_NY" & mydata$Last.MKB.staff.training..yrs. == 1)
  eastny2 <- sum(mydata$Center == "East_NY" & mydata$Last.MKB.staff.training..yrs. == 2)
  eastny3 <- sum(mydata$Center == "East_NY" & mydata$Last.MKB.staff.training..yrs. == 3)
  eastny4 <- sum(mydata$Center == "East_NY" & mydata$Last.MKB.staff.training..yrs. == 4)
  eastny5 <- sum(mydata$Center == "East_NY" & mydata$Last.MKB.staff.training..yrs. == 5)
  eastny6 <- sum(mydata$Center == "East_NY" & mydata$Last.MKB.staff.training..yrs. == 6)
  eastny7 <- sum(mydata$Center == "East_NY" & mydata$Last.MKB.staff.training..yrs. == 7)
  eastny8 <- sum(mydata$Center == "East_NY" & mydata$Last.MKB.staff.training..yrs. == 8)
  
  eastny.errors <- c(eastny1, eastny2, eastny3, eastny4, eastny5, eastny6, eastny7, eastny8)
  
  fg1 <- sum(mydata$Center == "Fort_Greene" & mydata$Last.MKB.staff.training..yrs. == 1)
  fg2 <- sum(mydata$Center == "Fort_Greene" & mydata$Last.MKB.staff.training..yrs. == 2)
  fg3 <- sum(mydata$Center == "Fort_Greene" & mydata$Last.MKB.staff.training..yrs. == 3)
  fg4 <- sum(mydata$Center == "Fort_Greene" & mydata$Last.MKB.staff.training..yrs. == 4)
  fg5 <- sum(mydata$Center == "Fort_Greene" & mydata$Last.MKB.staff.training..yrs. == 5)
  fg6 <- sum(mydata$Center == "Fort_Greene" & mydata$Last.MKB.staff.training..yrs. == 6)
  fg7 <- sum(mydata$Center == "Fort_Greene" & mydata$Last.MKB.staff.training..yrs. == 7)
  fg8 <- sum(mydata$Center == "Fort_Greene" & mydata$Last.MKB.staff.training..yrs. == 8)
  
  fg.errors <- c(fg1, fg2, fg3, fg4, fg5, fg6, fg7, fg8)
  
  jam1 <- sum(mydata$Center == "Jamaica" & mydata$Last.MKB.staff.training..yrs. == 1)
  jam2 <- sum(mydata$Center == "Jamaica" & mydata$Last.MKB.staff.training..yrs. == 2)
  jam3 <- sum(mydata$Center == "Jamaica" & mydata$Last.MKB.staff.training..yrs. == 3)
  jam4 <- sum(mydata$Center == "Jamaica" & mydata$Last.MKB.staff.training..yrs. == 4)
  jam5 <- sum(mydata$Center == "Jamaica" & mydata$Last.MKB.staff.training..yrs. == 5)
  jam6 <- sum(mydata$Center == "Jamaica" & mydata$Last.MKB.staff.training..yrs. == 6)
  jam7 <- sum(mydata$Center == "Jamaica" & mydata$Last.MKB.staff.training..yrs. == 7)
  jam8 <- sum(mydata$Center == "Jamaica" & mydata$Last.MKB.staff.training..yrs. == 8)
  
  jam.errors <- c(jam1, jam2, jam3, jam4, jam5, jam6, jam7, jam8)
  
  queens1 <- sum(mydata$Center == "Queens" & mydata$Last.MKB.staff.training..yrs. == 1)
  queens2 <- sum(mydata$Center == "Queens" & mydata$Last.MKB.staff.training..yrs. == 2)
  queens3 <- sum(mydata$Center == "Queens" & mydata$Last.MKB.staff.training..yrs. == 3)
  queens4 <- sum(mydata$Center == "Queens" & mydata$Last.MKB.staff.training..yrs. == 4)
  queens5 <- sum(mydata$Center == "Queens" & mydata$Last.MKB.staff.training..yrs. == 5)
  queens6 <- sum(mydata$Center == "Queens" & mydata$Last.MKB.staff.training..yrs. == 6)
  queens7 <- sum(mydata$Center == "Queens" & mydata$Last.MKB.staff.training..yrs. == 7)
  queens8 <- sum(mydata$Center == "Queens" & mydata$Last.MKB.staff.training..yrs. == 8)
  
  queens.errors <- c(queens1, queens2, queens3, queens4, queens5, queens6, queens7, queens8)
  
  ref1 <- sum(mydata$Center == "Refugee" & mydata$Last.MKB.staff.training..yrs. == 1)
  ref2 <- sum(mydata$Center == "Refugee" & mydata$Last.MKB.staff.training..yrs. == 2)
  ref3 <- sum(mydata$Center == "Refugee" & mydata$Last.MKB.staff.training..yrs. == 3)
  ref4 <- sum(mydata$Center == "Refugee" & mydata$Last.MKB.staff.training..yrs. == 4)
  ref5 <- sum(mydata$Center == "Refugee" & mydata$Last.MKB.staff.training..yrs. == 5)
  ref6 <- sum(mydata$Center == "Refugee" & mydata$Last.MKB.staff.training..yrs. == 6)
  ref7 <- sum(mydata$Center == "Refugee" & mydata$Last.MKB.staff.training..yrs. == 7)
  ref8 <- sum(mydata$Center == "Refugee" & mydata$Last.MKB.staff.training..yrs. == 8)
  
  ref.errors <- c(ref1, ref2, ref3, ref4, ref5, ref6, ref7, ref8)
  
  rich1 <- sum(mydata$Center == "Richmond" & mydata$Last.MKB.staff.training..yrs. == 1)
  rich2 <- sum(mydata$Center == "Richmond" & mydata$Last.MKB.staff.training..yrs. == 2)
  rich3 <- sum(mydata$Center == "Richmond" & mydata$Last.MKB.staff.training..yrs. == 3)
  rich4 <- sum(mydata$Center == "Richmond" & mydata$Last.MKB.staff.training..yrs. == 4)
  rich5 <- sum(mydata$Center == "Richmond" & mydata$Last.MKB.staff.training..yrs. == 5)
  rich6 <- sum(mydata$Center == "Richmond" & mydata$Last.MKB.staff.training..yrs. == 6)
  rich7 <- sum(mydata$Center == "Richmond" & mydata$Last.MKB.staff.training..yrs. == 7)
  rich8 <- sum(mydata$Center == "Richmond" & mydata$Last.MKB.staff.training..yrs. == 8)
  
  rich.errors <- c(rich1, rich2, rich3, rich4, rich5, rich6, rich7, rich8)
  
  rock1 <- sum(mydata$Center == "Rockaway" & mydata$Last.MKB.staff.training..yrs. == 1)
  rock2 <- sum(mydata$Center == "Rockaway" & mydata$Last.MKB.staff.training..yrs. == 2)
  rock3 <- sum(mydata$Center == "Rockaway" & mydata$Last.MKB.staff.training..yrs. == 3)
  rock4 <- sum(mydata$Center == "Rockaway" & mydata$Last.MKB.staff.training..yrs. == 4)
  rock5 <- sum(mydata$Center == "Rockaway" & mydata$Last.MKB.staff.training..yrs. == 5)
  rock6 <- sum(mydata$Center == "Rockaway" & mydata$Last.MKB.staff.training..yrs. == 6)
  rock7 <- sum(mydata$Center == "Rockaway" & mydata$Last.MKB.staff.training..yrs. == 7)
  rock8 <- sum(mydata$Center == "Rockaway" & mydata$Last.MKB.staff.training..yrs. == 8)
  
  rock.errors <- c(rock1, rock2, rock3, rock4, rock5, rock6, rock7, rock8)
  
  sn1 <- sum(mydata$Center == "St_Nicholas" & mydata$Last.MKB.staff.training..yrs. == 1)
  sn2 <- sum(mydata$Center == "St_Nicholas" & mydata$Last.MKB.staff.training..yrs. == 2)
  sn3 <- sum(mydata$Center == "St_Nicholas" & mydata$Last.MKB.staff.training..yrs. == 3)
  sn4 <- sum(mydata$Center == "St_Nicholas" & mydata$Last.MKB.staff.training..yrs. == 4)
  sn5 <- sum(mydata$Center == "St_Nicholas" & mydata$Last.MKB.staff.training..yrs. == 5)
  sn6 <- sum(mydata$Center == "St_Nicholas" & mydata$Last.MKB.staff.training..yrs. == 6)
  sn7 <- sum(mydata$Center == "St_Nicholas" & mydata$Last.MKB.staff.training..yrs. == 7)
  sn8 <- sum(mydata$Center == "St_Nicholas" & mydata$Last.MKB.staff.training..yrs. == 8)
  
  sn.errors <- c(sn1, sn2, sn3, sn4, sn5, sn6, sn7, sn8)
  
  wh1 <- sum(mydata$Center == "Washington_Heights" & mydata$Last.MKB.staff.training..yrs. == 1)
  wh2 <- sum(mydata$Center == "Washington_Heights" & mydata$Last.MKB.staff.training..yrs. == 2)
  wh3 <- sum(mydata$Center == "Washington_Heights" & mydata$Last.MKB.staff.training..yrs. == 3)
  wh4 <- sum(mydata$Center == "Washington_Heights" & mydata$Last.MKB.staff.training..yrs. == 4)
  wh5 <- sum(mydata$Center == "Washington_Heights" & mydata$Last.MKB.staff.training..yrs. == 5)
  wh6 <- sum(mydata$Center == "Washington_Heights" & mydata$Last.MKB.staff.training..yrs. == 6)
  wh7 <- sum(mydata$Center == "Washington_Heights" & mydata$Last.MKB.staff.training..yrs. == 7)
  wh8 <- sum(mydata$Center == "Washington_Heights" & mydata$Last.MKB.staff.training..yrs. == 8)
  
  wh.errors <- c(wh1, wh2, wh3, wh4, wh5, wh6, wh7, wh8)
  
  wav1 <- sum(mydata$Center == "Waverly" & mydata$Last.MKB.staff.training..yrs. == 1)
  wav2 <- sum(mydata$Center == "Waverly" & mydata$Last.MKB.staff.training..yrs. == 2)
  wav3 <- sum(mydata$Center == "Waverly" & mydata$Last.MKB.staff.training..yrs. == 3)
  wav4 <- sum(mydata$Center == "Waverly" & mydata$Last.MKB.staff.training..yrs. == 4)
  wav5 <- sum(mydata$Center == "Waverly" & mydata$Last.MKB.staff.training..yrs. == 5)
  wav6 <- sum(mydata$Center == "Waverly" & mydata$Last.MKB.staff.training..yrs. == 6)
  wav7 <- sum(mydata$Center == "Waverly" & mydata$Last.MKB.staff.training..yrs. == 7)
  wav8 <- sum(mydata$Center == "Waverly" & mydata$Last.MKB.staff.training..yrs. == 8)
  
  wav.errors <- c(wav1, wav2, wav3, wav4, wav5, wav6, wav7, wav8)
  
  wb1 <- sum(mydata$Center == "Williamsburg" & mydata$Last.MKB.staff.training..yrs. == 1)
  wb2 <- sum(mydata$Center == "Williamsburg" & mydata$Last.MKB.staff.training..yrs. == 2)
  wb3 <- sum(mydata$Center == "Williamsburg" & mydata$Last.MKB.staff.training..yrs. == 3)
  wb4 <- sum(mydata$Center == "Williamsburg" & mydata$Last.MKB.staff.training..yrs. == 4)
  wb5 <- sum(mydata$Center == "Williamsburg" & mydata$Last.MKB.staff.training..yrs. == 5)
  wb6 <- sum(mydata$Center == "Williamsburg" & mydata$Last.MKB.staff.training..yrs. == 6)
  wb7 <- sum(mydata$Center == "Williamsburg" & mydata$Last.MKB.staff.training..yrs. == 7)
  wb8 <- sum(mydata$Center == "Williamsburg" & mydata$Last.MKB.staff.training..yrs. == 8)
  
  wb.errors <- c(wb1, wb2, wb3, wb4, wb5, wb6, wb7, wb8)
  
  all1 <- sum(mydata$Last.MKB.staff.training..yrs. == 1)
  all2 <- sum(mydata$Last.MKB.staff.training..yrs. == 2)
  all3 <- sum(mydata$Last.MKB.staff.training..yrs. == 3)
  all4 <- sum(mydata$Last.MKB.staff.training..yrs. == 4)
  all5 <- sum(mydata$Last.MKB.staff.training..yrs. == 5)
  all6 <- sum(mydata$Last.MKB.staff.training..yrs. == 6)
  all7 <- sum(mydata$Last.MKB.staff.training..yrs. == 7)
  all8 <- sum(mydata$Last.MKB.staff.training..yrs. == 8)
  
  all.errors <- c(all1, all2, all3, all4, all5, all6, all7, all8)
  
  staff.errors <- data.frame(years, 
                             Concourse = concourse.errors, 
                             Coney_Island = coneyisland.errors, 
                             Crotona = crotona.errors, 
                             East_NY = eastny.errors, 
                             Fort_Greene = fg.errors, 
                             Jamaica = jam.errors, 
                             Queens = queens.errors, 
                             Refugee = ref.errors, 
                             Richmond = rich.errors,
                             Rockaway = rock.errors,
                             St_Nicholas = sn.errors,
                             Washington_Heights = wh.errors,
                             Waverly = wav.errors,
                             Williamsburg = wb.errors,
                             Total = all.errors
  )
  
  #output map 
  output$plot1 <- renderPlot({
    
    #create subset based on input
    dat <- mydata[mydata$Last.MKB.staff.training..yrs.==input$year & mydata$Documentation ==input$Documentation, ]
    
    #combine map with mygeocode
    ggmap(mymap) + 
      geom_point( data=dat, aes(x=lon, y=lat), size=5, col="red", alpha=0.5 )
  
    })
  
  #output error by documents
  output$ErrorPlot <- renderPlot({
    
    #error.dat <- doc.frame[doc.frame$Var2 == input$center, ]
    
    #Render a barplot
    barplot(doc[, input$center],
            main=input$center, 
            col = "light blue",
            ylab="Number of Errors",
            xlab="Documents")
    })
  
  #output errors by training years
  output$stafferrorPlot <- renderPlot({
    
    #sub.dat <- mydata[mydata$Center,]
    
    #Defining errors by years for dataframe
    #staff.errors <- table(sub.dat$Documentation, sub.dat$Last.MKB.staff.training..yrs.)
    
    # Render a barplot
    barplot(staff.errors[, input$center],
            main=input$center,
            ylab="Number of Errors",
            xlab="Years since Training",
            names.arg =staff.errors$years)
  })
  
})

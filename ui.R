library(shiny)
library(ggmap)
library(ggplot2)

shiniy(fluidPage(
  #the name of title
  titlePanel("Immigrant Eligibility"),
  
  #siebarpanel
  sidebarPanel(
    
    #create variables "yearâï¼we can add more here
    selectInput('year', 'Year', c("1","2","3","4","5","6","7","8","9")),
    
    selectInput('Documentation', 'Documentation', c("I-551 CU","I-551 F","I-688B","I-766 a10","I-94","I-94 order of supervision","Prima Facie")),
    
    selectInput("center", "Center:", 
                choices= c("Concourse", "Coney_Island", "Crotona",
                           "East_NY", "Fort_Greene", "Jamaica",
                           "Queens", "Refugee", "Richmond", "Rockaway",
                           "St_Nicholas", "Washington_Heights", "Waverly",
                           "Williamsburg"))
),

#mainpanel
mainPanel(
  tabsetPanel(type = "tabs",
              
              tabPanel("Map",
                       plotOutput('plot1', height="500")),
              
              tabPanel("Errors by Documents",
                       plotOutput('ErrorPlot')),
              
              tabPanel("Errors by Staff",
                       plotOutput('stafferrorPlot'))
  
             )
          )
))

library(shiny)

# Define UI for miles per gallon application
shinyUI(navbarPage("Mining CA Solar Statistics",
  tabPanel("Maps",
  
  # Application title
 ## titlePanel("Predicted vs Actual Installed Residential Solar Power by Quarter"),
  
  # Sidebar with controls to select the variable to plot against
  # mpg and to specify whether outliers should be included
  sidebarLayout(
    sidebarPanel(
      ##setup drop down menu for year
      selectInput("year", "Year:",
                  c("2009" = 2009,
                    "2010" = 2010,
                    "2011" = 2011,
                    "2012" = 2012,
                    "2013" = 2013)),
      ##setup drop down menu for quarter
      selectInput("quarter", "Quarter:",
                  c("1" = 'Winter',
                    "2" = 'Spring',
                    "3" = 'Summer',
                    "4" = 'Autumn')),
      p("The plots to the right are generated using data from the California Solar Statistics, Census Bureau and NASA. The predictions
         are the out-of-bag predictions from a random forest model fit to the data. In the model, the predictors are population, median income,
        average solar insolation and the price of residential PV systems/Watt. The response that I am fitting is tha amount of installed solar energy by county by quarter.
        For more information about how this was created check out the Ca Solar series of posts on my blog at "),
      a('www.beyondmaxwell.com',href='http://www.beyondmaxwell.com')
      ),
    mainPanel(
     ##using the fluidRow i can make the plots by county side by side, otherwise they would be all stacked vertically
      fluidRow(
        column(6,
               plotOutput("caPlot")
        ),
        column(6,
               plotOutput("caPlot2")
        )      
      ),   
      plotOutput("barPlot")
    )
  )),
 tabPanel("Predictions by Var",
          sidebarPanel(
            ##setup drop down menu for year
            selectInput("predictor2", "X-axis variable:",
                        c("Population" ="pop",
                          "Median Income" ="income",
                          "Cost" = "cost",
                          "Average Solar Insolation" = "insolation")),
            selectInput("year2", "Year:",
                        c("2009" = 2009,
                          "2010" = 2010,
                          "2011" = 2011,
                          "2012" = 2012,
                          "2013" = 2013)),
            ##setup drop down menu for quarter
            selectInput("quarter2", "Quarter:",
                        c("1" = 'Winter',
                          "2" = 'Spring',
                          "3" = 'Summer',
                          "4" = 'Autumn'))
          ),
        mainPanel(
          fluidRow(
            plotOutput("linePlot")
          ))  
          
          
          

))) 

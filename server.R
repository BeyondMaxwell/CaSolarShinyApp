 
library(shiny)
library(ggplot2)
library(RColorBrewer)

load("shiny.RData") ###Load data from last post

shinyServer(function(input, output) {
  output$caPlot <- renderPlot({
    ## subset the data by year and quarter selected in the sidepanel for plotting
    PlotData = subset(installsByYearCountyQuarter, year == input$year & quarter == input$quarter)
    ## merge data with CA map
    CaPlotData = merge(CA,PlotData,all.x=TRUE,sort=FALSE, by="County")
    CaPlotData = CaPlotData[order(CaPlotData$sort),]
    ## Make sure color bar for actual and predicted plots have the same values so they can be compared
    minVal = min(c(na.omit(CaPlotData$Total.kW),na.omit(CaPlotData$predicted)))
    maxVal = max(c(na.omit(CaPlotData$Total.kW),na.omit(CaPlotData$predicted)))
    ##plot the data
    ggplot(CaPlotData ,aes(x = long, y = lat,group=group,fill=predicted)) +
      geom_polygon(colour = "black", size = 0.1) +  
      theme_bw(base_size = 16)+
      scale_fill_gradientn(name="Power (kW)",colours = brewer.pal(8,"Blues"),
                           limits=c(minVal,maxVal))+
      ggtitle(" Predicted Installed Power")+
      theme(axis.text.x = element_text( angle = 25,vjust=-0.1))+ 
      coord_fixed(ratio = 1)
  })
  
  output$caPlot2 <- renderPlot({
    PlotData = subset(installsByYearCountyQuarter, year == input$year & quarter == input$quarter)
    CaPlotData = merge(CA,PlotData,all.x=TRUE,sort=FALSE, by="County")
    CaPlotData = CaPlotData[order(CaPlotData$sort),]
    minVal = min(c(na.omit(CaPlotData$Total.kW),na.omit(CaPlotData$predicted)))
    maxVal = max(c(na.omit(CaPlotData$Total.kW),na.omit(CaPlotData$predicted)))
    ggplot(CaPlotData ,aes(x = long, y = lat,group=group,fill=Total.kW)) +
      geom_polygon(colour = "black", size = 0.1) +  
      theme_bw(base_size = 16)+
      scale_fill_gradientn(name="Power (kW)",colours = brewer.pal(8,"Blues"),
                            limits=c(minVal,maxVal))+
    
      ggtitle("Actual Installed Power")+
      theme(axis.text.x = element_text( angle = 25,vjust=-0.1))+ 
      coord_fixed(ratio = 1)
})

output$barPlot <- renderPlot({
  PlotData = subset(combdata, year == input$year & quarter == input$quarter)
  ggplot(PlotData ,aes(x=County,y=Total.kW,fill=type)) +
    geom_bar(colour="black", stat="identity",
             position=position_dodge(),
             size=.3)+
    theme( axis.text.x  = element_text(angle=75, vjust=0.6, size=12))+
    ylab("Installed kW/County by quarter")
})


output$linePlot <- renderPlot({
  PlotData = subset(combdata, year == input$year2 & quarter == input$quarter2)
  ggplot(PlotData ,aes_string(x=input$predictor2,y="Total.kW",col="type")) +
    geom_point(size=3)+
    ylab("Installed kW/County in Specified Quarter")
})


})
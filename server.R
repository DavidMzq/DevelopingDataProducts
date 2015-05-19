library(shiny)
library(datasets)
library(ggplot2)
shinyServer(
#datafile<-input$df
#XVariable<-input$XVariable
#x<-datafile$XVariable

  function(input, output,session) {
  output$currentTime <- renderText({
    invalidateLater(1000, session)
    paste("Current time : ", Sys.time())
  })
  
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$df,
           "mtcars" = mtcars,
           "airquality" = airquality)
  })
    # Generate a structure of the dataset
  output$structure <- renderPrint({
   if(input$radio==1)
   {
    str(datasetInput())
    }
   if(input$radio==2)
    {
    summary(datasetInput())
    }
    
  })
  
  # Show the first "n" observations
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })

  output$selectXUI <- renderUI({ 
	selectInput("XVariable", "Choose X axis Variable", choices =names(datasetInput()), selected = names(datasetInput())[1])})
  output$selectYUI <- renderUI({ 
	selectInput("YVariable", "Choose Y axis Variable", choices =names(datasetInput()), selected = names(datasetInput())[2])})

# Plot function

ButtonPlot <- eventReactive(input$butPlot, {
    x<-datasetInput()[[input$XVariable]]
    y<-datasetInput()[[input$YVariable]]
    if(input$plotType=="X-Y Relationship")
    {
      if(!is.null(x))
      {
       # draw the plot with the x and y variables 
       print(qplot(x,y,data=datasetInput(),geom=c("point","smooth"),xlab =input$XVariable , ylab =input$YVariable, main=paste(input$XVariable,"-",input$YVariable, "Relationship of Data:",input$df),method="lm"))
      }
    }
	if(input$plotType=="Histogram")
    {
      if(!is.null(x) & !is.na(min(x)) & !is.na(max(x)))
      {
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'skyblue', border = 'white',xlab=input$XVariable,main=paste("Histogram of",input$XVariable))
      output$NAexist<-renderText("")
      }
      else
      {
      output$NAexist<-renderText("There are NAs in this column! No Plot")
      }
    }
}) #ButtonPlot

   	output$disPlot <- renderPlot({
		ButtonPlot() 
    }) 
})
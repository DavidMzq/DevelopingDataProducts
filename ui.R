library(shiny)
shinyUI(fluidPage(
   textOutput("currentTime"),	
  # Application title
  titlePanel(h3(strong("Data Inside - Shiny Application") , align = "center")),
  headerPanel(h4("Items and Settings:",style = "color:green")),
 
  sidebarPanel(
      selectInput("df", label = "Choose Dataset", 
        choices = list("mtcars" , "airquality"), selected = "mtcars"),
     
     radioButtons("radio", label = "Choose Structure or Summary", 
    		choices = list("Structure" = 1, "Summary" = 2),
    		selected = 1),
    
     sliderInput("obs", "Range of observations to view:",
                  min = 1,
                  max = 100,
                  value = 6),
      
      htmlOutput("selectXUI"),    
      htmlOutput("selectYUI"),             
      
      sliderInput("bins",
                  "Number of bins for Histogram:",
                  min = 1,
                  max = 50,
                  value = 30),
                  
      selectInput("plotType", label = "Choose Plot Type", 
        choices = list("Histogram" , "X-Y Relationship"), selected = "Histogram"),    
      
      actionButton("butPlot", "Plot it!"),
      br(),
      br(),
         
      img(src="bigorb.png",height = 32, width = 32),
      "via Shiny and",
      span("Rstudio, ",style = "color:blue" ),
      "copyright free, May 2015",
	 helpText(  a("How to use this App", href="https://davidmzq.shinyapps.io/Assignment/HowToUseApp.html"))
),
  mainPanel(
  	h5(strong("Dataset and View")),
   	verbatimTextOutput("structure"),
   	tableOutput("view"),
   	textOutput('NAexist'),
   	plotOutput("disPlot")
  )
))
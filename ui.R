library(shiny)

shinyUI(pageWithSidebar(
    
    #title
    headerPanel("US Baby Names"),
  
    #input
    sidebarPanel
    (
        helpText("This application explores the popularity of baby names provided by the ", 
                 a("Social Security Administration.", href = "http://www.ssa.gov/OACT/babynames/")),             
        br(),

        helpText("Up to eight (8) names can be plotted at once, and must be separated by commas (i.e., Mary, Michael, Anne). 
                Sex can either be male, female, or both (resulting in two separate plots),
                and the date can range from 1880 to 2008."),
        br(),
    
        helpText("When you change your search criteria, 
                 click the", strong("\"Update\""), "button."),
        br(),
        
        h3("Select Options"),
      
        br(),
      
        textInput("name", value = "Julia", label = h4("Name(s)")), 
      
        br(),
      
        checkboxGroupInput("sex", 
                        label = h4("Sex"), 
                        choices = list("Male" = "boy", "Female" = "girl"),
                        selected = "girl"),
      
        br(),
      
        dateRangeInput("yearRange", 
                    label = h4("Year range"), 
                    start = "1880-01-01", end = "2008-01-01", min = "1880-01-01", max = "2008-01-01", format = "yyyy",
                    startview = "decade",
                    separator = " to "),
        br(),
        
        selectInput("plot.type", 
                    label = h4("Plot Type"),
                    choices = list(areaplot = "areaplot", boxplot = "boxplot", lineplot = "lineplot"), 
                    selected = "areaplot"),
        
        br(),
      
        submitButton("Update"),
        
        br(),
        
        p(a('Source Code on GitHub', href = "https://github.com/tshingel/BabyNamesShiny"))
    ),
    
    #output
    mainPanel
    (
        h2("Graphical Analysis of Name Trends"),
        plotOutput("plot", width = "900px", height = "500px")
    )              
    
))

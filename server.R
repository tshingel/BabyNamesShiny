library(shiny)

shinyServer(
    function(input, output) {
    
    output$plot <- renderPlot({ 
      p <- plotNames(input$name, input$sex, format(input$yearRange[1], "%Y"), format(input$yearRange[2], "%Y"), input$plot.type)
            
      validate(
        need(p != "empty", "I'm sorry, no names that you entered appear in this dataset. This means that all of them appear
             less than five times per year for whatever sex you indicated.")
        )
      p     
    })
    
  }
)
server <- function(input, output) {
  
  buildPlot <- eventReactive(input$go, {
    compare_inhabitants(input$municipality1,input$municipality2)
  })
  
  output$plot <- renderPlot({
    buildPlot()
  })
  
}
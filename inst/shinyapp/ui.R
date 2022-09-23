ui <- fluidPage(
  
  # App title ----
  titlePanel("Compare inhabitants of 2 swedish municipalities!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      textInput("municipality1","Municipality 1"),
      textInput("municipality2","Municipality 2"),
      actionButton("go","Go")
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "plot")
      
    )
  )
)
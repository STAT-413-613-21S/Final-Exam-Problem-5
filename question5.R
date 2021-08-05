library(shiny)
library(tidyverse)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Zachary Lessner", style = "color:blue"),
  h3("FINAL EXAM Shiny App Iris Data",
     style = "color:red"),
  setBackgroundColor("yellow"),
  selectInput("vars", "Iris variables", choices = names(iris)),
  
  mainPanel(
    plotOutput(outputId = "Histogramplotvar1"),
    plotOutput(outputId = "Boxplotvar1"),
    verbatimTextOutput("summary")
  )
)

server <- function(input, output, session) {
  
  output$Histogramplotvar1 <- renderPlot({
    ggplot(iris, aes(x = .data[[input$vars]])) +
      geom_histogram(color = "red", fill = "blue")
  })
  
  output$Boxplotvar1 <- renderPlot({
    ggplot(iris, aes(x=.data[[input$vars]])) + 
      geom_boxplot(color = "blue", fill = "red") +
      ggtitle("boxplot")
  })
  
  
  output$summary <- renderPrint({
    summary(iris)
  })

  
  session$onSessionEnded({
    print("Stop!")
    stopApp  
  }) 


}


shinyApp(ui = ui, server = server) 



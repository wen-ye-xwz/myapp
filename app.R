library(shiny)
library(tidyverse)
library(ggplot2)


cs = read_csv("computer_science.csv")
engineer = read_csv("humanities.csv")
bus = read_csv("business.csv")
arts = read_csv("arts.csv")
hum = read_csv("humanities.csv")
edu = read_csv("education.csv")

ui <- fluidPage(
  
  titlePanel("Relationship between Early and Mid Career Salary by Major"),
  
  sidebarPanel(
  
    selectInput(inputId = "select", 
                label = h3("Choose a Major Category"), 
                choices = c("Computer Science" = "cs", "Engineering" = "engineer", 
                               "Business" = "bus", "Arts" = "arts", "Humanities" = "hum", "Education" = "edu"), 
                selected = "Computer Science"),
    #hr(),
    #fluidRow(column(6, verbatimTextOutput("value")))

  ),
  
  
  mainPanel(
    
    plotOutput(outputId = "Plot")
    
  )
)

server <- function(input, output) {
  
  #output$value <- renderPrint({ input$select })
  
  output$Plot <- renderPlot({
    data_name = input$select
    data = get(data_name)
    #print(data)
    data %>% ggplot()+
      geom_point(aes(x = early_pay,y = mid_pay,color = Rank, size = 2.5))+
      xlab("Early Career Salary")+
      ylab("Mid Career Salary")+ 
      theme(axis.text.x = element_text(size=13),
            axis.text.y = element_text(size=13),
            axis.title = element_text(size = 20))
    
  },height = 550, width = 900)
  

}

shinyApp(ui = ui, server = server)
library(shiny)
library(tidyverse)
library(bslib)

cars <- mtcars
cars <- cars %>% 
  tibble::rownames_to_column("cars")

ui <- fluidPage(
  theme = bs_theme(bootswatch = "united"),
  titlePanel("OK Broomer"),
    tabsetPanel(
      tabPanel(
        titlePanel("Miles per Gallon"),
               sidebarLayout(
                 sidebarPanel(
                   tags$audio(tags$audio(
                     src = "ignition.wav", type = "audio/wav", autoplay = TRUE, controls = TRUE)),
                   radioButtons("cylinder",
                                "Select Cylinders",
                                c(4, 6, 8)
                   )
                 ),
                 mainPanel(
                   plotOutput("car_plot"),
                 )
               )
        
      ),
      tabPanel(
        fluidRow(
          titlePanel("Quarter Mile Time")
        ),
        fluidRow(
          plotOutput("car_plot2")
        )
      )
    )
)


server <- function(input, output, session) {
  output$car_plot <- renderPlot(
    cars %>% 
      filter(cyl == input$cylinder) %>% 
      ggplot(aes(x = hp, y = mpg)) +
      geom_point() +
      labs(title = "Horsepower vs MPG", x = "Horsepower", y = "MPG") +
      theme_light() +
      theme(text = element_text(size = 15))
  )
  output$car_plot2 <- renderPlot(
    cars %>% 
      ggplot(aes(x = hp, y = qsec)) +
      geom_point() +
      geom_smooth() +
      labs(title = "Horsepower vs quarter mile time", x = "Horsepower", y = "qsec") +
      theme_light() +
      theme(text = element_text(size = 15))
  )
}

shinyApp(ui, server)
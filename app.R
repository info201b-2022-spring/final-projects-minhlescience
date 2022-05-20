# MINH TRUNG LE

library(shiny)
library(dplyr)
library(ggplot2)

fires_2012_2015_df <- read.csv("data/Fires_2012_2015.csv")

# Group by state and year
group_state <- group_by(fire_2012_2015_df, STATE, FIRE_YEAR)

# count number of case by state and year
fire_by_state <- summarize(group_state, number_of_fire= n())

# Define UI for application
ui <- fluidPage(
  selectInput (
    inputId = 'year',
    label = 'Select a year for TOP 10 wild fires in each year',
    choices = fire_by_state$FIRE_YEAR,
    selected = TRUE
  ),
  tableOutput(outputId = 'table'),
  plotOutput(outputId = 'radar')
)

# Define server logic
server <- function(input, output) {
  
  make_bar_df <- function(year){
    data_year <- filter(fire_by_state, FIRE_YEAR == year)
    max_fire_data <- arrange(data_year, desc(number_of_fire))
      
    table_fire <- select(max_fire_data, STATE, number_of_fire)
    table_fire <- table_fire[1:10,]
    return(table_fire)
  }
  
  output$table <- renderTable({
    return(make_bar_df(input$year))
  })
  
  output$radar <- renderPlot({
    ggplot(make_bar_df(input$year), aes(x=STATE, y=number_of_fire)) + 
      geom_bar(stat = "identity")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)


# title: "Wildfire project App"
# author: "Group BB4 - Jeffrey Lan, Minh Trung Le, Wencheng Zhang, Yiding Zhang"
# date: "05/31/2022"

# Load libraries  
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

#load in data
source('./summary_information.R')
source('./chart1.R')
source('./chart2.R')
source('./chart3.R')

# Get state name
state_name <- sort(unique(fires$State))

# Get cause name
cause_name <- sort(unique(fires$StatCause))

# Get size class name
size_name <- sort(unique(fires$FireSizeClass))

# Define the first page content; uses `tabPanel()` and `sidebarLayout()`
intro_page <- tabPanel(
  "Introductory Page", # label for the tab in the navbar
  titlePanel("Introduction"), # show with a displayed title
  
  # An introductory page providing an overview of the project -- 
  # what major questions are you seeking to answer, 
  # and what data will you use to answer those questions? 
  # You should include some "additional flare" on this landing page, such as an image.
  h4("Question 1: Which three states has the most fire count in 2015?"),
  p("To answer this question, we use data fires, filter it to only 2015's data, group it by states and count the number of fires each year"),
  p("THen sort the data descendingly and check the first three states we got."),
  br(),
  h4("Question 2: Which state in the top 5 states with most fire count during 1992-2015 has the most grown from 2004-2011?"),
  p("To answer this question, we use data fires and count the number of fires each year."),
  p("Then achieve a progression visualization with the data we got."),
  br(),
  h4("Question 3: Three most common reason causing fire?"),
  p("To answer this question, we use data fires and count the number of fire cause."),
  p("Then we sort the data descendingly and check the first three causes we got.")
  )


# Chart 1 for Fire count by state over years
chart_1 <- tabPanel(
  "Chart 1", # label for the tab in the navbar
  titlePanel("Fire Count by State"), # show with a displayed title
  sidebarLayout(
    sidebarPanel(
      h5("State"),
      selectInput(inputId = "state", label = h3("Select state"), 
                  choices = state_name),
    ),
    mainPanel(
      #plotOutput(outputId = "scatter", click = "plot_click"),
      plotOutput(outputId = "chart1", brush = "plot_brush"),
      tableOutput(outputId = "data1")
    )
  )
)


# Chart 2 for Fire Size Class over years
chart_2 <- tabPanel(
  "Chart 2", # label for the tab in the navbar
  titlePanel("Fire Count by Size Class"), # show with a displayed title
  sidebarLayout(
    sidebarPanel(
      h5("Size"),
      selectInput(inputId = "size", label = h3("Select size"), 
                  choices = size_name),
    ),
    mainPanel(
      #plotOutput(outputId = "scatter", click = "plot_click"),
      plotOutput(outputId = "chart2", brush = "plot_brush"),
      tableOutput(outputId = "data2")
    )
  )
)

# Chart 3 for Fire Cause over years
chart_3 <- tabPanel(
  "Chart 3", # label for the tab in the navbar
  titlePanel("Fire Count by Cause"), # show with a displayed title
  sidebarLayout(
    sidebarPanel(
      h5("Cause"),
      selectInput(inputId = "cause", label = h3("Select cause"), 
                  choices = cause_name),
    ),
    mainPanel(
      #plotOutput(outputId = "scatter", click = "plot_click"),
      plotOutput(outputId = "chart3", brush = "plot_brush"),
      tableOutput(outputId = "data3")
    )
  )
)

# Define content for the fourth page
summary_page <- tabPanel(
  "Summary", # label for the tab in the navbar
  titlePanel("Summary"), # show with a displayed title
  # Summary takeaways, 
  # a page that hones in on at least 3 major takeaways from the project 
  # (which should be related to a specific aspect of your analysis). 
  # Feel free to incorporate tables, graphics, or other elements to convey these conclusions.
  h4("Takeaway1"),
  p("California, Georgia, and Taxes are the three state with most fire count from 1992-2015."),
  br(),
  h4("Takeaway2"),
  p("Taxes is the state with most growth in fire count from 2004-2011 comparing to other states in the top-5 staes with most fire count across 1992-2015."),
  br(),
  h4("Takeaway3"),
  p("Debris is the main cause of wildfires in the US. It is always high in every year."),
)

# Pass each page to a multi-page layout (`navbarPage`)
ui <- navbarPage(
  "Wildfire project", # Project title
  intro_page,         # include the introduction page
  chart_1,            # include the chart 1 page
  chart_2,            # include the chart 2 page
  chart_3,            # include the chart 3 page
  summary_page        # include the summary page
)

#Server logic goes here
server <- function(input, output){
  
  # Output chart for Tab chart 1 Fire by State
  output$chart1 <- renderPlot({
    state_over_years <- fires %>%
      group_by(State, FireYear) %>%
      count() %>%
      rename(Count = n) %>%
      filter(State == input$state)
    
    ggplot(data = state_over_years, 
           aes(x=FireYear, y=Count, color=State)) +
      geom_line() +
      geom_point() +
      ggtitle("Progression of the Fire count in selected state During 1992-2015") +
      xlab('Year') +
      ylab('Fire Count')
  })
  
  # Output chart for Tab chart 2 Fire by Size Class
  output$chart2 <- renderPlot({
    size_over_years <- fires %>%
      group_by(FireSizeClass, FireYear) %>%
      count() %>%
      rename(Count = n) %>%
      filter(FireSizeClass == input$size)
    
    ggplot(data = size_over_years, 
           aes(x=FireYear, y=Count, color=FireSizeClass)) +
      geom_line() +
      geom_point() +
      ggtitle("Progression of the Fire count with selected size class During 1992-2015") +
      xlab('Year') +
      ylab('Fire Count')
  })
  
  # Output chart for Tab chart 3 Fire by Cause
  output$chart3 <- renderPlot({
    cause_over_years <- fires %>%
      group_by(StatCause, FireYear) %>%
      count() %>%
      rename(Count = n) %>%
      filter(StatCause == input$cause)
    
    ggplot(data = cause_over_years, 
           aes(x=FireYear, y=Count, color=StatCause)) +
      geom_line() +
      geom_point() +
      ggtitle("Progression of the Fire count with selected cause During 1992-2015") +
      xlab('Year') +
      ylab('Fire Count')
  })
  
}

#this is the function that makes the shiny app
shinyApp(ui = ui, server = server)

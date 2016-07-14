# project for Data Products course
# Shiny app, requires files ui.R, server.R, and FMA_articulations.csv

library(shiny)
shinyUI(fluidPage(
  titlePanel("Articulations of the human body"),
  sidebarLayout(
    sidebarPanel(
    uiOutput("variables"),  
    submitButton("Submit")
  ),
  mainPanel(
    dataTableOutput("mytable")
  )
  )
))


# project for Data Products course
# Shiny app, requires files ui.R, server.R, and FMA_articulations.csv

library(shiny)
artData <- read.csv("FMA_articulations.csv")

shinyServer(function(input, output) {

  skeletalRegions <- unique(artData$region)
  
  getAllSubjects <- function(selectedRegion) {
    df <- artData[(artData$region == selectedRegion), "labelSubject"]
    as.character(unique(df))
  }
  
  getArticulations <- function(subject){
    artData[(artData$labelSubject == subject), "labelObject"]
  }
  
  newDataFrame <- function(selectedRegion){
    sub <- getAllSubjects(selectedRegion)
    listOutput <- sapply(sub, getArticulations)
    articulations <- sapply(as.vector(listOutput), paste, collapse=", ")
    df <- data.frame(as.character(sub), as.character(articulations))
    colnames(df) <- c("Bone or cartilage", "Articulates with this bone or cartilage...")
    df
  }
  
  selectionInput <- reactive({
    switch(input$region, as.character(skeletalRegions))
  })
  
  output$mytable = renderDataTable({newDataFrame(input$region) },
    options = list(
      autoWidth = TRUE,
      columnDefs = list(list(width = '30%', targets = 0))
    ) 
  )
  
  output$variables <- renderUI({
    selectInput("region","Select region of skeleton and press Submit", choices = as.character(skeletalRegions))
  })
})


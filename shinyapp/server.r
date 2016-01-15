library(shiny)
source('prediction.R')
load('profezia.RData')


shinyServer(function(input, output) {
    
    
    final.prediction <- reactive({
        
        if(input$smooth == 1){
            pr <- prediction.kn(w1, w2, w3, d, input$words, input$radio)
        }else{
            pr <- prediction.sb(w1, w2, w3, input$words, input$radio)
        }
        ifelse(input$radio==3, paste(pr[1], "---", pr[2], "---", pr[3]),
               ifelse(input$radio==2, paste(pr[1], "---", pr[2]), pr[1])
        )
        
    })
    
    output$text <- renderText({
        final.prediction()
    })
    
})
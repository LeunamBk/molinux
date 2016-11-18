#!/usr/bin/Rscript

# clean workspace
rm(list=ls())

# read sources and libraries
source(paste(getwd(), '/functions/app.R', sep=''))

ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      #box(plotOutput("plot1", height = 250)),
      actionButton("tableSwitch", "Table data all"),
      dataTableOutput('table')
      
    ),
    fluidRow(
      box(plotOutput("redGermany", height = 350)),
      box(plotOutput("redBavaria", height = 350))
      #box(column(12,
      #       dataTableOutput('table')
      #))
      
      
      #box(
        #title = "Controls",
        #sliderInput("slider", "Number of observations:", 1, 100, 50)
      #)
    )
  )
)


server <- function(input, output, session) {
  
  observeEvent(input$tableSwitch, {
    session$sendCustomMessage(type = 'testmessage',
                              message = 'Thank you for clicking')
    
    output$table <- renderDataTable(moliAll(),
                                    options = list(
                                      pageLength = 15))
    })
  
  output$table <- renderDataTable(moliGteOne()[,c('Taxa', 'Percent', 'taxa', 'percent')],
                                  options = list(
                                    pageLength = 10))
  
  output$redGermany <- renderPlot({# Simple Pie Chart
      data <- withNALabel(molusInfoOnCol(rote_Liste_Deutschland))
      slices <- unlist(data['count'])
      lbls <- unlist(data['rld1'])
      par(mar=c(1,0,1,0))
      pie(slices, labels = lbls, main="Rote Liste Deutschland")
  })
  
  output$redBavaria <- renderPlot({# Simple Pie Chart
      data <- withNALabel(molusInfoOnCol(rote_Liste_Bayern))
      slices <- unlist(data['count'])
      lbls <- unlist(data['rl_by'])
      cols <- c("grey90","grey50","black","grey30","white","grey70","grey50","grey10")
      percentlabels<- round(100*slices/sum(slices), 1)
      pielabels<- paste(percentlabels, "%", sep="")
      par(mar=c(1,0,1,0))
      pie(slices, main="Rote Liste Bayern", col=cols, labels=pielabels, cex=0.8)
      legend("bottomright", lbls, cex=0.8, fill=cols)
      
  })

}

shinyApp(ui, server)
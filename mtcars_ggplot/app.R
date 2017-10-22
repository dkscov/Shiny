#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
data(mtcars)
# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Cars dataset mpg"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("mpgfactor",
                  "Factor:",
                  choices=colnames(mtcars)[which(colnames(mtcars)!="mpg" & colnames(mtcars)!="cyl")])
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("mpgPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$mpgPlot <- renderPlot({
    # generate y based on input$factor from ui.R
    x<-input$mpgfactor
    # draw the histogram with the specified number of bins
    #plot(mtcars[,x],mtcars[,"mpg"],ylab="mpg",xlab=y,main=y)
    data.mtcars.shiny<-as.data.frame(cbind(mtcars[,input$mpgfactor],mtcars[,c("cyl","mpg")]))
    colnames(data.mtcars.shiny)<-c("mpgfactor","cyl","mpg")
    ggplot(data.mtcars.shiny,aes(x=mpgfactor,y=mpg,fill=factor(cyl)))+geom_point(size=5,shape=21)+xlab(input$mpgfactor)+theme(axis.text=element_text(size=14,face="bold"),axis.title=element_text(size=14,face="bold"),legend.title =element_text(size=14,face="bold"),legend.text =element_text(size=14,face="bold"))+scale_fill_discrete("cyl")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

library(shiny)
library(ggplot2)
DrivingDurations <- read.csv(file="~/ShinyApps/map/DrivingDurations.csv")
npa <- read.csv(file="~/ShinyApps/map/npa_transpose.csv")

neighborhoodList <- levels(as.factor(DrivingDurations$Neighborhood))

shinyUI(
  navbarPage("ICMA",
  tabPanel("Intro",
  h3("CharNest - Charlotte Nesting: Figuring out where to live",style = "color:darkblue"),
  br(),
  h4("Charlotte is one of the fastest growing cities"),
  tags$a(href="http://money.cnn.com/gallery/real_estate/2014/03/27/fastest-growing-cities/8.html", "CNN 10 fastest growing cities - #8 Charlotte"),
  br(),
  tags$a(href="http://www.forbes.com/pictures/edgl45emig/no-5-charlotte-nc-sc-2/", "Forbes Charlotte grew 1.7pct since 2011"),
  br(),br(),
  h4("Projected Population Growth for Charlotte 2014-2019"),
  includeHTML("~/ShinyApps/map/iframe/popgrowth.html")
           ),
  tabPanel("Neighborhood Comparison",
           fluidPage(       
                  fluidRow(
                    column(6, tags$h3("Neighborhood A")),
                    column(6, offset = 0.5, tags$h3("Neighborhood B"))
                  ),
                  fluidRow(
                    column(6, selectInput("mapchoiceLeft", 'Options', neighborhoodList, selectize=TRUE)),
                    column(6, offset = 0.5, selectInput("mapchoiceRight", 'Options', neighborhoodList, selectize=TRUE))
                  ),
                  fluidRow(
                    column(6,
                           #includeHTML("mapiframe.html")
                           #includeHTML(textOutput("mapChosenLeft"))
                           uiOutput("displayMapLeft")
                    ),
                    column(6, offset = 0.5,
                           uiOutput("displayMapRight")
                           #includeHTML("mapiframe_2.html")
                    )
                  )
                  ,
                  fluidRow(
                    column(6,
                           tags$h4("Driving Time"),
                           plotOutput("drivingDurationPlotLeft")
                    ),
                    column(6, offset = 0.5,
                           tags$h4("Driving Time"),
                           plotOutput("drivingDurationPlotRight")
                    )
                  )
                  )
  ),
  tabPanel("Driving Times",
           h4("Driving Times with Traffic"),
           plotOutput("drivingDurationPlot",width = "65%")
  ),
  tabPanel("NPA Plot",
           h4("Neighborhood Profile Area Plots"),
           selectInput("npaChoice", 'Options', npa$X, selectize=TRUE),
           plotOutput("npaPlot",width = "65%")
  ),
 
    tabPanel("NPA Explorer",
                    h4("Explore the Neigborhood Profile Area data:"),
                    br(),
                    tags$a(href="http://maps.co.mecklenburg.nc.us/qoldashboard/data/metadata.html", "Metadata link"),
                    br(),
                    dataTableOutput("npaTable")
           ),
    tabPanel("Debug",
             h6("debug: text"),
             textOutput("debug"),
             h6("debug: table"),
             tableOutput("dfprint")
           )
  )
  )

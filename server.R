library(shiny)
library(ggplot2)

npa <- read.csv(file="~/ShinyApps/map/npa_transpose.csv")

shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    
    dist <- rnorm(input$obs)
    hist(dist)
  })
  
  drivingDataLeft <- reactive({
    subset(DrivingDurations,Neighborhood==input$mapchoiceLeft)
  })
  drivingDataRight <- reactive({
    subset(DrivingDurations,Neighborhood==input$mapchoiceRight)
  })
  
  choosenMapLeft <- reactive({
    choice <- input$mapchoiceLeft
    if(choice == "Sharon Rd (South Park)") {
      mapPath <- "~/ShinyApps/map/iframe/sharonrd.html"  
    } else if (choice == "Ballantyne (South)"){
      mapPath <- "~/ShinyApps/map/iframe/ballantyne.html"
    } else if (choice == "Arboretum"){
      mapPath <- "~/ShinyApps/map/iframe/arboretum.html"
    } else if (choice == "Beckett (Huntersville)"){
      mapPath <- "~/ShinyApps/map/iframe/beckett.html"
    } else if (choice == "Park South Station (South Park)"){
      mapPath <- "~/ShinyApps/map/iframe/parksouthstation.html"
    } else if (choice == "Sardis Woods"){
      mapPath <- "~/ShinyApps/map/iframe/sardis.html"
    } else if (choice == "Shepards Vineyard (Huntersville)"){
      mapPath <- "~/ShinyApps/map/iframe/shepardsvineyard.html"
    } else if (choice == "McCollough (Pineville)"){
      mapPath <- "~/ShinyApps/map/iframe/pineville.html"
    } else if (choice == "Perservation Pointe (Mountain Island)"){
      mapPath <- "~/ShinyApps/map/iframe/prespoint.html"
    } else if (choice == "Vermillion (Huntersville)"){
      mapPath <- "~/ShinyApps/map/iframe/vermillion.html"
    } else {
      mapPath <- "mapiframe.html"  
    }
    return(mapPath)
  })
  
  choosenMapRight <- reactive({
    choice <- input$mapchoiceRight
    if(choice == "Sharon Rd (South Park)") {
      mapPath <- "~/ShinyApps/map/iframe/sharonrd.html"  
    } else if (choice == "Ballantyne (South)"){
      mapPath <- "~/ShinyApps/map/iframe/ballantyne.html"
    } else if (choice == "Arboretum"){
      mapPath <- "~/ShinyApps/map/iframe/arboretum.html"
    } else if (choice == "Beckett (Huntersville)"){
      mapPath <- "~/ShinyApps/map/iframe/beckett.html"
    } else if (choice == "Park South Station (South Park)"){
      mapPath <- "~/ShinyApps/map/iframe/parksouthstation.html"
    } else if (choice == "Sardis Woods"){
      mapPath <- "~/ShinyApps/map/iframe/sardis.html"
    } else if (choice == "Shepards Vineyard (Huntersville)"){
      mapPath <- "~/ShinyApps/map/iframe/shepardsvineyard.html"
    } else if (choice == "McCollough (Pineville)"){
      mapPath <- "~/ShinyApps/map/iframe/pineville.html"
    } else if (choice == "Perservation Pointe (Mountain Island)"){
      mapPath <- "~/ShinyApps/map/iframe/prespoint.html"
    } else if (choice == "Vermillion (Huntersville)"){
      mapPath <- "~/ShinyApps/map/iframe/vermillion.html"
    } else {
      mapPath <- "mapiframe.html"  
    }
    return(mapPath)
  })
  
  
  #output$mapChosenLeft <- renderText({
  #  print(choosenMapLeft())
  #})
  
  output$displayMapLeft <- renderUI({
    includeHTML(choosenMapLeft())
  })
  
  output$displayMapRight <- renderUI({
    includeHTML(choosenMapRight())
  })
  
  output$drivingDurationPlotLeft <- renderPlot({
    testdf <- drivingDataLeft()
    
    custom_label <- unique(testdf$HourMinEST)
    custom_label <- sort(custom_label)
    custom_label_df <- data.frame(custom_label,"num"=1:length(custom_label))
    custom_label_df$indicator <-  ifelse( ((custom_label_df$num-1) %% 8) == 0,1,0)
    custom_label_chart <- subset(custom_label_df,indicator==1)$custom_label
    
    
    g <- ggplot(data=testdf, aes(x=HourMinEST,y=DurationMin,color=Weekend)) 
    g <- g + geom_point(aes(size = 8),alpha = .3,)
    #g <- g + facet_wrap( ~ Neighborhood, ncol=2)
    g <- g + theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank())
    g <- g + geom_vline(aes(xintercept = 18)) #9 am
    g <- g + geom_vline(aes(xintercept = 49)) #5 pm
    g <- g + scale_x_discrete(breaks = custom_label_chart)
    g <- g + ylab("Driving Time (minutes)") + xlab("")
    g <- g + theme(legend.position="none")
    g <- g + theme(panel.grid.major = element_line(colour = "lightblue"))
    g <- g + theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank())
    print(g)
  })
  
  output$drivingDurationPlotRight <- renderPlot({
    testdf <- drivingDataRight()
    
    custom_label <- unique(testdf$HourMinEST)
    custom_label <- sort(custom_label)
    custom_label_df <- data.frame(custom_label,"num"=1:length(custom_label))
    custom_label_df$indicator <-  ifelse( ((custom_label_df$num-1) %% 8) == 0,1,0)
    custom_label_chart <- subset(custom_label_df,indicator==1)$custom_label
    
    
    g <- ggplot(data=testdf, aes(x=HourMinEST,y=DurationMin,color=Weekend)) 
    g <- g + geom_point(aes(size = 8),alpha = .3,)
    #g <- g + facet_wrap( ~ Neighborhood, ncol=2)
    g <- g + theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank())
    g <- g + geom_vline(aes(xintercept = 18)) #9 am
    g <- g + geom_vline(aes(xintercept = 49)) #5 pm
    g <- g + scale_x_discrete(breaks = custom_label_chart)
    g <- g + ylab("Driving Time (minutes)") + xlab("")
    g <- g + theme(legend.position="none")
    g <- g + theme(panel.grid.major = element_line(colour = "lightblue"))
    g <- g + theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank())
    print(g)
  })
  
  output$drivingDurationPlot <- renderPlot({
    testdf <- DrivingDurations
    
    custom_label <- unique(testdf$HourMinEST)
    custom_label <- sort(custom_label)
    custom_label_df <- data.frame(custom_label,"num"=1:length(custom_label))
    custom_label_df$indicator <-  ifelse( ((custom_label_df$num-1) %% 8) == 0,1,0)
    custom_label_chart <- subset(custom_label_df,indicator==1)$custom_label
    
    
    g <- ggplot(data=testdf, aes(x=HourMinEST,y=DurationMin,color=Weekend)) 
    g <- g + geom_point(aes(size = 8),alpha = .3,)
    g <- g + facet_wrap( ~ Neighborhood, ncol=2)
    g <- g + theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank())
    g <- g + geom_vline(aes(xintercept = 18)) #9 am
    g <- g + geom_vline(aes(xintercept = 49)) #5 pm
    g <- g + scale_x_discrete(breaks = custom_label_chart)
    g <- g + ylab("Driving Time (minutes)") + xlab("")
    g <- g + theme(legend.position="none")
    g <- g + theme(panel.grid.major = element_line(colour = "lightblue"))
    g <- g + theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank())
    print(g)
  })
  
  output$npaPlot <- renderPlot({
  npatemp <- npa
  npatemp <- subset(npatemp,X==input$npaChoice)
  #npatemp <- subset(npatemp,X=="drive_alone")
  trans_npa <- as.data.frame(t(npatemp))
  label_for_axis <- trans_npa[1,]
  trans_npa_plot <- trans_npa[-1,]
  trans_npa_plot_df <- data.frame("Metric"=trans_npa_plot,"Neighborhood"=names(trans_npa_plot))
  
  g1 <- ggplot(trans_npa_plot_df, aes(Neighborhood,Metric),stat="identity") 
  g1 <- g1 + geom_bar()
  g1 <- g1 + coord_flip()
  g1 <- g1 + xlab("") + ylab(label_for_axis)
  print(g1)
})
  
  output$npaTable = renderDataTable({
    npa
  })
  
  
  output$debug <- renderText({
    print(choosenMapLeft())
    #print(paste("The cluster value is: ",input$cluster," with class ", class(input$cluster),sep=""))
  })
  
  # Debugging Output: data table
  output$dfprint <- renderTable({
    #df <- sqldf(paste("select * from top10feeders  where HighSchool in ('",thechoice()$longname,"')",sep=""))
    df <- drivingDataLeft()
    head(df)
  })
  
})



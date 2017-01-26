
# 
#

library(shiny)

shinyServer(function(input, output) {

    output$pcap.table = DT::renderDataTable(traffic.all[,input$show_fields, drop=FALSE],
                                            extensions = list("Scroller",
                                                              "ColReorder"),
                                            options = list(
                                                class='cell-border',
                                                lengthMenu = c(10, 15, 25, 50, 100),
                                                scrollX = TRUE
                                                #fixedColumns = list(leftColumns = 1)
                                               
                                               )
                                            )
    
  
})

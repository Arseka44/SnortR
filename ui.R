
#
#
# 

library(shiny)
library(shinydashboard)

dashboardPage( skin = "red",
    dashboardHeader(title = "SnortR"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Non signature-based", tabName = "non_signature",   icon = icon("eye-slash")),
            menuItem("Signature-based",           tabName = "signature", icon = icon("eye"))
        )
       
    ),
    dashboardBody(
        fluidRow(
            infoBox("TCP stream", 10 * 2, icon = icon("credit-card"), fill = TRUE),
            infoBox("Low TCP stream", 10 * 2, icon = icon("credit-card"), fill = TRUE),
            infoBox("Number of TCP stream", 10 * 2, icon = icon("credit-card"), fill = TRUE)
            
        ),
        tabItems(
            tabItem(
                tabName = "non_signature",
                h2("Non-signature tab content"),
                fluidRow(
                    box(
                        title = "Time ", width = 4, solidHeader = TRUE, status = "primary",
                        collapsible = TRUE,
                        "Box content"
                    ),
                    box(
                        title = "Title 2", width = 4, solidHeader = TRUE,
                        collapsible = TRUE,
                        "Box content"
                    ),
                    box(
                        title = "Title 1", width = 4, solidHeader = TRUE, status = "warning",
                        collapsible = TRUE,
                        "Box content"
                    )
                ),
                
                fluidRow(
                    box(
                        title = "Select fields for traffic tables", width = 12, solidHeader = TRUE, status = "primary",
                        collapsible = TRUE,
                        checkboxGroupInput(
                            "show_fields", 
                            "Select field`s of traffic:",
                            names(traffic.all),
                            selected= c("frame.protocols", "all$eth.dst", "eth.src", "ip.src", "ip.dst", "tcp.stream", "tcp.flags.syn",
                                        "X_ws.expert.message", "tcp.flags.fin"),
                            inline = TRUE
                        )
                    )
                
                ),
                
                
                fluidRow(
                   
                    tabBox(
                        title = tagList(shiny::icon("table"), "Traffic"),
                        width = 12, 
                        tabPanel("PCAP TRAFFIC TABLE", 
                                 DT::dataTableOutput('pcap.table')
                                                   ),
                        tabPanel("Snort", "Alerts from Snort")
                        
                    )
                    
                )
            ),
            tabItem(
                tabName = "signature",
                h2("Signature tab content")
            )
            
        )
    )
)

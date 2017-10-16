library(shinydashboard)
library(DT)
library(plotly)



shinyUI(dashboardPage(
        skin = "green",
        dashboardHeader(title = "Data Product"),
        dashboardSidebar(sidebarMenu(
                sliderInput("size", "Number of nodes",
                            min = 6,
                            max = 20,
                            value = 20),
                menuItem("Networks", tabName = "networks", icon = icon("dashboard")),
                menuItem("About", tabName = "about", icon = icon("th"))
        )),
        dashboardBody(
                tabItems(
                        tabItem(tabName = "networks",
                                tabsetPanel(type = "tabs",
                                            tabPanel("net", plotOutput("net")),
                                            tabPanel("Local", DT::dataTableOutput("local")),
                                            tabPanel("Global", DT::dataTableOutput("global")),
                                            tabPanel("Topology", plotlyOutput("topology")))
                        ),
                        tabItem(tabName = "about", h4("The purpose of this shiny app is to show 
                                                      how to generate a scale-free graph using  
                                                      only the number of nodes. 
                                                      The app has a slider to generate the graph
                                                      The app create a graph object: nodes and links. 
                                                      The first tab shows an interactive network.
                                                      The second tab shows a list of actors 
                                                      with the main network metrics: in degree, 
                                                      out degree, and betweenness.  The third one 
                                                      refers to the global metrics, such as density, 
                                                      transitivity, diameter, 
                                                      and centralization. Finally, topology's tab presents 
                                                      the log-log distribution. "))
                        )
                        )
                        ))
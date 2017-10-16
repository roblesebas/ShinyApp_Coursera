library(shiny)
library(plotly)
library(igraph)


names <- c("sebas", "Vivi", "Simon", "Pedro", "Pablo", "jorge", 
           "martin", "octavio", "jose", "eduardo", "jacobo",
           "Luisa", "valentina", "johana", "jesus", "jhon", 
           "ajay", "meredith", "fabian", "hans")

nodes.attributes <- data.frame(id = 1:20, names = names, 
                               stringsAsFactors = FALSE)

shinyServer(function(input, output) {
        
        output$net <- renderPlot({
                
                graph <- sample_pa(input$size)
                V(graph)$label <- names[1:input$size]
                plot.igraph(graph)
        })
        
        output$local <- DT::renderDataTable({
                
                
                graph <- sample_pa(input$size)
                network.local <- data.frame(
                        id = names[1:input$size],
                        degree = degree(graph, mode = "total"),
                        betweenness = betweenness(graph)
                )
                network.local
        })
        
        output$global <- DT::renderDataTable({
                
                graph <- sample_pa(input$size)
                global.network <- data.frame(Density = edge_density(graph, loops = FALSE),
                                             Transitivity = transitivity(graph, type = "global"),
                                             Diameter = diameter(graph, directed = TRUE,
                                                                 weights = NA),
                                             Centralization = centr_degree(graph,
                                                                           mode = "all")$centralization,
                                             stringsAsFactors = FALSE)
                global.network
                
        })
        
        output$topology <- renderPlotly({
                
                graph <- sample_pa(input$size)
                G <- graph
                
                G.degrees <- degree(G)
                
                G.degree.histogram <- as.data.frame(table(G.degrees))
                
                G.degree.histogram[,1] <- as.numeric(G.degree.histogram[,1])
                
                v <- ggplot(G.degree.histogram, aes(x = G.degrees, y = Freq)) +
                        geom_point() +
                        scale_x_continuous("Degree\n(nodes with this amount of connections)",
                                           breaks = c(1, 3, 10, 30, 100, 300),
                                           trans = "log10") +
                        scale_y_continuous("Frequency\n(how many of them)",
                                           breaks = c(1, 3, 10, 30, 100, 300, 1000),
                                           trans = "log10") +
                        ggtitle("Degree Distribution (log-log)") +
                        theme_bw()
                ggplotly(v)
        })
        
})

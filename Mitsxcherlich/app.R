library("shiny")

ui <- basicPage(
    sliderInput("A", "Asymptote:", min = 0, max = 100, value = 50),
    sliderInput("E", "Environnement:", min = -10, max = 100, value = 20),
    sliderInput("R", "Taux:", min = 0, max = 0.1, value = 0.035),
    sliderInput("prix_dose", "Prix dose:", min = 0, max = 5, value = 1),
    sliderInput("prix_vente", "Prix vente:", min = 0, max = 200, value = 100),
    sliderInput("dose", "Dose:", min = 0, max = 300, value = c(0, 200)),
    plotOutput("distPlot")
)

server <- function(input, output) {
    mitsch_f <- reactive({
        input$A * (1 - exp(-input$R * (seq(input$dose[1], input$dose[2], length = 100) + input$E)))
    })
    
    mitsch_opt <- reactive({
        (log((input$A * input$R * input$prix_vente) / input$prix_dose - input$E * input$R) / input$R )
    })
    
    
    output$distPlot <- renderPlot({
        plot(seq(input$dose[1], input$dose[2], length = 100), mitsch_f(), type = "l", ylim = c(0, 100))
        abline(v = mitsch_opt() )
        text(mitsch_opt(), 2, paste("Dose optimale:", round(mitsch_opt(), 0)))
    })
}

shinyApp(ui, server)
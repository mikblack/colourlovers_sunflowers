library(colourlovers)
library(rlist)
top=clpalettes('top')
sapply(1:length(top), function(x) list.extract(top, x)$title)->titles
 
fluidPage(
  titlePanel("Sunflowers for COLOURlovers"),
  fluidRow(
    column(3,
           wellPanel(
             selectInput("pal", label = "Palette:", choices = titles),
             sliderInput("nob", label = "Number of points:", min = 200, max = 500, value = 400, step = 50)
           )
    ),
    mainPanel(
      plotOutput("Flower")
    )
  )
)

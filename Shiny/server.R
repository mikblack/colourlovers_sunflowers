library(shiny)
library(ggplot2)
library(colourlovers)
library(rlist)
library(dplyr)
 
top=clpalettes('top')
sapply(1:length(top), function(x) list.extract(top, x)$title)->titles
 
CreatePlot = function (ang=pi*(3-sqrt(5)), nob=150, siz=15, sha=21, pal="LoversInJapan") {
   
  list.extract(top, which(titles==pal))$colors %>% 
    unlist %>% 
    as.vector() %>% 
    paste0("#", .) -> all_colors
   
  colors=data.frame(hex=all_colors, darkness=colSums(col2rgb(all_colors)))
  colors %>% arrange(-darkness)->colors
   
  background=colors[1,"hex"] %>% as.character
 
  colors %>% filter(hex!=background) %>% .[,1] %>% as.vector()->colors
 
  ggplot(data.frame(r=sqrt(1:nob), t=(1:nob)*ang*pi/180), aes(x=r*cos(t), y=r*sin(t)))+
    geom_point(colour=sample(colors, nob, replace=TRUE, prob=exp(1:length(colors))), aes(size=(nob-r)), shape=16)+
    scale_x_continuous(expand=c(0,0), limits=c(-sqrt(nob)*1.4, sqrt(nob)*1.4))+
    scale_y_continuous(expand=c(0,0), limits=c(-sqrt(nob)*1.4, sqrt(nob)*1.4))+
    theme(legend.position="none",
          panel.background = element_rect(fill=background),
          panel.grid=element_blank(),
          axis.ticks=element_blank(),
          axis.title=element_blank(),
          axis.text=element_blank())}
 
function(input, output) {
 output$Flower=renderPlot({
    CreatePlot(ang=180*(3-sqrt(5)), nob=input$nob, siz=input$siz, sha=as.numeric(input$sha), pal=input$pal)
  }, height = 550, width = 550 )}

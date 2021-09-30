library(tidyverse)
library(highcharter)
library(htmlwidgets)

dataset = read.csv('~/db.csv',
                   fileEncoding = 'Latin1', check.names = F)
#dataset <- dataset[order(dataset$Company),]
dataset <- dataset[, -1]
colnames(dataset)[3] <- 'Imdb'
colnames(dataset)[4] <- 'Metascore'
colnames(dataset)[1] <- 'Title'
glimpse(dataset)
dataset$Company <- as.character(as.factor(dataset$Company))
dataset$Title <- as.character(as.factor(dataset$Title))
glimpse(dataset)
dataset$Company[dataset$Company == 'Marvel'] <- 'MARVEL'
dataset[dataset == 'Captain Marve'] <- 'Captain Marvel'

p <- hchart(dataset, type = 'scatter',
            hcaes(x = 'Imdb', y = 'Metascore', group = Company)) %>%
  hc_add_series(name = 'Title', dataset$Title, visible = F, showInLegend = F) %>%
  hc_colors(c('black','red')) %>%
  hc_yAxis(max = '90') %>%
  hc_add_theme(hc_theme_elementary()) %>%
  hc_tooltip(useHTML = T, headerFormat = '<b> {series.name} <br>',
             pointFormat = '{point.Title} <br><br> <i> Imdb: {point.x} <br> Metascore: {point.y}',
             shape = 'callout') %>%
  hc_xAxis(title = list(align = 'high')) %>%
  hc_yAxis(title = list(align = 'high')) %>%
  hc_legend(align = 'left', verticalAlign = 'top') %>%
  hc_title(text = 'MARVEL vs DC', 
           style = list(fontWeight = 'bold', fontSize = '20px'),
           align = 'left') %>%
  hc_subtitle(text = 'Movies released from 2004 to 2019',
              style = list(fontWeight = 'bold', fontSize = '15px'),
              align = 'left') %>%
  hc_credits(enabled = TRUE, text = 'Map by Antonela Tamagnini
             <br> Source: IMDB')
p
saveWidget(widget = p, file = "plot.html")

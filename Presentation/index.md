---
title       : European population 1989-1995
subtitle    : Analysing the evolution of the population
author      : Hodei Iraola
job         : 
framework   : io2012   # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## The analysed data

1. The European Country population dataset contains data of 17 european countries from 1989 to 1995. 
2. The included 17 countries are: Austria, Belgium, Denmark, Finland, France, Germany, Iceland, Ireland, Italy, Luxemburg, Netherland, Norway, Portugal, Spain, Sweden, Switzerland and United Kingdom
3. The dataset contains 17 observations and 8 variables(country name and 7 population values). 
4. The dataset has been download from this [link](http://mathforum.org/workshops/sum96/data.collections/datalibrary/Eur.pop.XL.zip.xls) at [MathForum](http://mathforum.org/)

--- .class #id 

## Map plot

* The map plot is published using rworldmap. This is the code used for that in server.R, inside renderPlot


```r
output$mapplot <- renderPlot({
      mapCountryData(malMap, nameColumnToPlot=paste("NumPop",input$yearMap,sep=""), catMethod = "pretty",
                     missingCountryCol = gray(.8), mapRegion="europe")
    })
```

* Before the shinyServer function, where data is the loaded dataset:


```r
codes.of.origin <- as.vector(as.character(data$Country))
# Vector of values to be converted
data$CountryCode <- countrycode(codes.of.origin, "country.name", "iso3c")

malMap <- joinCountryData2Map(data, joinCode = "ISO3",
                              nameJoinColumn = "CountryCode")
```

--- .class #id 

## Table

* The second tab shows a table with the data used for the project. It has been printed using renderDataTable in server.R:  


```r
output$mytable = renderDataTable({
      data
    })
```

* In the ui.R, dataTableOutput is used.


```r
tabPanel("Table", dataTableOutput('mytable'))
```

--- .class #id 

## Plot

* ggplot2 library and render plot have been used to print the time series graphic. In server.R:  


```r
renderPlot({
  ggp <- ggplot(countries, aes(year, y = variable, color = variable),environment = environment());
  ggp <- ggp + geom_line(aes(y = countries$"Austria", col = "Austria"));
  gpp
  })
```

* In the ui.R, plotOutput is used.


```r
plotOutput("plot")
```

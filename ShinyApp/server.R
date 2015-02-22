library(shiny)
library(UsingR)
library(countrycode)
library(gdata)
library(rworldmap)
library(ggplot2)

# downloadDataSet <- function() {
#   fileUrl <- "http://mathforum.org/workshops/sum96/data.collections/datalibrary/Eur.pop.XL.zip.xls"
#   download.file(fileUrl,"European_Population_DS.xls", method="curl")
# }
# downloadDataSet()
data <- read.xls("European_Population_DS.xls")

#Clean data 
names(data) <- c("Country","Pop_1989","Pop_1990","Pop_1991","Pop_1992","Pop_1993","Pop_1994","Pop_1995")
data <- data[2:18,]

data$Country <- as.character(data$Country)
data$Country[11] <- "Netherlands"
data$Country <- as.factor(data$Country)
data$Country <- as.factor(as.character(data$Country))
data$Pop_1989 <- as.numeric(as.character(data$Pop_1989))
data$Pop_1990 <- as.numeric(as.character(data$Pop_1990))
data$Pop_1991 <- as.numeric(as.character(data$Pop_1991))
data$Pop_1992 <- as.numeric(as.character(data$Pop_1992))
data$Pop_1993 <- as.numeric(as.character(data$Pop_1993))
data$Pop_1994 <- as.numeric(as.character(data$Pop_1994))
data$Pop_1995 <- as.numeric(as.character(data$Pop_1995))

codes.of.origin <- as.vector(as.character(data$Country))
# Vector of values to be converted
data$CountryCode <- countrycode(codes.of.origin, "country.name", "iso3c")

malMap <- joinCountryData2Map(data, joinCode = "ISO3",
                              nameJoinColumn = "CountryCode")
# This will join your malDF data.frame to the country map data

malMap$NumPop1989 <- as.numeric(as.character(malMap$Pop_1989))
malMap$NumPop1990 <- as.numeric(as.character(malMap$Pop_1990))
malMap$NumPop1991 <- as.numeric(as.character(malMap$Pop_1991))
malMap$NumPop1992 <- as.numeric(as.character(malMap$Pop_1992))
malMap$NumPop1993 <- as.numeric(as.character(malMap$Pop_1993))
malMap$NumPop1994 <- as.numeric(as.character(malMap$Pop_1994))
malMap$NumPop1995 <- as.numeric(as.character(malMap$Pop_1995))

countryList <- as.list(data$Country)
countries <- data.frame(1989:1995)
for(i in 1:length(countryList)){
  countries <- cbind(countries,as.integer(data[data$Country==as.character(countryList[[i]][1]),2:8]))
}

names(countries) <- c("year",as.character(data$Country))

shinyServer(
  function(input, output) {
    output$mytable = renderDataTable({
      data
    })
    
    output$mapplot <- renderPlot({
      mapCountryData(malMap, nameColumnToPlot=paste("NumPop",input$yearMap,sep=""), catMethod = "pretty",
                     missingCountryCol = gray(.8), mapRegion="europe")
    })
    
    
    output$plot <- renderPlot({
      countryList <- input$countryList
      ggp <- ggplot(countries, aes(year, y = variable, color = variable),environment = environment()) 
      for(i in 1:length(countryList)){
        countryName <- as.character(countryList[[i]][1])
        
        switch(countryName, 
               Austria={ggp <- ggp + geom_line(aes(y = countries$"Austria", col = "Austria"))},
               Belgium={ggp <- ggp + geom_line(aes(y = countries$"Belgium", col = "Belgium"))},
               Denmark={ggp <- ggp + geom_line(aes(y = countries$"Denmark", col = "Denmark"))},
               Finland={ggp <- ggp + geom_line(aes(y = countries$"Finland", col = "Finland"))},
               France={ggp <- ggp + geom_line(aes(y = countries$"France", col = "France"))},
               Germany={ggp <- ggp + geom_line(aes(y = countries$"Germany", col = "Germany"))},
               Iceland={ggp <- ggp + geom_line(aes(y = countries$"Iceland", col = "Iceland"))},
               Ireland={ggp <- ggp + geom_line(aes(y = countries$"Ireland", col = "Ireland"))},
               Italy={ggp <- ggp + geom_line(aes(y = countries$"Italy", col = "Italy"))},
               Luxemburg={ggp <- ggp + geom_line(aes(y = countries$"Luxemburg", col = "Luxemburg"))},
               Netherlands={ggp <- ggp + geom_line(aes(y = countries$"Netherlands", col = "Netherlands"))},
               Norway={ggp <- ggp + geom_line(aes(y = countries$"Norway", col = "Norway"))},
               Portugal={ggp <- ggp + geom_line(aes(y = countries$"Portugal", col = "Portugal"))},
               Spain={ggp <- ggp + geom_line(aes(y = countries$"Spain", col = "Spain"))},
               Sweden={ggp <- ggp + geom_line(aes(y = countries$"Sweden", col = "Sweden"))},
               Switzerland={ggp <- ggp + geom_line(aes(y = countries$"Switzerland", col = "Switzerland"))},
               "United Kingdom"={ggp <- ggp + geom_line(aes(y = countries$"United Kingdom", col = "United Kingdom"))},
              {}
        ) 
      }
    ggp
    })
  }
)
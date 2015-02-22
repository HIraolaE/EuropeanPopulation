library(shiny)
shinyUI(
  pageWithSidebar(
    headerPanel("European countries population(1989-1995)"),
    sidebarPanel(
      h1('Analysis of population in the country'),
      p('This shinyApp shows european countries population data between 1989 and 1995.'),
      p('The included 17 countries are: Austria, Belgium, Denmark, Finland, France, Germany, Iceland, Ireland, Italy, Luxemburg, Netherland, Norway, Portugal, Spain, Sweden, Switzerland, United Kingdom'),
      p('The dataset was published in MathForum'),
      a("Math Forum", href="http://mathforum.org/"),
      p('The dataset can be found in the following link.'),
      a("Click Here to Download the dataset", href="http://mathforum.org/workshops/sum96/data.collections/datalibrary/Eur.pop.XL.zip.xls")
    ),
    mainPanel(
      
      tabsetPanel(
        tabPanel("Home",
                 br(),
                 h1('Analysis of population in the country'),
                 br(),p('There are different options to see the introduced data.'),
                 br(),p('In the tab Map Plot you can select the year and the data will be shown in a map.'),
                 br(),p('In the tab Table you can visualize the used data.'),
                 br(),p('Finally, in the tab plot you can see the progress of the population in each country. You can select the countries that you want to visualize.')),
        tabPanel("Map Plot", plotOutput("mapplot"),radioButtons(inputId="yearMap", "Select year to show:",
                                                                c("1989" = 1989,
                                                                  "1990" = 1990,
                                                                  "1991" = 1991,
                                                                  "1992" = 1992,
                                                                  "1993" = 1993,
                                                                  "1994" = 1994,
                                                                  "1995" = 1995), inline=T)),
        tabPanel("Table", dataTableOutput('mytable')),
        tabPanel("Plot", plotOutput("plot"),checkboxGroupInput("countryList", "Countries:",
                                                               c("Austria"="Austria",
                                                                 "Belgium"="Belgium",
                                                                 "Denmark"="Denmark",
                                                                 "Finland"="Finland",
                                                                 "France"="France",
                                                                 "Germany"="Germany",
                                                                 "Iceland"="Iceland",
                                                                 "Ireland"="Ireland",
                                                                 "Italy"="Italy",
                                                                 "Luxemburg"="Luxemburg",
                                                                 "Netherlands"="Netherlands",
                                                                 "Norway"="Norway",
                                                                 "Portugal"="Portugal",
                                                                 "Spain"="Spain",
                                                                 "Sweden"="Sweden",
                                                                 "Switzerland"="Switzerland",
                                                                 "United Kingdom"="United Kingdom"),
                                                               selected="Austria", inline=T))
      )
    )
  )
)
# TODO: use wisely and remove after handling the requests
#lapply(dbListConnections(PostgreSQL()), dbDisconnect)

packages <- c("RPostgreSQL", 
              "shiny", 
              "shinydashboard", 
              "plyr")

# handle package installatiion and initialisation CRAN
loadPackages <- function(packages){
  # compares required/installed packages
  new.packages <- packages[!(packages %in% installed.packages()[,"Package"])]
  library.packages <- packages[(packages %in% installed.packages()[,"Package"])]
  # installs missing packages
  if(length(new.packages)) install.packages(new.packages) 
  # load libraries
  for(pack in library.packages){
    library(pack, character.only = TRUE)
  }
}

loadPackages(packages)



#broken dependencies
#install.packages('tibble')
#library(ggplot2)
# Barplot
#bp<- ggplot(df, aes(x="", y=value, fill=group))+
#  geom_bar(width = 1, stat = "identity")
#bp


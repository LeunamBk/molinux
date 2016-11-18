moliAll <- function() {
  query <- "SELECT year, plot, taxa, count
                FROM vrlamgm_ch
                JOIN molinux_endstand ON abkuerzung = name;"
  
  moli.all <- postgresGetQuery(query)
  
  return(moli.all)
}
  
moliGteOne <- function(doubleCols = FALSE) {
  
  query <- "SELECT name, taxa, count(*) FROM vrlamgm_ch 
  JOIN molinux_endstand ON abkuerzung = name
  GROUP BY NAME, taxa ORDER BY count(*) DESC;"
  
  moli.groupcount <- postgresGetQuery(query)
  
  one <- 100/sum(moli.groupcount['count'])
  moli.groupcount['count'] <- round(one * moli.groupcount['count'], 2)
  
  # filter taxa % >= 1
  data <- moli.groupcount
  data <- data[data$count >= 1,] 
  # convert rows side b
  half <- data[1:(nrow(data)/2),c('taxa','count')]
  half <- rename(half, c("taxa"="Taxa","count"="Percent"))
  rowsInHalf <- nrow(half)
  if(rowsInHalf < (nrow(data) - rowsInHalf) ) {
    half <- rbind(half,c('',NULL))
  }
  
  data <- cbind(half, data[(rowsInHalf+1):nrow(data),c('taxa','count')]) 
  data <- rename(data, c("count"="percent"))
  
  return(data)
}

molusInfoOnCol <- function(column) {
  # taxa
  # redlist: rl_by, rld1s
  query <- paste("SELECT ", column,", count(*) FROM vrlamgm_ch 
                  JOIN molinux_endstand ON abkuerzung = name
                  GROUP BY ", column, " ;",
                 sep="")
  
  return(postgresGetQuery(query))
}

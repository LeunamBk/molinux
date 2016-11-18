withNALabel <- function(lables){
  lblinsx <- is.na(lables)
  lables[lblinsx] <- "NA"
  return(lables)
} 

postgresSendQuery <- function(query){
  
  # loads the PostgreSQL driver
  drv <- dbDriver("PostgreSQL")
  
  ## Open a connection
  con <- dbConnect(drv, host = getdbHost(), port = getdbport(), user= getdbuser(), password=getdbpsw(), dbname=getdbname())
  
  # exec query
  dbSendQuery(con, query) 
  
  ## Closes the connection
  dbDisconnect(con)
  
  ## Frees all the resources on the driver
  dbUnloadDriver(drv)
}

postgresGetQuery <- function(query){
  
  # loads the PostgreSQL driver
  drv <- dbDriver("PostgreSQL")
  
  ## Open a connection
  con <- dbConnect(drv, host = getdbHost(), port = getdbport(), user= getdbuser(), password=getdbpsw(), dbname=getdbname())
  
  # exec query and fetch data
  res <- dbGetQuery(con, query) 
  
  ## Closes the connection
  dbDisconnect(con)
  
  ## Frees all the resources on the driver
  dbUnloadDriver(drv)
  
  return(res)
}

# install.packages("RPostgreSQL")
require("RPostgreSQL")

# create a connection
# loads the PostgreSQL driver
drv <- dbDriver("PostgreSQL")

# creates a connection to the postgres database
# note that "con" will be used later in each connection to the database
con <- dbConnect(drv, dbname = "molinux",
                 host = "85.214.202.219", port = 5432,
                 user = "postgres", password = '?z?8m3RY~%QbXxd')

#csv input
MyData <- read.csv(file="/home/mcb/Schreibtisch/Daten_Vorlandmanagement_fuer_CH.csv", header=TRUE, sep=";")

# db write
dbWriteTable(con,"vorlandmanagement_fuer_ch", MyData)

#db check
dbExistsTable(con, "vorlandmanagement_fuer_ch")

query <- "CREATE TABLE vrlamgm_ch (
  year integer,
  plot integer,
  count integer,
  name text);"

df_postgres <- dbGetQuery(con, query)

# reorder table structure
df_postgres <- dbGetQuery(con, 'SELECT * FROM vorlandmanagement_fuer_ch')

for(i in 1:nrow(df_postgres)){
  for(j in 4:ncol(df_postgres)){
    if(df_postgres[i,j]>0){
      
      query <- paste("INSERT INTO vrlamgm_ch VALUES (", df_postgres[i,2], ", ", df_postgres[i,3], ", ", df_postgres[i,j], ", '",df.colsNames[j],"' )", sep='')
      dbGetQuery(con, query)
    }
  }
}

close(con)
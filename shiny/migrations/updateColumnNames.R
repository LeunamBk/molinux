
coName <- c("RL.BY.Falkner.et.al..2003.", "Wissenschaftlicher.Name")
cnName <- tolower(c("RL_BY", "taxa"))

for(i in 2:length(coName)){

  query <- paste("ALTER TABLE molinux_endstand RENAME \"", coName[i], "\" TO ", cnName[i], " ;", sep="")  
  dbGetQuery(con, query)
}

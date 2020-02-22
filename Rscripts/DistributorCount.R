# getQueries --------------------------------------------------------------

minDateValue <- "2020-02-05 00:00:00"
maxDateValue <- "2020-02-05 23:59:59"

# setVariables ------------------------------------------------------------

vertica_Query <-
  sqlInterpolate(vertica,
    read_file("SQLQueries/vert_getDistributorlist.sql"),
    minDate = minDateValue,
    maxDate = maxDateValue
  )

sqlserver_Query <-
  sqlInterpolate(sqlserver,
    read_file("SQLQueries/sqls_getDistributorlist.sql"),
    minDate = minDateValue,
    maxDate = maxDateValue
  )
# get Data ----------------------------------------------------------------

Vest <- dbGetQuery(sqlserver,
                   sqlserver_Query)

Daas <- dbGetQuery(vertica,
                   vertica_Query)

setDT(Vest)
setDT(Daas)

# transformation ----------------------------------------------------------

setnames(
  Daas,
  old = names(Daas),
  new = c("DistributorId", "DistributorRegistrationDate")
)

Vest[, DistributorRegistrationDate := as.character(DistributorRegistrationDate)]
Daas[, DistributorRegistrationDate := as.character(DistributorRegistrationDate)]

setkey(Daas, "DistributorId", "DistributorRegistrationDate")
setkey(Vest, "DistributorId", "DistributorRegistrationDate")

# analysis ----------------------------------------------------------------

if(isTRUE(all.equal(Vest, Daas))){
  
  cat("+++++++++++\n")
  cat("Vestige and Daas Data are equal")
  cat("+++++++++++\n")
  cat("+++++++++++\n\n")

} else {
  
  cat("+++++++++++\n")
  cat("RightJoin Vest\n")
  cat("+++++++++++\n")
  print(Daas[Vest])
  cat("+++++++++++\n\n")
  
  
  cat("+++++++++++\n")
  cat("RightJoin Daas\n")
  cat("+++++++++++\n")
  print(Vest[Daas])
  cat("+++++++++++\n\n")
  
  cat("+++++++++++\n")
  cat("Not in Vest But in Daas\n")
  cat("+++++++++++\n")
  print(Daas[!Vest])
  cat("+++++++++++\n\n")
  
  cat("+++++++++++\n")
  cat("Not in Daas But in Vest\n")
  cat("+++++++++++\n")
  print(Vest[!Daas])
  cat("+++++++++++\n\n")

}

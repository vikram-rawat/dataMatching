# compareSQL --------------------------------------------------------------

compareSQL <- function(verticaSQL,
                       SQLserverSQL,
                       QueryParams,
                       verticaKeys = NULL,
                       sqlServerKeys = NULL
                       ){
  # setVariables ------------------------------------------------------------
  
  vertica_Query <-
    sqlInterpolate(vertica,
                   read_file(verticaSQL),
                   minDate = QueryParams$minDateValue,
                   maxDate = QueryParams$maxDateValue)
  
  sqlserver_Query <-
    sqlInterpolate(sqlserver,
                   read_file(SQLserverSQL),
                   minDate = QueryParams$minDateValue,
                   maxDate = QueryParams$maxDateValue)
  
  # get Data ----------------------------------------------------------------
  
  Vest <- dbGetQuery(sqlserver,
                     sqlserver_Query)
  
  Daas <- dbGetQuery(vertica,
                     vertica_Query)
  
  setDT(Vest)
  setDT(Daas)
  
  # transformation ----------------------------------------------------------
  ## Check Condition
  if(
    is.null(verticaKeys)
  ){
    return(
      list(
        vertica = Daas,
        SQLserverSQL = Vest
      )
    )
  }
  setkey(Daas, verticaKeys)
  setkey(Vest, sqlServerKeys)
  
  # analysis ----------------------------------------------------------------
  
  if (isTRUE(all.equal(Vest, Daas))) {
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
  
  return(
    list(
      vertica = Daas,
      SQLserverSQL = Vest
    )
  )
}

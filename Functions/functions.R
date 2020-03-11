# compareSQL --------------------------------------------------------------

compareSQL <- function(SQLConn1,
                       SQLConn2,
                       SQLQuery1,
                       SQLQuery2,
                       QueryParams,
                       Data1Keys = NULL,
                       Data2Keys = NULL
                       ){
  # setVariables ------------------------------------------------------------
  
  SQLQueryConverted1 <-
    sqlInterpolate(SQLConn1,
                   read_file(SQLQuery1),
                   minDate = QueryParams$minDateValue,
                   maxDate = QueryParams$maxDateValue)
  
  SQLQueryConverted2 <-
    sqlInterpolate(SQLConn2,
                   read_file(SQLQuery2),
                   minDate = QueryParams$minDateValue,
                   maxDate = QueryParams$maxDateValue)

  # createNames -------------------------------------------------------------

  name1 <- paste0(substitute(SQLConn1))
  name2 <- paste0(substitute(SQLConn2))
  
  # get Data ----------------------------------------------------------------
  
  
  SQLData1 <- dbGetQuery(SQLConn1, SQLQueryConverted1)
  SQLData2 <- dbGetQuery(SQLConn2, SQLQueryConverted2)
  
  setDT(SQLData1,key = Data1Keys)
  setDT(SQLData2,key = Data2Keys)
  
  # transformation ----------------------------------------------------------
  ## Check Condition
  if(
    is.null(Data1Keys)
  ){
    
    returnList <- list()
    
    returnList[[name1]] <- SQLData1
    returnList[[name2]] <- SQLData2
    
    return(
        returnList
    )
  }

  # analysis ----------------------------------------------------------------
  
  if (isTRUE(all.equal(SQLData1, SQLData2))) {
    cat("+++++++++++\n")
    cat("Vestige and Daas Data are equal")
    cat("+++++++++++\n")
    cat("+++++++++++\n\n")
    
  } else {
    cat("+++++++++++\n")
    cat("RightJoin SecondConnection\n")
    cat("+++++++++++\n")
    print(SQLData1[SQLData2])
    cat("+++++++++++\n\n")
    
    
    cat("+++++++++++\n")
    cat("RightJoin FirstConnection\n")
    cat("+++++++++++\n")
    print(SQLData2[SQLData1])
    cat("+++++++++++\n\n")
    
    cat("+++++++++++\n")
    cat("Not in Second But in First\n")
    cat("+++++++++++\n")
    print(SQLData1[!SQLData2])
    cat("+++++++++++\n\n")
    
    cat("+++++++++++\n")
    cat("Not in First But in Second\n")
    cat("+++++++++++\n")
    print(SQLData2[!SQLData1])
    cat("+++++++++++\n\n")
    
  }
  
  returnList <- list()
  
  returnList[[name1]] <- SQLData1
  returnList[[name2]] <- SQLData2
  
  return(
    returnList
  )
}

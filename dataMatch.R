# load libraries ----------------------------------------------------------

library("data.table")
library("magrittr")
library("DBI")
library("odbc")
library("stringi")
library("readr")
library("ggplot2")
library("plotluck")

# set defaults ------------------------------------------------------------

setDTthreads(0L)
theme_set(theme_bw())

# setup Connections -------------------------------------------------------

sqlserver <- dbConnect(odbc::odbc(),
                       dsn = "vestige_sqlserver",
                       uid = "devreadonlyuser",
                       pwd = "D3^U$Er")

# dbListTables(sqlserver)
# dbDisconnect(sqlserver)

vertica <- dbConnect(odbc::odbc(),
                     dsn = "vestige_vertica",
                     uid = "dbadmin",
                     pwd = "data123")

# dbListTables(vertica)
# dbDisconnect(vertica)


# source files ------------------------------------------------------------

source("Functions/functions.R")

# compare Queries ---------------------------------------------------------

compData <- compareSQL(
  SQLConn1 = sqlserver,
  SQLConn2 = vertica,
  SQLQuery1 = "SQLQueries/Promotions/sqls_category.sql",
  SQLQuery2 = "SQLQueries/Promotions/vert_category.sql",
  QueryParams = list(
    minDate = "2020-03-01 00:00:00",
    maxDate = "2020-03-12 23:59:59"
  ),
  Data1Keys = "product_category",
  Data2Keys = "product_category"
)

compData$vertica
compData$sqlserver

getDataSQL(
  SQLConn =  sqlserver,
  SQLQuery = "SQLQueries/Promotions/sqls_category.sql",
  # Keys = "product_category",
  QueryParams = list(
    minDate = "2020-02-05 00:00:00",
    maxDate = "2020-02-05 23:59:59"
  )
)

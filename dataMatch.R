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

## Need Connection and libraries to run this code
# source("Rscripts/DistributorCount.R")

data <- compareSQL(
  SQLConn1 = sqlserver,
  SQLConn2 = vertica,
  SQLQuery1 = "SQLQueries/Promotions/sqls_category.sql",
  SQLQuery2 = "SQLQueries/Promotions/vert_category.sql",
  QueryParams = list(
    minDateValue = "2020-02-05 00:00:00",
    maxDateValue = "2020-02-05 23:59:59"
  ),
  Data1Keys = "product_category",
  Data2Keys = "product_category" 
)
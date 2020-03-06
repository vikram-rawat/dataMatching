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

# sqlserver <- dbConnect(odbc::odbc(),
#                        dsn = "vestige_sqlserver",
#                        uid = "devreadonlyuser",
#                        pwd = "D3^U$Er")

# dbListTables(sqlserver)
# dbDisconnect(sqlserver)

all_cargo_vertica <- dbConnect(odbc::odbc(),
                     dsn = "all_cargo_vertica",
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
  verticaSQL =  "SQLQueries/Promotions/vert_category.sql",
  SQLserverSQL = "SQLQueries/Promotions/sqls_subcategory.sql",
  QueryParams = list(
    minDateValue = "2020-02-05 00:00:00",
    maxDateValue = "2020-02-05 23:59:59"
  )
)

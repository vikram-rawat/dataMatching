# load libraries ----------------------------------------------------------

library(data.table)
library(magrittr)
library(DBI)
library(odbc)
library(stringi)
library(readr)
library(ggplot2)

# set defaults ------------------------------------------------------------

setDTthreads(0L)
theme_set(theme_bw())

# setup Connections -------------------------------------------------------

sqlserver <- dbConnect(odbc(),
                       dsn = "vestige_sqlserver",
                       uid = "devreadonlyuser",
                       pwd = "D3^U$Er")

# dbListTables(sqlserver)
# dbDisconnect(sqlserver)

vertica <- dbConnect(odbc(),
                     dsn = "vestige_vertica",
                     uid = "dbadmin",
                     pwd = "data123")

# dbListTables(vertica)
# dbDisconnect(vertica)

# compare Queries ---------------------------------------------------------

## Need Connection and libraries to run this code
source("Rscripts/DistributorCount.R")
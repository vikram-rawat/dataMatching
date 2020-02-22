# load libraries ----------------------------------------------------------

library(data.table)
library(magrittr)
library(DBI)
library(stringi)
library(readr)
library(ggplot2)
library(inspectdf)
library(plotluck)
library(dm)

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

# compare Queries ---------------------------------------------------------

## Need Connection and libraries to run this code
source("Rscripts/DistributorCount.R")
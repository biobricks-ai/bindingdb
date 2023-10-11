#!/usr/bin/env Rscript
pacman::p_load(DBI, RMySQL, arrow, tidyverse)

# create a random name
sysglue <- \(x){ system(glue::glue(x)) }
container_name <- paste0("mysql-", as.integer(runif(1, 0, 1000000)))
sysglue("docker run --rm --name {container_name} -e MYSQL_ROOT_PASSWORD=pw -d -p 3306:3306 mysql:8.1.0")

withr::defer({ sysglue("docker container stop {container_name}") })

dumpfile <- fs::dir_ls("download/sqldump/", regexp = "*.dmp") |> first()
sysglue("docker cp {dumpfile} {container_name}:/dump.dmp")
Sys.sleep(5)
sysglue("docker exec -it {container_name} mysql -uroot -ppw -e 'CREATE DATABASE bindingdb;'")
Sys.sleep(5)
sysglue("docker exec -it {container_name} mysql -uroot -ppw bindingdb -e 'source /dump.dmp'")

con <- dbConnect(RMySQL::MySQL(), dbname = 'bindingdb', host = '127.0.0.1', port = 3306, user = 'root', password = 'pw')
withr::defer({ dbDisconnect(con) })

dir.create("brick/mysql_dump/", recursive = TRUE)
sapply(dbListTables(con), function(table_name) {
  print(table_name)
  df <- dbReadTable(con, table_name)
  write_dataset(df, paste0("brick/mysql_dump/", table_name, ".parquet"))
})

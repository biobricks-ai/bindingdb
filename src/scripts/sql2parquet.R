#!/usr/bin/env Rscript
pacman::p_load(DBI, RMySQL, arrow, tidyverse)

# create a random name
sysglue <- \(x){ system(glue::glue(x)) }
container_name <- paste0("mysql-", as.integer(runif(1, 0, 1000000)))
sysglue("docker run --rm --name {container_name} -e MYSQL_ROOT_PASSWORD=pw -d -p 3306:3306 mysql:8.1.0")

withr::defer({ sysglue("docker container stop {container_name}") })

sysglue("docker cp download/sqldump/BDB_my-202307.dmp {container_name}:/dump.dmp")
sysglue("docker exec -it {container_name} mysql -uroot -ppw -e 'CREATE DATABASE bindingdb;'")
sysglue("docker exec -it {container_name} mysql -uroot -ppw bindingdb -e 'source /dump.dmp'")

con <- dbConnect(RMySQL::MySQL(), dbname = 'bindingdb', host = '127.0.0.1', port = 3306, user = 'root', password = 'pw')

dir.create("brick/", recursive = TRUE)
sapply(dbListTables(con), function(table_name) {
  print(table_name)
  df <- dbReadTable(con, table_name)
  write_dataset(df, paste0("brick/", table_name, ".parquet"))
})

dbDisconnect(con)

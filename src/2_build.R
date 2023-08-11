pacman::p_load(readr, arrow)

# remove bindingdb.parquet if it already exists
if(fs::dir_exists("brick/bindingdb.parquet")){ fs::dir_delete("brick/bindingdb.parquet") }

bdb <- readr::read_tsv("download/bindingdb_all.tsv.zip")
arrow::write_dataset(bdb, "brick/bindingdb.parquet", max_rows_per_file = 1e6)

library(readr)
library(arrow)

td <- tempdir()
system(sprintf("unzip download/bdb.tsv.zip -d %s", td))

# The bindingdb tsv file has many columns but there are reading issues with those past the 50th column
numcols <- 50
file_path <- fs::dir_ls(td)[1]
outpath <- fs::path(td,"output_file.tsv")
system(sprintf("cut -f1-%s %s > %s", numcols, file_path, outpath))

# all columns treated as strings to handle some entries like >5000 in dbl columns
col_types <- cols(!!!rep(list(col_character()), numcols))
df <- readr::read_tsv(outpath, col_types=col_types)
arrow::write_dataset(df, "brick/full_tsv_dump.parquet", max_rows_per_file = 1e7)
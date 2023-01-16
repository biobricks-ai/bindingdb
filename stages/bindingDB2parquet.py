from os import mkdir
import pandas as pd
import sys


InFileName = sys.argv[1]
OutDirName = sys.argv[2]

#read and convert in chunck
i_name_parquet = 1
chunksize = 10 ** 6
with pd.read_csv(InFileName, chunksize=chunksize, sep = "\t", low_memory=False, error_bad_lines=False) as reader:
    for chunk in reader:
        chunk.to_parquet("%s/bindingDB%s.parquet"%(OutDirName, i_name_parquet))
        i_name_parquet = i_name_parquet + 1

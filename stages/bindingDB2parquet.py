import pandas as pd
import sys


InFileName = sys.argv[1]
OutFileName = sys.argv[2]
#print(InFileName)

df = pd.read_fwf(InFileName, sep='\t')
#print(df.head())


df.to_parquet(OutFileName, compression='gzip')

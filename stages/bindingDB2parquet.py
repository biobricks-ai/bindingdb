import pandas as pd
import sys


InFileName = sys.argv[1]
OutFileName = sys.argv[2]

#open file
df = pd.read_fwf(InFileName, sep='\t')

#convert to parquet
df.to_parquet(OutFileName)

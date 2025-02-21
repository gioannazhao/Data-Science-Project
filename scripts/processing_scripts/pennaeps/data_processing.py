import pandas as pd
import numpy as np

file_path = '../../../data/pennaeps/Qualified_Facilities_Report.csv'

# load the data into a DataFrame, skippin ghte fisrt two rows
df = pd.read_csv(file_path, skiprows=2)

# display the first few rows of the DataFrame
print('First few rows of the data: ')
print(df.head(5))

print('---------------------------------------------------')
# get an overview of the data
print('Data overview: ')
print(df.info())

print('---------------------------------------------------')
# check basic statistics of the data
print('Basic statistics of the data: ')
print(df.describe())

print('---------------------------------------------------')

# get column labels
print('Column labels: ')
print(df.columns)

print('---------------------------------------------------')

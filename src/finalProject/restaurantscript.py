import pandas as pd

df = pd.read_csv("../../db/csv/restaurants.csv")

list(df)
print df.head()
df = df.drop(['latitude', 'longitude'], axis=1)

df.to_csv("../../db/csv/restaurantsnew.csv")
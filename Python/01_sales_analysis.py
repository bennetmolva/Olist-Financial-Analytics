
import pandas as pd

# Load monthly sales exported from DuckDB
df = pd.read_csv("monthly_sales.csv", parse_dates=["month"])

# Check data quality
print("\nDATA QUALITY")
print("Total months:", len(df))
print("Missing values:\n", df.isnull().sum())

# Calculate sales metrics
print("\nSALES SUMMARY")
print("Total sales: R$", round(df["total_sales"].sum(), 2))
print("Average monthly sales: R$", round(df["total_sales"].mean(), 2))
print("Highest sales month:")
print(df.loc[df["total_sales"].idxmax(), ["month", "total_sales"]])

# Calculate monthly growth
df["monthly_growth_pct"] = df["total_sales"].pct_change() * 100

print("\nMONTHLY SALES AND GROWTH")
print(df[["month", "total_sales", "monthly_growth_pct"]].to_string(index=False))


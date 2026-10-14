
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_absolute_error

# Load monthly sales
df = pd.read_csv("monthly_sales.csv", parse_dates=["month"])
df = df.sort_values("month").reset_index(drop=True)

# Create time variable
df["month_number"] = np.arange(len(df))

# Train on first 16 months, test on final 4
train = df.iloc[:16]
test = df.iloc[16:]

model = LinearRegression()
model.fit(train[["month_number"]], train["total_sales"])

# Predict final 4 months
predictions = model.predict(test[["month_number"]])

# Measure forecast accuracy
mae = mean_absolute_error(test["total_sales"], predictions)

results = test[["month", "total_sales"]].copy()
results["forecast"] = predictions.round(2)
results["error"] = results["total_sales"] - results["forecast"]

print("\nFORECAST RESULTS")
print(results.to_string(index=False))
print(f"\nMean Absolute Error: R${mae:,.2f}")

# Save results for Excel and Power BI
results.to_csv("Python/forecast_results.csv", index=False)



import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_absolute_error

# Load monthly sales data
df = pd.read_csv("monthly_sales.csv", parse_dates=["month"])
df = df.sort_values("month").reset_index(drop=True)

sales = df["total_sales"].to_numpy()
results = []

# Predict each month using only earlier months
# Start after 8 months of historical data
for i in range(8, len(sales)):
    history = sales[:i]
    actual = sales[i]

    # Linear regression
    model = LinearRegression()
    model.fit(
        np.arange(i).reshape(-1, 1),
        history
    )
    linear = model.predict([[i]])[0]

    # 3-month moving average
    moving = np.mean(history[-3:])

    # Naive forecast
    naive = history[-1]

    for name, forecast in [
        ("Linear Regression", linear),
        ("Moving Average", moving),
        ("Naive Forecast", naive)
    ]:
        results.append({
            "month": df.loc[i, "month"],
            "model": name,
            "actual": actual,
            "forecast": forecast,
            "absolute_error": abs(actual - forecast)
        })

# Compare performance
results_df = pd.DataFrame(results)

summary = (
    results_df.groupby("model")["absolute_error"]
    .mean()
    .sort_values()
)

print("\nROLLING BACKTEST RESULTS")
print(summary.round(2))

print("\nBEST MODEL:", summary.index[0])

# Save for Excel and Power BI
results_df.to_csv(
    "Python/rolling_backtest_results.csv",
    index=False
)

summary.to_csv(
    "Python/rolling_backtest_summary.csv"
)


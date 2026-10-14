
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_absolute_error

# Load sales data
df = pd.read_csv("monthly_sales.csv", parse_dates=["month"])
df = df.sort_values("month").reset_index(drop=True)

# First 16 months for training, last 4 for testing
train = df.iloc[:16]
test = df.iloc[16:]

actual = test["total_sales"].to_numpy()

# Model 1: Linear Regression
model = LinearRegression()
model.fit(np.arange(16).reshape(-1, 1), train["total_sales"])
linear = model.predict(np.arange(16, 20).reshape(-1, 1))

# Model 2: 3-month Moving Average
# Forecast all four months using only training data
history = list(train["total_sales"].tail(3))
moving = []

for i in range(4):
    prediction = np.mean(history[-3:])
    moving.append(prediction)
    history.append(prediction)

# Model 3: Naive Forecast
# Assume sales remain at last observed level
naive = np.repeat(train["total_sales"].iloc[-1], 4)

# Compare accuracy
results = pd.DataFrame({
    "model": ["Linear Regression", "Moving Average", "Naive Forecast"],
    "MAE": [
        mean_absolute_error(actual, linear),
        mean_absolute_error(actual, moving),
        mean_absolute_error(actual, naive)
    ]
})

results = results.sort_values("MAE")

print("\nFORECAST MODEL COMPARISON")
print(results.to_string(index=False, float_format="%.2f"))

print("\nBEST MODEL:", results.iloc[0]["model"])

# Save results
results.to_csv("Python/model_comparison.csv", index=False)


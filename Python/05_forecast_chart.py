
import pandas as pd import matplotlib.pyplot as plt import pandas as pd # Load rolling 
backtest results df = pd.read_csv( import matplotlib.pyplot as plt 
"Python/rolling_backtest_results.csv", from matplotlib.ticker import FuncFormatter 
parse_dates=["month"] )

# Organize forecast results forecasts = df.pivot( # Load forecast results index="month", 
df = pd.read_csv( columns="model",
    "Python/rolling_backtest_results.csv", values="forecast" ).sort_index() 
    parse_dates=["month"]
)actual = (
    df.drop_duplicates("month") .set_index("month")["actual"] .sort_index() # Organize 
forecasts) forecasts = df.pivot( # Create chart fig, ax = plt.subplots(figsize=(12, 6))
    index="month", ax.plot( columns="model", actual.index, actual.values, label="Actual 
    Sales", color="black", linewidth=2.8, marker="o" values="forecast")
).sort_index() for model in forecasts.columns:
    ax.plot( actual = ( forecasts.index, df.drop_duplicates("month")  forecasts[model], 
    .set_index("month")["actual"] label=model, .sort_index()  linewidth=1.8,
)  linestyle="--"
    ) # Calculate forecast accuracy ax.set_title( mae = ( "Olist Monthly Sales: Actual vs. 
Forecast",
    df.groupby("model")["absolute_error"] fontsize=16, fontweight="bold" ) .mean() 
)ax.set_xlabel("Month") ax.set_ylabel("Product Sales (R$)") ax.grid(alpha=0.2) ax.legend() 
fig.autofmt_xdate() plt.tight_layout()

# Save portfolio chart plt.savefig( # Create chart "Python/forecast_comparison.png", fig, 
ax = plt.subplots(figsize=(12, 6))  dpi=300,
    bbox_inches="tight" ) ax.plot( print("Chart saved: Python/forecast_comparison.png") 
plt.show()
    actual.index, actual.values, label="Actual Sales", color="black", linewidth=2.8, 
    marker="o"
) for model in forecasts.columns:
    ax.plot(
        forecasts.index, forecasts[model], label=f"{model} (MAE: R${mae[model]:,.0f})", 
        linewidth=1.8, linestyle="--"
    ) ax.set_title( "Olist Monthly Sales: Actual vs. Forecast", fontsize=16, 
    fontweight="bold"
)
ax.set_xlabel("Month")
ax.set_ylabel("Product Sales (R$ Millions)")

# Format Y-axis in millions
ax.yaxis.set_major_formatter(
    FuncFormatter(lambda x, pos: f"{x/1_000_000:.2f}")
)

ax.grid(alpha=0.2)
ax.legend(loc="upper left")
fig.autofmt_xdate()
plt.tight_layout()

# Save updated chart
plt.savefig(
    "Python/forecast_comparison.png",
    dpi=300,
    bbox_inches="tight"
)

print("Updated chart saved successfully!")
plt.show()



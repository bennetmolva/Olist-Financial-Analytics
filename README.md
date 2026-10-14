# Olist E-Commerce Financial Analytics

**SQL | Python | Excel | Tableau | Financial Forecasting**

## Project Overview

An end-to-end financial analytics project using the Olist Brazilian e-commerce dataset. This project analyzes historical sales performance, compares forecasting methods, and presents business performance through an interactive Tableau dashboard.

### [View Interactive Tableau Dashboard](https://public.tableau.com/views/OlistE-CommerceFinancialAnalytics/Dashboard1)

## Key Performance Indicators

| Metric | Result |
|---|---:|
| Total Product Sales | R$13.18M |
| Total Orders | 96,211 |
| Average Order Value | R$137.00 |
| Analysis Period | January 2017 – August 2018 |

*Product sales represent merchandise sales in the dataset, not Olist's corporate revenue. Monetary values are in Brazilian reais (BRL).*
## Tools & Technical Skills

- **SQL:** Data quality checks, joins, sales aggregation, and seller performance analysis.
- **Python:** Sales analysis, forecasting, model comparison, and rolling backtesting.
- **Excel:** Financial modeling, KPI tracking, and performance reporting.
- **Tableau:** Interactive dashboard creation, trend analysis, and date filtering.

## Forecasting Analysis

Compared three forecasting methods using rolling historical backtests.

| Forecasting Model | Mean Absolute Error |
|---|---:|
| Naive Forecast | R$108,787 |
| Moving Average | R$109,946 |
| Linear Regression | R$130,022 |

**Key Finding:** The naive forecasting model achieved the lowest historical mean absolute error among the three methods evaluated.

Forecasting accuracy was evaluated using historical backtests. Results do not guarantee future performance.

## Interactive Tableau Dashboard

The dashboard includes:

- Total Product Sales, Total Orders, and Average Order Value KPIs
- Monthly sales trends
- Monthly order volume
- Average order value trends
- Actual sales versus forecasting model predictions
- Interactive date-range filtering for sales performance metrics

**[Open the Tableau Dashboard](https://public.tableau.com/views/OlistE-CommerceFinancialAnalytics/Dashboard1)**

## Repository Structure

- `SQL/` — SQL queries for data preparation and analysis
- `Python/` — Python analysis scripts, forecasting models, and backtesting results
- `Olist FP&A Model.xlsx` — Excel financial analysis workbook
- `monthly_sales.csv` — Monthly aggregated sales data

## Business Applications

This project demonstrates how financial analysts can use historical data to:

- Monitor business performance and financial KPIs
- Identify sales trends and operating patterns
- Evaluate forecasting accuracy
- Support data-driven planning decisions
- Communicate findings through interactive dashboards

## Data Source

Olist Brazilian E-Commerce Public Dataset.

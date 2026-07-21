# NYSE Efficient Markets Hypothesis — AR(1) Test (R → Python)

Weak-form test of the Efficient Markets Hypothesis on 689 weeks of NYSE
weekly closing prices, using an AR(1) model on log returns.

**Origin:** This began as one part of a graduate time-series problem set,
which I expanded into a standalone financial econometrics paper. This repo
ports that analysis from R to Python (pandas + statsmodels) to reproduce
the published result and get reps translating between the two.

## Method
- Compute weekly log returns: `log_return_t = ln(P_t / P_{t-1})`
- Regress each week's return on the prior week's (AR(1)) via OLS
- Under EMH, the lagged-return coefficient (β₁) should be indistinguishable
  from zero

## Result (reproduced in both R and Python)
| Metric | Value |
|---|---|
| β₁ (lagged return) | 0.066 |
| R² | 0.004 |
| Observations | 689 |

β₁ is marginally statistically significant but economically trivial — it
explains ~0.4% of return variation. The evidence supports weak-form market
efficiency: statistically detectable, not economically exploitable.

## Files
- `nyse_emh.R` — original analysis in R
- `nyse_emh_port.ipynb` — Python port (pandas + statsmodels)
- `nyse.csv` — data (exported from the original `.Rda`)

## Note on reproducibility
Porting surfaced a one-row difference in how R's `drop_na()` and pandas'
`dropna()` interact with lag padding — a reminder that "the same analysis"
across two languages isn't automatically identical; the row counts have to
be checked. Both now agree at 689 observations.

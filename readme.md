# IndexComputations
Computing Index Prices and Returns from prices/returns of financial assets

This algorithm allows to create indices based on the following weighting schemes:
- Equal Weight
- Metric Weighted
- Equal Exposure to Metric

You can also choose between fixed weights or drifting weights.

NOTE: Only Long-only portfolios are supported.

# How to use
4 Inputs:
- Returns of components Array{Array{Float64, 1}, 1}
- Exposure Metrics of components Array{Float64, 1}
- fixed_weights Bool
- weighting scheme String

Weighting Scheme must take a value among these:  ["EQUAL_WEIGHTS", "METRIC_WEIGHTS", "EQUAL_EXPOSURE_METRIC"]



```julia
include("MainIndex.jl")

# If no metrics as inputs, write Array{Float64, 1}()
prices, returns, weights = generate_portfolio_from_returns(
    returns_components, 
    metrics, 
    fixed_weights, 
    weighting_scheme                 
)
```

The function generate_portfolio_from_prices can also be used by replacing the returns input by series of prices.

Outputs:
- Prices Array{Float64, 1}
- Returns Array{Float64, 1}
- Weights Array{Array{Float64, 1}, 1}
 
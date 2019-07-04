include("ImportsManager.jl")

WEIGHTINGS = ["EQUAL_WEIGHTS", "METRIC_WEIGHTS", "EQUAL_EXPOSURE_METRIC"]

function generate_portfolio_from_returns(returns::Array{Array{Float64,1 }, 1}, metrics::Array{Float64, 1}, fixed_weights::Bool, weighting_scheme::String)
    if !(weighting_scheme in WEIGHTINGS)
        @error "$weighting_scheme is not a valid weighting scheme. Please choose from $WEIGHTINGS"
        return
    end

    if weighting_scheme == "EQUAL_WEIGHTS"
        init_weights = equal_weighted(length(returns))
    else 
        if length(metrics) != length(returns)
            @error "Different number of components between metrics and returns. Check your inputs."
            return
        else
            if weighting_scheme == "METRIC_WEIGHTS"
                init_weights = metric_weighted(metrics)
            else
                init_weights = equal_exposure_metric_weighted(metrics)
            end
        end
    end

    return compute_portfolio_returns(init_weights, returns, fixed_weights)
end
    
function generate_portfolio_from_prices(prices::Array{Array{Float64,1 }, 1}, metrics::Array{Float64, 1}, fixed_weights::Bool, weighting_scheme::String)
    returns = prices_to_returns.(prices)
    
    return generate_portfolio_from_returns(returns, metrics, fixed_weights, weighting_scheme)
end

function compute_portfolio_returns(initial_weights::Array{Float64, 1}, 
                                    components_returns::Array{Array{Float64, 1}, 1},
                                    fixed_weights::Bool)
    if fixed_weights
        out_returns, weights = compute_fixed_returns(initial_weights, components_returns)
    else
        out_returns, weights = compute_floating_returns(initial_weights, components_returns)
    end

    return returns_to_prices(out_returns), out_returns, weights
end



function generate_rand_portfolio(nb_components=20, fixed_weights=false)
    returns = [generate_rand_returns(10000) for i in 1:nb_components];
    init_weights = generate_rand_weights(nb_components);

    return compute_portfolio_returns(init_weights, returns, fixed_weights)
end

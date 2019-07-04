function compute_cum_pnl(rets::Array{Float64, 1})
    cum_pnl = [1.]
    for r in rets
        append!(cum_pnl, cum_pnl[end] * (1+r))
    end

    return cum_pnl
end

function prices_to_returns(prices::Array{Float64, 1})
    rets = Array{Float64, 1}()

    for i in 2:length(prices)
        push!(rets, prices[i] / prices[i-1] - 1)
    end

    return rets
end

function returns_to_prices(returns::Array{Float64, 1})
    prices = [100.]
    for r in returns
        append!(prices, prices[end] * (1+r))
    end
    
    return prices
end
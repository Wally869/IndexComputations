include("utils.jl")

function generate_rand_returns(len_serie=100)
    return prices_to_returns(generate_brownian_prices(len_serie))
end


function generate_rand_weights(nb_components=20, allow_short=false)
    sum_weights = -1
    range_weights = (allow_short ? (-1:0.0001:1) : (0:0.0001:1))
    weights = []

    while sum_weights < 0
        weights = rand(range_weights, nb_components)
        sum_weights = sum(weights)
    end

    return (weights ./ sum_weights)
end

function generate_random_metric(nb_components=20)
    return rand(0:0.0001:1, nb_components)
end


# Added absorbing barrier at 0
function generate_brownian_prices(len_serie=100)
    prices = [100.]

    for _ in 1:len_serie
        append!(prices, prices[end] + sqrt(1/252) * randn())
    end

    prices[prices .<= 0.] .= 0.

    return prices
end




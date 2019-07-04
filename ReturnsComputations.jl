function compute_fixed_returns(init_weights::Array{Float64, 1}, 
                        returns::Array{Array{Float64, 1}, 1})

    adjusted_comp_returns = map(function(weight, rets) return rets .* weight end, init_weights, returns)
    out_returns = [0. for i in 1:length(returns[1])];
    weights = Array{Array{Float64, 1}, 1}()

    for i in 1:length(out_returns)
        push!(out_weights, init_weights)
        curr_return = 0.
        for j in 1:length(init_weights)
            out_returns[i] += adjusted_comp_returns[j][i]
        end
    end
    
    return out_returns, weights
end


function compute_floating_returns(init_weights::Array{Float64, 1}, 
                            returns::Array{Array{Float64, 1}, 1})
    out_returns = [0. for i in 1:length(returns[1])];
    weights = [init_weights]

    for i in 1:length(returns[1])
        for j in 1:length(weights[1])
            out_returns[i] += weights[end][j] * returns[j][i]
        end

        # Now compute evolution weights
        append!(weights, [deepcopy(weights[end])])
        for j in 1:length(weights[end])
            if weights[end][j] > 0
                weights[end][j] = weights[length(weights) - 1][j] * (1 + returns[j][i])
            else
                weights[end][j] = weights[length(weights) - 1][j] * (1 - returns[j][i])
            end
        end
        weights[end] = weights[end] ./ sum(weights[end])
    end
    
    return out_returns, weights
end


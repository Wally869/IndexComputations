

function equal_weighted(nb_components::Integer)
    return [1/nb_components for i in 1:nb_components]
end

function metric_weighted(metrics_value::Array{Float64, 1})
    # Recenter between 0 and 1, avoids issues with negative values. Adding 0.001 to avoid numerical issues with 0
    centered_mv = (metrics_value .- minimum(metrics_value)) / (maximum(metrics_value) - minimum(metrics_value)) .+ 0.001
    return centered_mv ./ sum(centered_mv)
end

function equal_exposure_metric_weighted(metrics_value::Array{Float64, 1})
    mw = metric_weighted(metrics_value)
    return (1 ./ mw) ./ sum(1 ./ mw)
end


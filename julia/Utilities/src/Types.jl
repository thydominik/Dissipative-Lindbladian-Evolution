module Types

"""
    struct QuantumGate
        name::String
        matrix::AbstractMatrix{ComplexF64}
        params::Dict{Symbol,Any}  # optional gate parameters
    end
"""
struct QuantumGate
    name::String
    matrix::AbstractMatrix{ComplexF64}
    params::Dict{Symbol,Any}
end

"""
    struct QuantumState
        d::Int            # Hilbert space dimension
        density::Matrix{ComplexF64}
        vectorized::Vector{ComplexF64}
        label::String
    end
"""
struct QuantumState
    d::Int
    density::Matrix{ComplexF64}
    vectorized::Vector{ComplexF64}
    label::String
end

"""
    struct Dissipator
        name::String
        operator::Matrix{ComplexF64}
        gamma::Float64
        position::Int
        params::Dict{Symbol,Any}
    end
"""
struct Dissipator
    name::String
    operator::Matrix{ComplexF64}
    gamma::Float64
    position::Int
    params::Dict{Symbol,Any}
end

end # module Types

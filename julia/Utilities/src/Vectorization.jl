module Vectorization

"""
    vectorize_density_matrix(dm::AbstractMatrix)
Convert density matrix to vectorized form (column-stacked).
"""
vectorize_density_matrix(dm::AbstractMatrix) = vec(dm)

"""
    devectorize_density_vector(vec::AbstractVector, d::Int)
Convert vectorized density back to d×d matrix.
"""
devectorize_density_vector(vec::AbstractVector, d::Int) = reshape(vec, d, d)

end # module Vectorization

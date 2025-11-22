module Utilities

using LinearAlgebra

"""
    validate_square_matrix(mat::AbstractMatrix, name::String)
Check if `mat` is square. Throws ArgumentError if not.
"""
function validate_square_matrix(mat::AbstractMatrix, name::String)
    size(mat,1) == size(mat,2) || throw(ArgumentError("$name must be a square matrix"))
end

"""
    validate_vector(vec::AbstractVector, name::String)
Check if `vec` is a 1D vector. Throws ArgumentError if not.
"""
function validate_vector(vec::AbstractVector, name::String)
    ndims(vec) == 1 || throw(ArgumentError("$name must be a vector"))
end

"""
    to_density_vector(dm::AbstractMatrix)
Vectorize a density matrix in column-major order.
"""
function to_density_vector(dm::AbstractMatrix)
    validate_square_matrix(dm, "Density matrix")
    return vec(dm)
end

"""
    from_density_vector(vec::AbstractVector, d::Int)
Reshape vectorized density back to d×d matrix.
"""
function from_density_vector(vec::AbstractVector, d::Int)
    validate_vector(vec, "Density vector")
    length(vec) == d^2 || throw(ArgumentError("Vector length must be d^2"))
    return reshape(vec, d, d)
end

"""
    kron2(A::AbstractMatrix, B::AbstractMatrix)
Compute the Kronecker product of matrices A and B.
"""
kron2(A::AbstractMatrix, B::AbstractMatrix) = kron(A, B)

end # module Utilities

module BasisTransforms

using LinearAlgebra

"""
    binary_basis_order(d::Int)
Return the computational basis ordered as binary strings of length d.
"""
function binary_basis_order(d::Int)
    # Returns list of basis state strings, e.g. ["00", "01", "10", "11"] for d=2
    return [bitstring(i)[end-d+1:end] for i in 0:(2^d-1)]
end

"""
    basis_transform_matrix(d::Int)
Returns the transformation matrix from the superoperator basis used in the code to the standard basis (column-stacked density matrices).
"""
function basis_transform_matrix(d::Int)
    # For now, returns identity
    # TODO: Implement explicit rearrangement if needed
    return Matrix{Float64}(I, d^2, d^2)
end

end # module BasisTransforms

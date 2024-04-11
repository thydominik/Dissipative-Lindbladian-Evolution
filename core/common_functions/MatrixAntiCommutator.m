function [C] = MatrixAntiCommutator(A, B)
    %MATRIXANTICOMMUTATOR takes two matricies and computes the anticommutator:
    %{A, B} = A*B + B*A
    
    size_a = size(A);
    size_b = size(B);
    
    if size_a ~= size_b
        warning("Matrix dimension mismatch")
    else
        C = A * B + B * A;
    end
end


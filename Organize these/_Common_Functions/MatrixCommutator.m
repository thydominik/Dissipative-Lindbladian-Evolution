function [C] = MatrixCommutator(A, B)
    %MATRIXCOMMUTATOR: Takes two matricies and produces their commutator:
    % [A, B] = A*B - B*A
    
    size_a = size(A);
    size_b = size(B);
    
    if size_a ~= size_b 
        warning("Matrix dimension mismatch")
    else
        C = A * B - B * A;
    end

end


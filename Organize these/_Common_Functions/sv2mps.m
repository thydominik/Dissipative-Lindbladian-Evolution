function [A] = sv2mps(StateVector, HDim)
    % sv2mpsmtx: State Vector to matrix product state matrix.
    % Initial State:
    A           = struct();

    A.data   = zeros(1, HDim, 1);   % first and third index: bonds, second index: physical leg 
    A.shape  = [1, 2, 1];
    
    A.data(1, 1, 1) = StateVector(1);
    A.data(1, 2, 1) = StateVector(2);

    A.Lambda = 1;
    
    





end


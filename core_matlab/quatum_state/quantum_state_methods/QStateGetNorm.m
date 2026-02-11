function [Trace] = QStateGetNorm(State)
    %QSTATEGETNORM: Function acts on a quantum state and gives back it's norm
    %as in trace(1|rho)
    
    IdentityVector = sparse([1 0 0 1]);
    for QIdx = 2:State.NumberOfQubits
        IdentityVector = kron(IdentityVector, [1 0 0 1]);
    end

    Trace = IdentityVector * State.DensityVector;

end


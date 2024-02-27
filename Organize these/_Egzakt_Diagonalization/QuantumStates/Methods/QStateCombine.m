function [State12] = QStateCombine(State1, State2, info)
    %QSTATECOMBINE: Takes two quantum states from left to right and combines
    %them, given these are separate systems. 
    % -------------------------------------------------------------------------
    % State1 - [Q State; struct] left q. state
    % State2 - [Q State; struct] right q. state
    
    CombinedNumberOfQubits  = State1.NumberOfQubits + State2.NumberOfQubits;
    CombinedDensityInput    = kron(State1.DensityVector, State2.DensityVector);
    if exist('info', 'var')    
        State12 = NQubitStateInit(CombinedNumberOfQubits, CombinedDensityInput, 'v', info);
    else
        State12 = NQubitStateInit(CombinedNumberOfQubits, CombinedDensityInput, 'v', '');
    end
end


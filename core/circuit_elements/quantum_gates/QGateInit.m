function [Gate, LindbladGate, HilbertGate] = QGateInit(GateInput, param1, param2, param3)
%QGATEINIT: Initializing a 1 qubit gate
    Gate = struct();
    if ischar(GateInput)
        
        Gate.Type = 'Unitary Q. Gate';

        if strcmp(GateInput, 'x') || strcmp(GateInput, 'X')              %Pauli X Gate
    
            GateMtx         = sparse([0 1; 1 0]);
            Gate.Info       = 'Pauli X gate';
            Gate.QubitNum   = 1;
            LindbladGate    = kron(GateMtx, conj(GateMtx));
        elseif strcmp(GateInput, 'y') || strcmp(GateInput, 'Y')           %Pauli Y Gate
    
            GateMtx         = sparse([0 -1i; 1i 0]);
            Gate.Info       = 'Pauli Y gate';
            Gate.QubitNum   = 1;
            LindbladGate    = kron(GateMtx, conj(GateMtx));
        elseif strcmp(GateInput, 'z') || strcmp(GateInput, 'Z')           %Pauli Z Gate
    
            GateMtx         = sparse([1 0; 0 -1]);
            Gate.Info       = 'Pauli Z gate';
            Gate.QubitNum   = 1;
            LindbladGate    = kron(GateMtx, conj(GateMtx));
        elseif strcmp(GateInput, '1') || strcmp(GateInput, 'e')

            GateMtx         = sparse(eye(2, 2));
            Gate.Info       = 'Unit gate';
            Gate.QubitNum   = 1;
            LindbladGate    = kron(GateMtx, conj(GateMtx));
        elseif strcmp(GateInput, 'h') || strcmp(GateInput, 'H') ||  strcmp(GateInput, 'hadamard')       %Hadamard Gate
    
            GateMtx         = 1/sqrt(2) * sparse([1 1; 1 -1]);
            Gate.Info       = '';
            Gate.QubitNum   = 1;
            LindbladGate    = kron(GateMtx, conj(GateMtx));
        elseif strcmp(GateInput, 't') || strcmp(GateInput, 'T')           %T Gate
    
            GateMtx         = sparse([1 0; 0 exp(0.25 * 1i * pi)]);
            Gate.Info       = '';
            Gate.QubitNum   = 1;
            LindbladGate    = kron(GateMtx, conj(GateMtx));
        elseif strcmp(GateInput, 's') || strcmp(GateInput, 'S')          %S Gate or sqrt(Z) gate; can be written as the phase gate
    
            GateMtx         = sparse([1 0; 0 exp(0.5 * 1i * pi)]);
            Gate.Info       = '';
            Gate.QubitNum   = 1;
            LindbladGate    = kron(GateMtx, conj(GateMtx));
        elseif strcmp(GateInput, 'u') || strcmp(GateInput, 'U')           %U Gate
    
            GateMtx         = sparse([cos(param1/2) -exp(1i * param3)*sin(param1/2); exp(1i * param2)*sin(param1/2) exp(1i*(param2 + param3))*(cos(param1/2))]);
            Gate.Info       = '';
            Gate.QubitNum   = 1;
            Gate.Parameters = [param1 param2 param3];
            LindbladGate    = kron(GateMtx, conj(GateMtx));
        elseif strcmp(GateInput, 'p') || strcmp(GateInput, 'P') || strcmp(GateInput, 'phase')   %Phase Gate
    
            GateMtx         = sparse([1 0; 0 exp(1i * param1)]);
            Gate.Info       = '';
            Gate.QubitNum   = 1;
            Gate.Parameters = [param1];
            LindbladGate    = kron(GateMtx, conj(GateMtx));
        elseif strcmp(GateInput, 'cr') || strcmp(GateInput, 'cR') || strcmp(GateInput, 'cphase') %jelöljem hogy mi a változó, lehetne egy külön qft kaput is gyártni.

            GateMtx         = sparse([1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 exp(2*pi*1i*(2^(-param1)))]);
            Gate.Info       = '';
            Gate.QubitNum   = 2;
            Gate.Parameters = [param1];
            LindbladGate    = BasisTransform(kron(GateMtx, conj(GateMtx)), 'operator', 2); %legyen beszédesebb neve
        elseif strcmp(GateInput, 'swap') || strcmp(GateInput, 'SWAP')
            
            GateMtx         = sparse([1 0 0 0; 0 0 1 0; 0 1 0 0; 0 0 0 1]);
            Gate.Info       = '';
            Gate.QubitNum   = 2;
            LindbladGate    = BasisTransform(kron(GateMtx, conj(GateMtx)), 'operator', 2);
        elseif strcmp(GateInput, 'CNOT') || strcmp(GateInput, 'cnot')
            
            GateMtx         = sparse([1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0]);
            Gate.Info       = '';
            Gate.QubitNum   = 2;
            LindbladGate    = BasisTransform(kron(GateMtx, conj(GateMtx)), 'operator', 2);
        end
    else                                        %Selfe defined gate with name of type
        warning('UserDefinedGate option is not fully developed! Better Watch out')
        GateMtx = (GateInput); 
        S = size(GateMtx);
        Gate.Info       = 'User defined operator gate';
        Gate.QubitNum   = log(S(1))/log(2); 
        LindbladGate    = BasisTransform(kron(GateMtx, conj(GateMtx)), 'operator', 2);
    end
    HilbertGate     = sparse(GateMtx);
    Gate.Type       = 'Quantum Gate';
    Gate.Operator   = LindbladGate;
end


function [Gate, LindbladGate, HilbertGate] = QGateInit(GateInput, param1, param2, param3)
%QGATEINIT: Iitializing a quantum gate acting on 1 or 2 qubits

% INPUT --------------------------------------
% GateInput - [matrix OR string], give a string that corresponds to a predefined quantum gate, or
% give a full matrix that will be set as a new quantum gate.
% param1/param2/param3 - [cplx number], some gates requires one or more parameters.
% INPUT --------------------------------------

Gate = struct();
if ischar(GateInput)

    Gate.Type = 'Unitary Q. Gate';

    if strcmp(GateInput, 'x') || strcmp(GateInput, 'X')              %Pauli X Gate

        GateMtx       = sparse([0 1;1 0]);
        Gate.Info     = 'Pauli X gate';
        Gate.QubitNum = 1;
        LindbladGate  = kron(GateMtx, conj(GateMtx));
    elseif strcmp(GateInput, 'y') || strcmp(GateInput, 'Y')           %Pauli Y Gate

        GateMtx       = sparse([0 -1i;1i 0]);
        Gate.Info     = 'Pauli Y gate';
        Gate.QubitNum = 1;
        LindbladGate  = kron(GateMtx, conj(GateMtx));
    elseif strcmp(GateInput, 'z') || strcmp(GateInput, 'Z')           %Pauli Z Gate

        GateMtx       = sparse([1 0;0 -1]);
        Gate.Info     = 'Pauli Z gate';
        Gate.QubitNum = 1;
        LindbladGate  = kron(GateMtx, conj(GateMtx));
    elseif strcmp(GateInput, '1') || strcmp(GateInput, 'e')

        GateMtx       = sparse(eye(2, 2));
        Gate.Info     = 'Unit gate';
        Gate.QubitNum = 1;
        LindbladGate  = kron(GateMtx, conj(GateMtx));
    elseif strcmp(GateInput, 'h') || strcmp(GateInput, 'H') ||  strcmp(GateInput, 'hadamard')       %Hadamard Gate

        GateMtx       = 1/sqrt(2) * sparse([1 1;1 -1]);
        Gate.Info     = '';
        Gate.QubitNum = 1;
        LindbladGate  = kron(GateMtx, conj(GateMtx));
    elseif strcmp(GateInput, 't') || strcmp(GateInput, 'T')           %T Gate

        GateMtx       = sparse([1 0;0 exp(0.25 * 1i * pi)]);
        Gate.Info     = '';
        Gate.QubitNum = 1;
        LindbladGate  = kron(GateMtx, conj(GateMtx));
    elseif strcmp(GateInput, 's') || strcmp(GateInput, 'S')          %S Gate or sqrt(Z) gate; can be written as the phase gate

        GateMtx       = sparse([1 0;0 exp(0.5 * 1i * pi)]);
        Gate.Info     = '';
        Gate.QubitNum = 1;
        LindbladGate  = kron(GateMtx, conj(GateMtx));
    elseif strcmp(GateInput, 'u') || strcmp(GateInput, 'U')           %U Gate

        GateMtx         = sparse([cos(param1/2) -exp(1i * param3)*sin(param1/2);exp(1i * param2)*sin(param1/2) exp(1i*(param2 + param3))*(cos(param1/2))]);
        Gate.Info       = '';
        Gate.QubitNum   = 1;
        Gate.Parameters = [param1 param2 param3];
        LindbladGate    = kron(GateMtx, conj(GateMtx));
    elseif strcmp(GateInput, 'p') || strcmp(GateInput, 'P') || strcmp(GateInput, 'phase')   %Phase Gate

        GateMtx         = sparse([1 0;0 exp(1i * param1)]);
        Gate.Info       = '';
        Gate.QubitNum   = 1;
        Gate.Parameters = [param1];
        LindbladGate    = kron(GateMtx, conj(GateMtx));
    elseif strcmp(GateInput, 'cr') || strcmp(GateInput, 'cR') || strcmp(GateInput, 'cphase') %jelöljem hogy mi a változó, lehetne egy külön qft kaput is gyártni.

        GateMtx         = sparse([1 0 0 0;0 1 0 0; 0 0 1 0; 0 0 0 exp(2*pi*1i*(2^(-param1)))]);
        Gate.Info       = '';
        Gate.QubitNum   = 2;
        Gate.Parameters = [param1];
        LindbladGate    = BasisTransform(kron(GateMtx, conj(GateMtx)), 'operator', 2); %legyen beszédesebb neve
    elseif strcmp(GateInput, 'swap') || strcmp(GateInput, 'SWAP')

        GateMtx       = sparse([1 0 0 0;0 0 1 0; 0 1 0 0; 0 0 0 1]);
        Gate.Info     = '';
        Gate.QubitNum = 2;
        LindbladGate  = BasisTransform(kron(GateMtx, conj(GateMtx)), 'operator', 2);
    elseif strcmp(GateInput, 'CNOT') || strcmp(GateInput, 'cnot')

        GateMtx       = sparse([1 0 0 0;0 1 0 0; 0 0 0 1; 0 0 1 0]);
        Gate.Info     = '';
        Gate.QubitNum = 2;
        LindbladGate  = BasisTransform(kron(GateMtx, conj(GateMtx)), 'operator', 2);
    else
        error("The string given is not corresponding to a predifened quantum gate. Possible choices are {x, y, z, e, h, T, S, U(3 params), p(1 param), cR(1 param), swap, cnot}")
    end
else
    [Row, Col] = size(GateInput);
    if Row ~= Col
        error("Given GateInput is not a square matrix");
    end

    if mod(log2(Row), 1) ~= 0
        error("GateInput in not sized correctly")
    end

    GateMtx       = (GateInput);
    S             = size(GateMtx);
    Gate.Info     = 'User defined operator gate';
    Gate.QubitNum = log(S(1))/log(2);
    LindbladGate  = BasisTransform(kron(GateMtx, conj(GateMtx)), 'operator', Gate.QubitNum);
end

HilbertGate   = sparse(GateMtx);    %this variable gives back the gate in Hilbert space
Gate.Type     = 'Quantum Gate';
Gate.Operator = LindbladGate;
end

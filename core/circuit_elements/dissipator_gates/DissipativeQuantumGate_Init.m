function [Gate] = DissipativeQuantumGate_Init(GateInput, param1)
% DISSIPATIVEQUANTUMGATE_INIT - Initializes a dissipative quantum gate with a possibility of a
% parameter. Dissipative gates have a time duration and all three pauli dissipators are put besides
% the quantum gate. The strength of such dissipations can be set with a function handle.

% INPUT --------------------------------------------------
% GateInput - [string], Defines the dissipator
% param1 - [general number], [optional], parameter for a more general gate. In case of a gate
% where there is no parameter (like hadamard) this will be ignored.
% INPUT --------------------------------------------------

Gate        = struct();
Gate.Type   = 'Dissipative Quantum Gate';

if ischar(GateInput)
    if strcmp(GateInput, 'x') || strcmp(GateInput, 'X')              %Pauli X Gate
        GateMtx         = sparse(Pauli('x'));       % Pauli matrix representation in Hilbert space
        Gate.Info       = 'Pauli X gate';           % Info field, for the type of the
        Gate.Unitarity  = 1;
        Gate.QubitNum   = 1;                        % The number of Qubit affected by this gate
        HamiltonianGate = kron(GateMtx, eye(2)) - kron(eye(2), GateMtx');   % Gate construction
        Gate.Duration   = pi/2;
        % The Name 'HamiltonianGate' comes from the fact that the
        % action of sigma_x is handled like a time evolution.
        % Gate.Duration will handle the proper timing of the gate
        % in order to form a full sigma_x gate.
    end

    if strcmp(GateInput, 'y') || strcmp(GateInput, 'Y')
        GateMtx         = sparse(Pauli('y'));
        Gate.Info       = 'Pauli Y gate';
        Gate.Unitarity  = 1;
        Gate.QubitNum   = 1;
        HamiltonianGate = kron(GateMtx, eye(2)) - kron(eye(2), GateMtx.');
        Gate.Duration   = pi/2;
    end

    if strcmp(GateInput, 'z') || strcmp(GateInput, 'Z')
        GateMtx         = sparse(Pauli('z'));
        Gate.Info       = 'Pauli Z gate';
        Gate.Unitarity  = 1;
        Gate.QubitNum   = 1;
        HamiltonianGate = kron(GateMtx, eye(2)) - kron(eye(2), GateMtx.');
        Gate.Duration   = pi/2;
    end

    if strcmp(GateInput, '1') || strcmp(GateInput, 'id')
        GateMtx         = sparse(eye(2));
        Gate.Info       = 'Identity gate';
        Gate.Unitarity  = 1;
        Gate.QubitNum   = 1;
        HamiltonianGate = kron(GateMtx, eye(2)) - kron(eye(2), GateMtx.');
        Gate.Duration   = pi/2;
    end

    if strcmp(GateInput, 'h') || strcmp(GateInput, 'H') ||  strcmp(GateInput, 'hadamard')
        GateMtx         = 1/sqrt(2) * sparse([1 1; 1 -1]);
        Gate.Info       = 'Hadamard gate';
        Gate.Unitarity  = 1;
        Gate.QubitNum   = 1;
        HamiltonianGate = (kron(GateMtx, eye(2)) - kron(eye(2), GateMtx.'));
        Gate.Duration   = pi/2;
    end

    if strcmp(GateInput, 't') || strcmp(GateInput, 'T')
        GateMtx                 = sparse([1 0; 0 exp(0.25 * 1i * pi)]);
        Gate.Info               = 'T gate - Special Phase';
        Gate.Unitarity          = 0;
        Gate.QubitNum           = 1;
        Gate.Effective_GateMtx  = sparse(diag([0 -1i 1i 0]));
        HamiltonianGate         = Gate.Effective_gateMtx;
        Gate.Duration           = 0.25 * pi;
    end

    if strcmp(GateInput, 'sqrtz') || strcmp(GateInput, 'sqrtZ')
        GateMtx                 = sparse([1 0; 0 1i]);
        Gate.Info               = 'sqrt(Z)';
        Gate.Unitarity          = 0;
        Gate.QubitNum           = 1;
        Gate.Effective_GateMtx  = sparse(diag([0 -1i 1i 0]));
        HamiltonianGate         = Gate.Effective_gateMtx;
        Gate.Duration           = 0.5 * pi;
    end

    if strcmp(GateInput, 'CNot') || strcmp(GateInput, 'Cnot') || strcmp(GateInput, 'CNOT')
        GateMtx         = sparse([1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0]);
        Gate.Info       = 'Controlled Not';
        Gate.Unitarity  = 1;
        Gate.QubitNum   = 2;
        HamiltonianGate = BasisTransform(kron(GateMtx, eye(4)) - kron(eye(4), GateMtx.'), 'o', 2);
        Gate.Duration   = pi/2;
    end
    if strcmp(GateInput, 'CRot') || strcmp(GateInput, 'Crot') || strcmp(GateInput, 'CROT')
        GateMtx                 = sparse([1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 exp(2*pi*1i*(2^(-param1)))]);
        Gate.Info               = 'Controlled Rotation w/ parameter';
        Gate.Unitarity          = 1;
        Gate.QubitNum           = 2;
        %HamiltonianGate = BasisTransform(kron(GateMtx, eye(4)) - kron(eye(4), (GateMtx).'), 'o', 2);
        Gate.Effective_GateMtx  = sparse(diag([0 0 0 1i]));
        HamiltonianGate         = 1i* BasisTransform(kron(Gate.Effective_GateMtx, eye(4)) - kron(eye(4), (Gate.Effective_GateMtx).'), 'o', 2);
        Gate.Duration           = 2*pi/(2^param1);
    end
end

if Gate.QubitNum == 1
    Dissipator_X    = @(g1) g1 * (kron(Pauli('x'), Pauli('x').') - eye(4));
    Dissipator_Y    = @(g2) g2 * (kron(Pauli('y'), Pauli('y').') - eye(4));
    Dissipator_Z    = @(g3) g3 * (kron(Pauli('z'), Pauli('z').') - eye(4));

    Dissipator_Full = @(g1, g2, g3) (Dissipator_X(g1) + Dissipator_Y(g2) + Dissipator_Z(g3));

    Gate.Operator   = @(g1, g2, g3) (-1i * HamiltonianGate + Dissipator_Full(g1, g2, g3));


elseif Gate.QubitNum == 2
    F_X_1   = kron(Pauli('x'), eye(2));
    FF_X_1  = @(x1) x1 * BasisTransform(kron(F_X_1, F_X_1.') - eye(16), 'o', 2);
    F_X_2   = kron(eye(2), Pauli('x'));
    FF_X_2  = @(x2) x2 * BasisTransform(kron(F_X_2, F_X_2.') - eye(16), 'o', 2);
    FF_X    = @(x1, x2) FF_X_1(x1) + FF_X_2(x2);

    F_Y_1   = kron(Pauli('y'), eye(2));
    FF_Y_1  = @(y1) y1 * BasisTransform(kron(F_Y_1, F_Y_1.') - eye(16), 'o', 2);
    F_Y_2   = kron(eye(2), Pauli('y'));
    FF_Y_2  = @(y2) y2 * BasisTransform(kron(F_Y_2, F_Y_2.') - eye(16), 'o', 2);
    FF_Y    = @(y1, y2) FF_Y_1(y1) + FF_Y_2(y2);

    F_Z_1   = kron(Pauli('z'), eye(2));
    FF_Z_1  = @(z1) z1 * BasisTransform(kron(F_Z_1, F_Z_1.') - eye(16), 'o', 2);
    F_Z_2   = kron(eye(2), Pauli('z'));
    FF_Z_2  = @(z2) z2 * BasisTransform(kron(F_Z_2, F_Z_2.') - eye(16), 'o', 2);
    FF_Z    = @(z1, z2) FF_Z_1(z1) + FF_Z_2(z2);

    Dissipator_full = @(x1, x2, y1, y2, z1, z2) FF_X(x1, x2) + FF_Y(y1, y2) + FF_Z(z1, z2);
    Gate.Operator   = @(x1, x2, y1, y2, z1, z2) Dissipator_full(x1, x2, y1, y2, z1, z2) - (1i* HamiltonianGate);
    %Gate.Operator   = @(x1, x2, y1, y2, z1, z2) Dissipator_full(x1, x2, y1, y2, z1, z2);
end

end


function [NewState] = QStateActDissipator(QSystem, DissipatorGate, Rate, ActingOn, Interval)
% gets the quantum system object and acts on that with a dissipator with user defined rates, qubits

% Note: do not modify!

% INPUT -----------------
% QSystem - [Quantum system], a quantum system object containing all the the qubits that we are interested in
% DissipatorGate - [quantum gate, dissipator]
% rate - [double, pozitive, non-complex], \Gamma in the lindbladian equation
% AtcingOn - [Integer], specifies which qubit is targeted by the dissipation
% Interval - [Double, positive, non-complex] deteremins how long the above specified dissipator will
% act on the system.
% INPUT -----------------

if ischar(ActingOn) && strcmp(ActingOn, 'All')
    Dissipator = expm(Interval * (kron(DissipatorGate.Operator(Rate), DissipatorGate.Operator(Rate).') - (Rate * eye(4))));

    for QubitInd = 1:QSystem.NumberOfQubits
        %[NewDensityVector, Shape, S1, S2, t1, t2] = OLD_NTblockdot(reshape(QSystem.DensityVector, 4 * ones(1, QSystem.NumberOfQubits)), Dissipator, [QubitInd], [1], 4 * ones(1, QSystem.NumberOfQubits), size(Dissipator));
        [NewDensityVector, ~, ~, ~, ~, ~] = OLD_NTblockdot(reshape(QSystem.DensityVector, 4 * ones(1, QSystem.NumberOfQubits)), Dissipator, [QubitInd], [1], 4 * ones(1, QSystem.NumberOfQubits), size(Dissipator));
        
        NewState = NQubitStateInit(QSystem.NumberOfQubits, reshape(NewDensityVector, [4^(QSystem.NumberOfQubits) 1]) , 'v');
    end
else
    if QSystem.NumberOfQubits == 1
        Dissipator          = expm(Interval * (kron(DissipatorGate.Operator(Rate), DissipatorGate.Operator(Rate).') - Rate*eye(4)));
        NewDensityVector    = Dissipator * QSystem.DensityVector;
        NewState            = NQubitStateInit(QSystem.NumberOfQubits, reshape(NewDensityVector, [4^(QSystem.NumberOfQubits) 1]) , 'v');
    else
        ActingOn    = QSystem.NumberOfQubits - ActingOn + 1;
        
        Dissipator  = expm(Interval * (kron(DissipatorGate.Operator(Rate), DissipatorGate.Operator(Rate).') - Rate*eye(4)));
        %[NewDensityVector, Shape, S1, S2, t1, t2] = OLD_NTblockdot(reshape(QSystem.DensityVector, 4 * ones(1, QSystem.NumberOfQubits)), Dissipator, [ActingOn], [1], 4 * ones(1, QSystem.NumberOfQubits), size(Dissipator));
        [NewDensityVector, ~, ~, ~, ~, ~] = OLD_NTblockdot(reshape(QSystem.DensityVector, 4 * ones(1, QSystem.NumberOfQubits)), Dissipator, [ActingOn], [1], 4 * ones(1, QSystem.NumberOfQubits), size(Dissipator));
        
        NewState = NQubitStateInit(QSystem.NumberOfQubits, reshape(NewDensityVector, [4^(QSystem.NumberOfQubits) 1]) , 'v');
    end
end


function [NewState, NewDensityVector, t1, t2] = QStateActGate(Gate, QSystem, ActingOn, NoQ, Rates)
% gets the quantum system object and acts on that with a quantum gate

% Note: do not modify!

% INPUT -----------------
% QSystem - [Quantum system], a quantum system object containing all the the qubits that we are interested in
% Gate - [quantum gate]
% rate - [double, pozitive, non-complex], \Gamma in the lindbladian equation
% AtcingOn - [Integer], specifies which qubit is targeted by the dissipation
% INPUT -----------------

Threshold = 10^-14;

if strcmp(Gate.Type,'Dissipative Quantum Gate')
    if QSystem.NumberOfQubits == 1
        temp_Rates = num2cell(Rates);
        Exponential_Gate    = expm(Gate.Operator(temp_Rates{:}) * Gate.Duration);
        Exponential_Gate    = real(Exponential_Gate).*(abs(real(Exponential_Gate))>Threshold) + 1i* imag(Exponential_Gate).*(abs(imag(Exponential_Gate))>Threshold);

        NewDensityVector    = Exponential_Gate * QSystem.DensityVector;
        NewState            = NQubitStateInit(QSystem.NumberOfQubits, reshape(NewDensityVector, [4^(QSystem.NumberOfQubits) 1]) , 'v');
    else

        ActingOn            = QSystem.NumberOfQubits - ActingOn + 1;

        temp_Rates          = num2cell(Rates);
        
        Exponential_Gate    = expm(Gate.Operator(temp_Rates{:}) * Gate.Duration);
        Exponential_Gate    = real(Exponential_Gate).*(abs(real(Exponential_Gate))>Threshold) + 1i* imag(Exponential_Gate).*(abs(imag(Exponential_Gate))>Threshold);

        %[NewDensityVector, Shape, S1, S2, t1, t2] = OLD_NTblockdot(reshape(QSystem.DensityVector, 4 * ones(1, QSystem.NumberOfQubits)), Exponential_Gate, [ActingOn], [1], 4 * ones(1, QSystem.NumberOfQubits), size(Exponential_Gate));
        [NewDensityVector, ~, ~, ~, ~, ~] = OLD_NTblockdot(reshape(QSystem.DensityVector, 4 * ones(1, QSystem.NumberOfQubits)), Exponential_Gate, [ActingOn], [1], 4 * ones(1, QSystem.NumberOfQubits), size(Exponential_Gate));
        
        NewState = NQubitStateInit(QSystem.NumberOfQubits, reshape(NewDensityVector, [4^(QSystem.NumberOfQubits) 1]) , 'v');
    end
else
    if QSystem.NumberOfQubits == 1
        NewDensityVector    = Gate.Operator * QSystem.DensityVector;
        NewState            = NQubitStateInit(QSystem.NumberOfQubits, reshape(NewDensityVector, [4^(QSystem.NumberOfQubits) 1]) , 'v');

    else
        ActingOn = QSystem.NumberOfQubits - ActingOn + 1;

        %[NewDensityVector, Shape, S1, S2, t1, t2] = OLD_NTblockdot(reshape(QSystem.DensityVector, 4 * ones(1, QSystem.NumberOfQubits)), Gate.Operator, [ActingOn], [1], 4 * ones(1, QSystem.NumberOfQubits), size(Gate.Operator));
        [NewDensityVector, ~, ~, ~, ~, ~] = OLD_NTblockdot(reshape(QSystem.DensityVector, 4 * ones(1, QSystem.NumberOfQubits)), Gate.Operator, [ActingOn], [1], 4 * ones(1, QSystem.NumberOfQubits), size(Gate.Operator));
        
        NewState    = NQubitStateInit(QSystem.NumberOfQubits, reshape(NewDensityVector, [4^(QSystem.NumberOfQubits) 1]) , 'v');
    end
end
end


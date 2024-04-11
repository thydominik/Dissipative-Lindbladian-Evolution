function [NewState] = QStateActDissipator(QSystem, DissipatorGate, Rate, ActingOn, Interval)

if ischar(ActingOn) && strcmp(ActingOn, 'All')
    Dissipator = expm(Interval * (kron(DissipatorGate.Operator(Rate), DissipatorGate.Operator(Rate).') - Rate*eye(4)));
    for QubitInd = 1:QSystem.NumberOfQubits
        [NewDensityVector, Shape, S1, S2, t1, t2] = OLD_NTblockdot(reshape(QSystem.DensityVector, 4 * ones(1, QSystem.NumberOfQubits)), Dissipator, [QubitInd], [1], 4 * ones(1, QSystem.NumberOfQubits), size(Dissipator));
        NewState = NQubitStateInit(QSystem.NumberOfQubits, reshape(NewDensityVector, [4^(QSystem.NumberOfQubits) 1]) , 'v');
    end
else
    if QSystem.NumberOfQubits == 1
        Dissipator          = expm(Interval * (kron(DissipatorGate.Operator(Rate), DissipatorGate.Operator(Rate).') - Rate*eye(4)));
        NewDensityVector    = Dissipator * QSystem.DensityVector;
        NewState            = NQubitStateInit(QSystem.NumberOfQubits, reshape(NewDensityVector, [4^(QSystem.NumberOfQubits) 1]) , 'v');
    else
        ActingOn = QSystem.NumberOfQubits - ActingOn + 1;
        Dissipator = expm(Interval * (kron(DissipatorGate.Operator(Rate), DissipatorGate.Operator(Rate).') - Rate*eye(4)));
        [NewDensityVector, Shape, S1, S2, t1, t2] = OLD_NTblockdot(reshape(QSystem.DensityVector, 4 * ones(1, QSystem.NumberOfQubits)), Dissipator, [ActingOn], [1], 4 * ones(1, QSystem.NumberOfQubits), size(Dissipator));

        NewState = NQubitStateInit(QSystem.NumberOfQubits, reshape(NewDensityVector, [4^(QSystem.NumberOfQubits) 1]) , 'v');
    end
    

end


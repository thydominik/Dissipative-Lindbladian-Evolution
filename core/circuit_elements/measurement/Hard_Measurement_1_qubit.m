function [OutQState, Measurement] = Hard_Measurement_1_qubit(QSystem, ActingOn)

% Taking a measurment on qubit 'ActingOn'

id = [1 0 0 1];
m0 = [1 0 0 0];
m1 = [0 0 0 1];

NoQ = QSystem.NumberOfQubits;
if NoQ == 1 && ActingOn == 1
    M0 = m0;
    M1 = m1;
    alphasq = m0 * QSystem.DensityVector;
    betasq  = m1 * QSystem.DensityVector;
elseif NoQ == 1 && ActingOn ~= 1
    error('There is no qubit to measure, check the target qubit number!')
elseif NoQ > 1 && ActingOn <= NoQ && ActingOn > 0
    if ActingOn == 1
        M0 = kron(m0, id);
        for QubitInd = 3:NoQ
            M0 = kron(M0, id);
        end

        M1 = kron(m1, id);
        for QubitInd = 3:NoQ
            M1 = kron(M1, id);
        end
    else
        M0 = id;
        for QubitInd = 2:NoQ
            if QubitInd == ActingOn
                M0 = kron(M0, m0);
            else
                M0 = kron(M0, id);
            end
        end

        M1 = id;
        for QubitInd = 2:NoQ
            if QubitInd == ActingOn
                M1 = kron(M1, m1);
            else
                M1 = kron(M1, id);
            end
        end
    end

    alphasq = M0 * QSystem.DensityVector;
    betasq  = M1 * QSystem.DensityVector;
elseif ActingOn > NoQ
    error('THere is no qubit to measure, check the target qubit number')
end

Measureing_rnd = rand();
OutQState = QSystem;
if Measureing_rnd <= alphasq
    result  = '|0>';
    prob    = alphasq;
    OutQState.DensityVector = M0.' .* QSystem.DensityVector;
    OutQState.DensityVector = OutQState.DensityVector / (QStateGetNorm(OutQState));
else
    result  = '|1>';
    prob    = betasq;
    OutQState.DensityVector = M1.' .* QSystem.DensityVector;
    OutQState.DensityVector = OutQState.DensityVector / (QStateGetNorm(OutQState));
end

Measurement.Probabilities   = [alphasq betasq];
Measurement.OperatorG       = M0;
Measurement.OperatorE       = M1;
Measurement.Result          = result;
Measurement.RandomVar       = Measureing_rnd;
OutQState.ExtraInfo         = [OutQState.ExtraInfo 'M_' num2str(ActingOn) ' = ' result '; '];

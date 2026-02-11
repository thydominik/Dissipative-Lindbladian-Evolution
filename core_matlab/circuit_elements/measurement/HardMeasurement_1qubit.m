function [OutQState, Measurement] = HardMeasurement_1qubit(QSystem, ActingOn)

% HARD_MEASUREMENT_1_QUBIT - This function will perform a measurement on a specific qubit, then
% Taking a measurment on qubit 'ActingOn'

% INPUT --------------------------------------------------
% QSystem - [quantum system], specify on which system you want to perform the measurement.
% Acting on - [poz. integer], specify which qubit you want to measure.
% INPUT --------------------------------------------------

% Measurement vectors
identity = [1 0 0 1];
measure_0 = [1 0 0 0];
measure_1 = [0 0 0 1];

% Number of qubits in the system
NoQ = QSystem.NumberOfQubits;

if NoQ == 1 && ActingOn == 1 % there is only one qubit and we want to measure that
    % M0 and M1 are the measurement vectors for the whole quantum system.
    M0      = measure_0;
    M1      = measure_1;

    %measurement result
    alphasq = measure_0 * QSystem.DensityVector;
    betasq  = measure_1 * QSystem.DensityVector;

elseif NoQ == 1 && ActingOn ~= 1 % there is only one qubit but the user gave a different qubit to measure.
    error('There is no qubit to measure, check the target qubit number!')

elseif NoQ > 1 && ActingOn <= NoQ && ActingOn > 0 % there are more than one qubits in the system and we measure one that is not the last one
    if ActingOn == 1
        M0 = kron(measure_0, identity);

        for QubitInd = 3:NoQ
            M0 = kron(M0, identity);
        end

        M1 = kron(measure_1, identity);

        for QubitInd = 3:NoQ
            M1 = kron(M1, identity);
        end

    else
        M0 = identity;

        for QubitInd = 2:NoQ
            if QubitInd == ActingOn
                M0 = kron(M0, measure_0);
            else
                M0 = kron(M0, identity);
            end
        end

        M1 = identity;

        for QubitInd = 2:NoQ
            if QubitInd == ActingOn
                M1 = kron(M1, measure_1);
            else
                M1 = kron(M1, identity);
            end
        end
    end

    % Measurement result
    alphasq = M0 * QSystem.DensityVector;
    betasq  = M1 * QSystem.DensityVector;

elseif ActingOn > NoQ
    error('THere is no qubit to measure, check the target qubit number')
end % if else - qubit number and acting on

% Generating a random number and getting the measurement result
Measureing_rnd  = rand();

OutQState       = QSystem;
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

end
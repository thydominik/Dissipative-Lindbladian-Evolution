function [TracedSystem, SubSystem_Trace] = QStatePartialTrace(State, Qubits)
% QSTATEPARTIALTRACE: Takes a Quantum state and gives back the 'Qubit's
% density matrix, tracing out all other qubits

% INPUTS -------------------------------------------------------------------------
% State - [QState struct] Quantum State
% Qubit - [int] [vector] The specific qubit that will be given back
% INPUTS -------------------------------------------------------------------------

NoQ = State.NumberOfQubits; % Number of qubits in the whole system

System_size = size(unique(Qubits));

if System_size(1) > 1 && System_size(2) > 1
    error('QStatePartialTrace: The dimension of the Qubit vector is not appropriate for the function, should be a 1 by N vector.')
else
    System_size = max(System_size);
end

if System_size == 1     % Only 1 qubit will remain after the partial trace:
    if Qubits > NoQ || Qubits <= 0     % Simple check for qubit consistency: One cannot act on the 4th qubit if there is only 3
        error('QStatePartialTrace: Uh oh, no qubit there mate')
    end

    DensityVectorTemp = zeros(1, 4); % Memory Alloc. ....

    % Idea: Indexing with binary numbers
    for i = 1:2
        for j = 1:2
            DensityVectorTemp(2 * (i - 1) + j) = 0;
            for m = 0:(2^(NoQ - 1) - 1)
                % Create an 'NoQ-1' long bit string, with value 'm', then
                % flip the bits order.
                %index_temp = flip(de2bi(m, NoQ - 1));
                index_temp = flip(int2bit(m, NoQ - 1));

                % we get previously something like 001, for the partial
                % trace we need the 'diagonals' of the system (that we
                % trace out) so duplicate every bit: 0 0 1 --> 00 00 11
                index_temp = repelem(index_temp, 2);

                % Build up the density vector index 'alpha' from the left
                % considering that we want the result to be the 'Qubit'th
                % qubit density vector
                alphaLeft  = [index_temp(1:((Qubits - 1) * 2)) (i - 1) (j - 1)];
                alphaRight = [index_temp((Qubits - 1) * 2 + 1 : end)];
                alpha      = [alphaLeft(:)' alphaRight(:)'];

                %Binary goes from 0 but matlab indexes from 1 hence the +1
                %alphaIdx = bi2de(flip(alpha)) + 1;
                alphaIdx = bit2int(flip(alpha)', length(alpha)) + 1;

                % Sum up for all combinations of 'index_temp'
                DensityVectorTemp(2 * (i - 1) + j) = DensityVectorTemp(2 * (i - 1) + j) + State.DensityVector(alphaIdx);

            end
        end
    end

    % Create the new state with the new traced out subsystem
    TracedSystem = NQubitStateInit(1, DensityVectorTemp.', 'v', ['Partial Traced the ' num2str(Qubits) 'th qubit from ' num2str(NoQ) ' qubit system']);
    %warning('QStatePartialTrace: Not apropriate messege by the QPartialTrace function when operatoring')
    % and also give back the trace of said subsystem
    SubSystem_Trace = QStateGetNorm(TracedSystem);
else
    % Idea: Taking the tensor prodcut of the all 1 matrix and the
    % trace operator in Liouville space.

    % This is an array containing the vector [1 0 0 0] as many times as
    % many qubits we'll get back after the tracing.
    Indexing_operator   = repmat([1 0 0 0], [1, System_size]);
    Measureing_operator = [1 0 0 1];

    % Constructing the whole system operator where we need to put the
    % indexing perators in the right places
    for alpha_ind = 1:(2^(2 * System_size))   % Going trough the indicies of the new density vector
        if any(Qubits == 1)
            T = Indexing_operator(1:4);
            k = 2;
        else
            T = Measureing_operator;
            k = 1;
        end

        for qubit_ind = 2:NoQ
            if any(Qubits == qubit_ind)
                %4 * (k - 1) + 1 : 4 * (k)
                T = kron(T, Indexing_operator(4 * (k - 1) + 1 : 4 * (k)));
                k = k + 1;
            else
                T = kron(T, Measureing_operator);
            end
        end

        Density_Vector_temp(alpha_ind) = T * State.DensityVector;

        Indexing_operator = Updateb(Indexing_operator);
    end
    % Create the new state with the new traced out subsystem
    TracedSystem = NQubitStateInit(System_size, Density_Vector_temp.', 'v');
    %warning('QStatePartialTrace: Fix messege when tracing out multiple qubits.')

    % and also give back the trace of said subsystem
    SubSystem_Trace = QStateGetNorm(TracedSystem);
end
end

function a = Updateb(a)
[ind] = find(a == 1, 1, 'last');
if mod(ind, 4) == 0
    if ind == max(size(a))
        a(end)   = 0;
        a(end-3) = 1;
        a        = [Updateb(a(1:end - 4)) 1 0 0 0];
    else

    end
else
    a(ind)   = 0;
    a(ind+1) = 1;
end
end
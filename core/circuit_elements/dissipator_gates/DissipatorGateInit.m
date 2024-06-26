function [SystemDissipator] = DissipatorGateInit(DissipatorArray, RatesArray, NumberOfQubits, Duration)
% DISSIPATORGATEINIT - Creates a dissipator gate with preset duration, qubitnumber and dissipation
% rates.

% Note: Good if we have a complicated dissipator structure and the rates are not changing througout
% the run.

% INPUT --------------------------------------------------
% DissipatorArray - [array, dissipators], contains all the dissipators that we want to use on the system. 
% RatesArray - [array, double], the rates for the individual dissipato gates
% NumberOfQubits - [integer], number of qubits in the system 
% Duration - [double], what is the duration of a given gate 
% INPUT --------------------------------------------------

if NumberOfQubits ~= length(RatesArray)
    warning('temporary warning message: qubit number and dissipator number is different, no probs tho')
end

SystemDissipator.Info           = 'Dissipator gate for the whole system';
SystemDissipator.Type           = 'Dissipator Gate';
SystemDissipator.NumberOfQubits = NumberOfQubits;

Lindbladian = 0;
for i = 1:length(DissipatorArray)
    Operator_temp   = DissipatorArray(i);
    ActOnQubit      = Operator_temp.ActingOnQubit;
    Operator_temp   = Operator_temp.Operator(RatesArray(i));

    F           = kron(kron(speye(2^((ActOnQubit - 1))), Operator_temp), speye(2^((NumberOfQubits - ActOnQubit))));
    FctF        = F' * F;
    AntiComm    = kron(FctF, speye(2^NumberOfQubits)) + kron(speye(2^NumberOfQubits), FctF);
    FF          = kron(F, conj(F));
    Lindbladian = Lindbladian + 1i * 0.5 * (2 * FF - AntiComm);
end

for i = 1 : 2^(2 * NumberOfQubits)
    num     = i - 1;
    %binary  = flip(de2bi(num, 2 * NumberOfQubits))
    binary  = flip(int2bit(num, 2 * NumberOfQubits));

    binary(1, 1:(2 * NumberOfQubits)) = binary(1, [1:2:(2 * NumberOfQubits) 2:2:(2 * NumberOfQubits)]);

    %ind(i) = bi2de(flip(binary)) + 1;
    ind(i) = bit2int(flip(binary), length(binary)) + 1;
end

OriginalIndex = 1:2^(2*NumberOfQubits);
Lindbladian(:, OriginalIndex) = Lindbladian(:, ind);
Lindbladian(OriginalIndex, :) = Lindbladian(ind, :);

SystemDissipator.Operator = Lindbladian;
SystemDissipator.Duration = Duration;
end


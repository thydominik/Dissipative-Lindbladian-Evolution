function [SystemDissipator] = DissipatorGateInit(DissipatorArray, RatesArray, NumberOfQubits, Duration)
%QSTATEACTDISSIPATOR:
    % No Hamiltonian now
%     arguments
%         DissipatorArray 
%         RatesArray {MustBeNonZeroLength, mustBeNumeric, mustBeReal}
%         NumberOfQubits
%         Duration {mustBeNonzero}
%     end
    
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
        
        F           = kron(kron(speye(2^((ActOnQubit-1))), Operator_temp), speye(2^((NumberOfQubits-ActOnQubit))));
        FctF        = F' * F;
        AntiComm    = kron(FctF, speye(2^NumberOfQubits)) + kron(speye(2^NumberOfQubits), FctF);
        FF          = kron(F, conj(F));
        Lindbladian = Lindbladian + 1i * 0.5 * (2 * FF - AntiComm);
    end
    
    for i = 1 : 2^(2*NumberOfQubits)
        num = i - 1;
        binary = flip(de2bi(num, 2*NumberOfQubits));
        binary(1, 1:(2*NumberOfQubits)) = binary(1, [1:2:(2*NumberOfQubits) 2:2:(2*NumberOfQubits)]);
        ind(i) = bi2de(flip(binary)) + 1;
    end

    OriginalIndex = 1:2^(2*NumberOfQubits);
    Lindbladian(:, OriginalIndex) = Lindbladian(:, ind);
    Lindbladian(OriginalIndex, :) = Lindbladian(ind, :);


    SystemDissipator.Operator = Lindbladian;
    SystemDissipator.Duration = Duration;
end


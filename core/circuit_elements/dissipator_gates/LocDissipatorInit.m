function [Dissipator] = LocDissipatorInit(DissipatorInput)
    %LOCDISSIPATORINIT
    % Input
    % OutPut
    % Mit csinál?
    % C - Lapack mint példa
    Dissipator = struct();
    
    [Row, Col] = size(DissipatorInput);
    if Row ~= Col
        error('Not square matrix')
    else 
        Dissipator.Info = '1 qubit Local Dissipator';
        Dissipator.Type = 'Dissipator Gate';
        Dissipator.NumberOfQubits = 1;
        Dissipator.Operator = @(g) sqrt(g) * sparse(DissipatorInput);
        %Dissipator.ActingOnQubit = ActOnQubit;
    end
end


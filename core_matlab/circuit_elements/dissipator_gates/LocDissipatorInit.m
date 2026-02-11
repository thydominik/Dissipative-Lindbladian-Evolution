function [Dissipator] = LocDissipatorInit(DissipatorInput)
%LOCDISSIPATORINIT - Creates a local dissipator for N qubits. This N is defined by the size of
%the DissipatorIntup input.

% INPUT --------------------------------------------------
% DissipatorInput - [Matrix], A square matrix of size 2x2, 4x4, 8x8, ... that describes a dissipator
% on 1, 2, 3, ... qubits.
% INPUT --------------------------------------------------

Dissipator = struct();

[Row, Col]  = size(DissipatorInput);
N           = log2(Row);
if Row ~= Col
    error('Not square matrix')
end

if mod(Row, 2) ~= 0
    error('Wrong Dissipator Input');
end

    Dissipator.Info             = num2str(N) + " qubit Local Dissipator";
    Dissipator.Type             = "Dissipator Gate";
    Dissipator.NumberOfQubits   = N;
    Dissipator.Operator         = @(g) sqrt(g) * sparse(DissipatorInput);

end


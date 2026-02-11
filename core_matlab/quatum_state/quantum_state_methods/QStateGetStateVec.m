function [CCoeffs, RelPhase, Psi] = QStateGetStateVec(qstate)
%QSTATEGETSTATEVEC gets the state vector froma  density matrix.

% Note: Phase degree of freedom. Not usefull in the case of mixed states.

DensityMatrix = dv2dm(qstate.DensityVector);

CCoeffs = sqrt(diag(DensityMatrix));

NonZeroElement = find(CCoeffs, 1, 'first');

RelPhase(NonZeroElement) = 0;

for i = 1:(2^qstate.NumberOfQubits)
    if CCoeffs(i) ~= 0
        RelPhase(i) = (-1i) * log(DensityMatrix(NonZeroElement, i) / (CCoeffs(NonZeroElement) * CCoeffs(i)));
    else
        RelPhase(i) = 0;
    end
end

Psi = CCoeffs.' .* exp(1i .* RelPhase);

end


function [F] = Fidelity(QSystemA, QSystemB)
% FIDELITY - Measures the fidelity of system A to system B

% INPUT --------------------------------------------------
% QSystem A - [Quantum system], A quantum system that will be compared to QSystem B. This Quantum
% system variable is sued by this ED code.
% INPUT --------------------------------------------------

if QSystemA.NumberOfQubits == QSystemB.NumberOfQubits

    % getting the density matrix from the density vectors for both systems
    DensityMatrix_A = dv2dm(QSystemA.DensityVector);
    DensityMatrix_B = dv2dm(QSystemB.DensityVector);

    F = abs(trace(DensityMatrix_A * DensityMatrix_B));     % for pure states.
else
    warning('System size mismatch; Fidelity is 0')
    F = 0;
end
end


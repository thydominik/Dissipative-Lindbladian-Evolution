function [F] = Fidelity(QSystemA, QSystemB)
    if QSystemA.NumberOfQubits == QSystemB.NumberOfQubits

        DensityMatrix_A = dv2dm(QSystemA.DensityVector);
        Psi_A = QStateGetStateVec(QSystemA);
        DensityMatrix_B = dv2dm(QSystemB.DensityVector);
        Psi_B = QStateGetStateVec(QSystemB);
        F = (trace((DensityMatrix_A * DensityMatrix_B)));
    else
        warning('System size mismatch; Fidelity is 0')
        F = 0;
    end
end


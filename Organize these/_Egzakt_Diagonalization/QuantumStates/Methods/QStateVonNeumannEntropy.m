function [S] = QStateVonNeumannEntropy(QSystem)
    DensityMatrix = dv2dm(QSystem.DensityVector);
    Lambda = eig(DensityMatrix);
    S = 0;
    for i = 1:length(Lambda)
        if Lambda(i) == 0
            S = S;
        else
            S = S + Lambda(i)*log(1/Lambda(i));
        end
    end
    QSystem.Entropy = real(S);
end


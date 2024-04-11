function [OutData, OutShape, TempA, TempB] = TensorDot(A, B, legsA, legsB, shapeA, shapeB)
    %TENSORDOT: tensor product for specific legs of tensors 'A' & 'B'. Reshape
    %A & B, then permute the contracted legs to the front, free legs to the
    %back. Make the dot product, then give back the product and shape
    
    %Edit: 2022.06.28. saját Kód
    %Edit: 2022.06.29. Miklós kódjára formáztam hibakeresés miatt.
    %Edit: 2022.06.29. Nincs hiba 1 qubites kapukra: ipermute
    %Edit: 2022.06.30. Valami nem stimmel ha távolabbi kcsh van a
    %rendszerben

    FreeLegsA = 1:length(shapeA);
    FreeLegsA(legsA) = [];
    if length(shapeA) == 1
        PermuteOrderA = [2, 1];
    else
        PermuteOrderA = [(FreeLegsA), (legsA)];
    end
    NewShapeA = shapeA;
    NewShapeA(legsA) = [];
% -------------------------------------------------------------------------
    FreeLegsB = 1:length(shapeB);
    FreeLegsB(legsB) = [];
    if length(shapeB) == 1
        PermuteOrderB = [2, 1];
    else
        PermuteOrderB = ([(legsB), FreeLegsB]);
    end
    NewShapeB = shapeB;
    NewShapeB(legsB) = [];

    TempA = reshape(permute(A, (PermuteOrderA)), [prod(NewShapeA), prod(shapeA(legsA))]);
    TempB = (reshape(permute(B, PermuteOrderB), [prod(shapeB(legsB)), prod(NewShapeB)]));


    OutShape = [NewShapeA NewShapeB];

    if isempty(OutShape)
        OutData = TempA * TempB;      % just a number
    elseif length(NewShapeA) + length(NewShapeB) == 1
        OutData = reshape(TempA * TempB, [NewShapeA, NewShapeB, 1]);
    else
        OutData = reshape(TempA * TempB, [NewShapeA, NewShapeB]);
    end

    OutData = ipermute(OutData, PermuteOrderB);
end


function [TrObj, Dict] = BasisTransform(obj, typeOfObject, NoQ)
%BASISTRANSFORM: Gets a Liouville space operator or a density vector and
%transforms the basis of that
Sizes   = 2^NoQ;
SizeVec = [];

if strcmp(typeOfObject, 'O') || strcmp(typeOfObject, 'operator') || strcmp(typeOfObject, 'o')
    OriginalBase = 1:(2^(2 * NoQ));
    BaseTmp      = zeros(1, 2 * NoQ);

    for i = 0:(2^(2 * NoQ)) - 1
        Base             = flip(de2bi(i, 2 * NoQ));
        BaseTmp(1:2:end) = Base(1:end/2);
        BaseTmp(2:2:end) = Base((end/2) + 1 : end);
        NewBase(i + 1)     = bi2de(flip(BaseTmp)) + 1;
    end

    Dict(:,1) = OriginalBase;
    Dict(:,2) = NewBase;

    obj(:,NewBase) = obj(:, OriginalBase);
    obj(NewBase,:) = obj(OriginalBase, :);

elseif strcmp(typeOfObject, 'v') || strcmp(typeOfObject, 'V') || strcmp(typeOfObject, 'vector')
    OriginalBase = 1:(2^(2 * NoQ));
    BaseTmp      = zeros(1, 2 * NoQ);

    for i = 0:(2^(2 * NoQ)) - 1
        Base             = flip(de2bi(i, 2 * NoQ));
        BaseTmp(1:2:end) = Base(1:end/2);
        BaseTmp(2:2:end) = Base((end/2) + 1 : end);
        NewBase(i+1)     = bi2de(flip(BaseTmp)) + 1;
    end

    Dict(:, 1)    = OriginalBase;
    Dict(:, 2)    = NewBase;
    obj(NewBase) = obj(OriginalBase);

end
TrObj = obj;

end

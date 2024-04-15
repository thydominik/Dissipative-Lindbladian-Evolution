function [RhoVec] = dm2dv(rho)
%DM2DV: Density Matrix to Density Vector

% This part will order the density matrix into the density vector in a
% way that preserves the order of the mtx rows. This is the preferred way due to the operator constrcution

DensityMtxSize = size(rho);

NumberOfQubits = log(DensityMtxSize(1))/log(2);

noq     = NumberOfQubits;
sizev   = [2 4 8 16 32 64 128 256 512 1024 2048];
sizes   = 2^noq;

NewX = rho;
for i = 1:(noq - 1)
    C = mat2cell(NewX, [ones(1, 2^(2*i-1)) * sizev(noq - i)], [sizes/(2^i) sizes/(2^i)]).';             %[ones(1, sizesv(i)) * sizes/(2-i)], [ones(1, sizesv(i)) * sizes/(2-i)]).'
    NewX = [];
    for j = 1:2^(2 * i)
        NewX = [NewX; C{j}];
    end
end

NewX    = NewX.';
RhoVec  = NewX(:);
end


%     Size = size(rho);
%
% %     for i = 1:Size(1)
% %         for j = 1:Size(2)
% %             dv(Size(2) * (i - 1) + j) = rho(i, j);
% %         end
% %     end
%
%     dv = reshape(rho.', [Size(1)^2 1]);
%

%
%     RhoVec = [];
%     for i = 1:2:DensityMtxSize(1)
%         for j = 1:2:DensityMtxSize(1)
%             TempRho     = rho(i:i+1, j:j+1);
%             tempRhoVec  = reshape(TempRho.', [4 1]);
%             RhoVec      = [RhoVec; tempRhoVec];
%         end
%     end

% Old -----------------------------------------------------------------
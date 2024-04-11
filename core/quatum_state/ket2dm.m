function [rho] = ket2dm(ket)
%KET2DM: Creating the density matrix from an arbitrary ket vector

if length(ket) >= 3
    warning('This is not a 2 state state')
end

%Make sure that this is a cloumn vector
% psi = zeros(length(ket), 1);
% 
% for i = 1:length(ket)
%     psi(i) = ket(i);
% end

if size(ket, 1) == 1
    psi = ket.';
else
    psi = ket;
end

rho = psi * psi';
end



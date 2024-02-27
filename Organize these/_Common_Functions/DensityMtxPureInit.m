function [RhoSys, RhoVec] = DensityMtxPureInit(PsiMtx)
%DENSITYMTXPUREINIT: Initilaizes a density matrix from pure states. The
%input should be an 2 by N matrix consisting of N qubits, each of which
%with one set of complex amplitudes

Size = size(PsiMtx);

%Here we could check a lot of things: example
    % -is the individual wavefuntion normalised?
    % -is PsiMtx in a good format?
if Size(1) ~= 2
    warning('Psi Matrix: wrong format')
end

NumberOfQubits = Size(2);

Psi_temp        = PsiMtx(:, 1);
RhoSys(:, :)    = ket2dm(Psi_temp);

for NoQ = 2:NumberOfQubits
    Psi_temp    = PsiMtx(:, NoQ);
    Rho_temp    = ket2dm(Psi_temp);
    RhoSys      = kron(RhoSys, Rho_temp);
end

RhoVec = dm2dv(RhoSys);
end


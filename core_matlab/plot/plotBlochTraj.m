function [x,y,z] = plotBlochTraj(rhot, time, N)
% This function will get a time series of a density matrix and the time steps, then it plots the
% bloch vectors for this time-evolution:

    for t = 1:length(time)
        rho_temp = reshape(rhot(t, :, :), [2^N 2^N]);
        BlochVector = dm2bv(rho_temp);
        x(t) = BlochVector(1, :);
        y(t) = BlochVector(2, :);
        z(t) = BlochVector(3, :);
    end
end


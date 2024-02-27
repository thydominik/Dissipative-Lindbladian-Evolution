function [x,y,z] = plotBlochTraj(rhot, time, N)
    for t = 1:length(time)
        rho_temp = reshape(rhot(t, :, :), [2^N 2^N]);
        BlochVector = dm2bv(rho_temp);
        x(t) = BlochVector(1, :);
        y(t) = BlochVector(2, :);
        z(t) = BlochVector(3, :);
    end
end


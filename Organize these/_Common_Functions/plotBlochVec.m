function plotBlochVec(rho)
%PLOTBLOCHVEC: Plot the bloch vector only
BV = dm2bv(rho);

someBV = line([ 0 BV(1)], [0 BV(2)], [0 BV(3)], ...
    'LineWidth', 2, 'Marker', 'o');
end


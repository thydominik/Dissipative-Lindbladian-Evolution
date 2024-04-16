function plotBlochVec(DensityMatrix, color)
%PLOTBLOCHVEC: Plot the bloch vector only
BlochVector = dm2bv(DensityMatrix);

if exist('color', 'var')
    someBV = line([ 0 BlochVector(1)], [0 BlochVector(2)], [0 BlochVector(3)], 'color', color, ...
    'LineWidth', 2, 'Marker', 'o');
else
    someBV = line([ 0 BlochVector(1)], [0 BlochVector(2)], [0 BlochVector(3)], ...
    'LineWidth', 2, 'Marker', 'o');
end
end


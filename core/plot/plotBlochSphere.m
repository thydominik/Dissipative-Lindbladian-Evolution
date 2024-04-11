function plotBlochSphere(NoP, angle1, angle2)
%PLOTBLOCHSPHERE: Plotting a sphere which happens to be the Bloch sphere
if angle1 == 'sv' %as in standard view
    angle1 = 60;
end

if angle2 == 'sv'
    angle2 = 15;
end

[x, y, z] = sphere(NoP);
Sphere = surf(x, y, z);
axis equal
shading interp
Sphere.FaceAlpha = 0.2;
line([-1 1], [0 0], [0 0], 'LineWidth', 0.5, 'Color', [0 0 0])
line([0 0], [-1 1], [0 0], 'LineWidth', 0.5, 'Color', [0 0 0])
line([0 0], [0 0], [-1 1], 'LineWidth', 0.5, 'Color', [0 0 0])

text(0, 0, 1.1, '$\left| 0 \right>$', 'Interpreter', 'latex', ...
    'FontSize', 20, 'HorizontalAlignment', 'Center')
text(1.1, 0, 0, '$\left| + \right>$', 'Interpreter', 'latex', ...
    'FontSize', 20, 'HorizontalAlignment', 'Center')
text(-1.1, 0, 0, '$\left| - \right>$', 'Interpreter', 'latex', ...
    'FontSize', 20, 'HorizontalAlignment', 'Center')
text(0, 0, -1.1, '$\left| 1 \right>$', 'Interpreter', 'latex', ...
    'FontSize', 20, 'HorizontalAlignment', 'Center')
view([angle1 angle2])


end


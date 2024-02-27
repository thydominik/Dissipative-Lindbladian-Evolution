function [Plot] = Tomography_Map(Quantum_System, Min_Val)
    %TOMOGRAPHY_MAP: Creates the tomography map of a quantum system object. The
    % the height of the bars represent the real part, color represents the
    % phase.
    
    % Quantum_System - An object that stores the density vector.
    % Min_Val - Don't show the bar that's absolute value is smaller then
    % value
    if nargin < 2 || isempty(Min_Val)
        Min_Val = 0;
    end
    
    Real_Part   = real(dv2dm(Quantum_System.DensityVector));
    Imag_Part   = imag(dv2dm(Quantum_System.DensityVector));
    Phase       = 2 * atan(Imag_Part./(sqrt(Real_Part.^2 + Imag_Part.^2) + Real_Part));
    
    Real_Part(abs(Real_Part) < Min_Val) = nan;
    Phase(isnan(Real_Part)) = nan;
    
    bar_graph = bar3(Real_Part);
    
    Color_Data_size = size(bar_graph(1).CData);
    z_color = repelem(Phase, 6, 4);
    z_color = mat2cell(z_color, Color_Data_size(1), ones(1, size(Real_Part, 2)) * Color_Data_size(2));
    set(bar_graph,{'CData'},z_color.')
    
    % axis ticks
    NoQ = Quantum_System.NumberOfQubits;
    Tick_set = 1:(2^(NoQ));
    Label_set = cell(1, 2^NoQ);
    for Basis_ind = 1:2^NoQ
        Label_temp = ['|' dec2bin(Tick_set(Basis_ind)-1, NoQ) '>'];
        Label_set(Basis_ind) = {Label_temp};
    end
    xticks(Tick_set)
    xticklabels(Label_set)
    yticks(Tick_set)
    yticklabels(Label_set)
end
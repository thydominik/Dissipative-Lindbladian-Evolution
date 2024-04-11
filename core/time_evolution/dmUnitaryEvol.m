function [new_rho] = dmUnitaryEvol(rho, U)
    %DMUNITARYEVOL Takes a density matrix, and a unitary operator, then
    %"evolves" the density mtx as rho' = U * rho * U^+
    
    rho_size = size(rho);
    unitary_size = size(U);
    
    if rho_size(1) ~= unitary_size(1) || rho_size(2) ~= unitary_size(2)
        warning("Incosistent matrix dimensions!")
    else
        new_rho = U * rho * ctranspose(U);
        if round(trace(new_rho), 5) ~= 1
            warning("Operator not unitary!")
        end
    end

end


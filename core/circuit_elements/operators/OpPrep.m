function [OpN] = OpPrep(Op, qubit, dN)
    %OPPREP Prepare an arbitrary operator to act on a density matrix, Example:
    %take S_x operator acting on the 1st qubit in a 3 qubit density matrix
    % Op - the operator; qubit - #th cubit that Op acts on; dN - density matrix
    % of dN qubits
    
    if qubit == 1
        OpN = Op;
        for i = 2:dN
            OpN = kron(OpN, eye(2,2));
        end
    else
        OpN = eye(2,2);
        for i = 2:dN
            if i == qubit
                OpN = kron(OpN, Op);
            else
                OpN = kron(OpN, eye(2,2));
            end
        end
    end
end



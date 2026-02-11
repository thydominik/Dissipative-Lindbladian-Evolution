function [OpN] = OpPrep(Op, qubit, NoQ)
    %OPPREP Prepare an arbitrary operator to act on a density matrix, Example:
    %take S_x operator acting on the 1st qubit in a 3 qubit density matrix
    % INPUT --------------------------------------------
    % Op - [Matrix], the operator;
    % qubit - [integer], #th cubit that Op acts on; 
    % NoQ - [Integer], Number of qubits in the system
    % INPUT --------------------------------------------
    
    if qubit == 1
        OpN = Op;
        for i = 2:NoQ
            OpN = kron(OpN, eye(2,2));
        end
    else
        OpN = eye(2,2);
        for i = 2:NoQ
            if i == qubit
                OpN = kron(OpN, Op);
            else
                OpN = kron(OpN, eye(2,2));
            end
        end
    end
end



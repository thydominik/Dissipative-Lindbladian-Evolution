function State = NQubitStateInit(NoQ, DensityInput, InitType, info)
    %INITNQUBIT: initialize an empty N qubit state as a structure
    % ---------------------------------------------------------------------
    % NoQ - [int] Number of Qubits
    % DensityInput - [array // mtx; double] Density mtx or Density vector as a state descrioption
    % InitType - [char] {'m', 'M'} or {'v', 'V'} determines if its a Vector or mtx input
    % info - [char, array] allows to store additional info on the resulting Quantum state
    % ---------------------------------------------------------------------

    % This will be the output structure
    State = struct();

    % Construction from Matrix input
    if InitType == 'm' || InitType == 'M'
        DensityMatrixSize = size(DensityInput);
        
        if NoQ ~= round(log(DensityMatrixSize(1))/log(2))
            N_temp  = NoQ;
            NoQ     = log(DensityMatrixSize(1))/log(2);
            warning(['Incosistent qubit number and density matrix form. # of qubits set appropriately to ' num2str(NoQ) ' from ' num2str(N_temp)])
        end
        
        if DensityMatrixSize(1) ~= DensityMatrixSize(2)
            error('Density matrix is not a square matrix')
        end
        
        if round(trace(DensityInput),10) ~= 1
            warning(['Density matrix normalization problem: trace is ' num2str(trace(DensityInput))])
        end
    
        State.Info = [num2str(NoQ) ' Qubit Quantum State'];
    
        if exist('info', 'var')
            Extra_info = [info];
            State.ExtraInfo = Extra_info;
        end
    
        State.Type              = 'Quantum State';
        State.NumberOfQubits    = NoQ;
        State.DensityVector     = dm2dv(DensityInput);
    
    % Construction from vector input
    elseif InitType == 'v' || InitType == 'V'
        DensityVectorSize = size(DensityInput);
        
        if NoQ ~= round(log(sqrt(DensityVectorSize(1)))/log(2))
            N_temp  = NoQ;
            NoQ     = log(sqrt(DensityVectorSize(1)))/log(2);
            if floor(NoQ) == NoQ
                warning(['Incosistent qubit number and density vector form. # of qubits set appropriately to ' num2str(NoQ) ' from ' num2str(N_temp)])
            else
                error('Not appropriate qubit number')
            end
        end
        
        if floor(sqrt(DensityVectorSize(1))) ~= sqrt(DensityVectorSize(1))
            sqrt(DensityVectorSize(1))
            error('Incosistent Density vector size')
        end
    
        State.Info = [num2str(NoQ) ' Qubit Quantum State'];
    
        if exist('info', 'var')
            Extra_info      = [info];
            State.ExtraInfo = Extra_info;
        end
    
        State.Type              = 'Quantum State';
        State.NumberOfQubits    = NoQ;
%         Real_temp = real(DensityInput);
%         Real_temp(Real_temp < 10^-16) = 0;
%         Imag_temp = imag(DensityInput);
%         Imag_temp(Imag_temp < 10^-16) = 0;
%         DensityInput = Real_temp + (Imag_temp * 1i);
        State.DensityVector     = DensityInput;
    end

    
end



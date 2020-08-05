namespace QESA {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Arrays; 
    open Microsoft.Quantum.Preparation;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Core;
    open Microsoft.Quantum.Convert;

    operation GetLowestInList(List: Int[]) : Int
    {
        if(Length(List) == 0) 
        {
            return 0; 
        }
        mutable guess = RandomInt(Length(List));

        if(Length(List) % 2 == 1)
        {
            set guess = Algorithm_Odd(Length(List), guess);
        }
        else
        {
            set guess = Algorithm_Even(Length(List), guess);
        }
        return List[guess];
    }

    // Executes when items in list is even
    operation Algorithm_Even(TableLength : Int, RandomIndex : Int) : Int
    {
        using (Register = Qubit[TableLength]) // intialize register to number of qubits as there are indices
        {
            within
                {   
                    ApplyToEachA(H,Register); // Create Uniform Superposition of all indices
                    let Marker = Register[RandomIndex]; // Grab the qubit in the RandomIndex and set it aside
                    let range = Exclude([RandomIndex],Register);
                    Controlled Z(range,Marker); // Apply Oracle to flip all states that are T[j]<T[y]
                }
            apply 
                {
                    ApplyToEach(H,Register); // Apply Hadamard to register
                    ApplyConditionalPhase_0(LittleEndian(Register)); // Reflect qubits that are 0s
                    ApplyToEachA(H,Register); // Apply Adjunct Hadamard to register
                    ApplyToEach(Z, Register); //Reflect qubits that are 1s
                }       
			return MeasureInteger(LittleEndian(Register));
        }
    }

    // Executes when items in list is odd
    operation Algorithm_Odd(TableLength : Int, RandomIndex : Int) : Int
    {
        using (Register = Qubit[TableLength]) // intialize register to number of qubits as there are indices
        {
            within
                {   
                    ApplyToEachA(H,Register); // Create Uniform Superposition of all indices
                    let Marker = Register[RandomIndex]; // Grab the qubit in the RandomIndex and set it aside
                    let range = Exclude([RandomIndex],Register);
                    Controlled Z(range,Marker); // Apply Oracle to flip all states that are T[j]<T[y]
                }
            apply 
                {
                    QFTLE(LittleEndian(Register)); // Implementation for odd number of table entries
                    ApplyConditionalPhase_0(LittleEndian(Register)); // Reflect qubits that are 0s
                    Adjoint QFTLE(LittleEndian(Register)); // Inverse QFT by using BigEndian
                    ApplyToEach(Z,Register); //Reflect qubits that are 1s
                }
            return MeasureInteger(LittleEndian(Register));
        }
    }

    // If qubit is 0 flip it!
    operation ApplyConditionalPhase_0(register : LittleEndian): Unit is Adj + Ctl {
        using (aux = Qubit()) {
            within {
                // prepare aux in the |−⟩ state. 
                H(aux);
                Z(aux);
            } 
            apply {
                // X(|->) = |->, so don't neet to reset, but the phase kickback will remain.
                (ControlledOnInt(0, X))(register!, aux);
            }
        }
    }
}
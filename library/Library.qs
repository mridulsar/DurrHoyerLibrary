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


    operation Algorithm_Even(TableLength : Int, RandomIndex : Int) : Unit
    {
        using ((Register) = (Qubit[TableLength])) // intialize register to number of qubits as there are indices
        {
            within
                {   
                    PrepareUniformSuperposition(TableLength,LittleEndian(Register)); // Create Uniform Superposition of all indices
                    let Marker = Register[RandomIndex]; // Grab the qubit in the RandomIndex and set it aside
                    Controlled Z(Register,Marker); // Apply Oracle to flip all states that are T[j]<T[y]
                }
            apply 
                {
                    ApplyToEach(H,Register); // Apply Hadamard to register
                    ApplyConditionalPhase_0(LittleEndian(Register)); // Reflect qubits that are 0s
                    ApplyToEachA(H,Register); // Apply Adjunct Hadamard to register
                    ApplyConditionalPhase(LittleEndian(Register)); //Reflect qubits that are 1s
                }
        }
    }


    operation Algorithm_Odd(TableLength : Int, RandomIndex : Int) : Unit
    {
        using ((Register) = (Qubit[TableLength])) // intialize register to number of qubits as there are indices
        {
            within
                {   
                    PrepareUniformSuperposition(TableLength,LittleEndian(Register)); // Create Uniform Superposition of all indices
                    let Marker = Register[RandomIndex]; // Grab the qubit in the RandomIndex and set it aside
                    Controlled Z(Register,Marker); // Apply Oracle to flip all states that are T[j]<T[y]
                }
            apply 
                {
                    QFTLE(LittleEndian(Register)); // Implemntation for odd number of table entries
                    ApplyConditionalPhase_0(LittleEndian(Register)); // Reflect qubits that are 0s
                    QFT(BigEndian(Register)); // Inverse QFT by using BigEndian
                    ApplyConditionalPhase(LittleEndian(Register)); //Reflect qubits that are 1s
                }
        }
    }

        // If qubit is 0 flip it!
        operation ApplyConditionalPhase_0(register: LittleEndian) : Unit is Adj + Ctl
        {
            using (aux = Qubit()) 
            {
                (ControlledOnInt(0,Z))(register!,aux); 
            }
        }
        // If qubit is 1 flip it!
        operation ApplyConditionalPhase(register : LittleEndian) : Unit is Adj + Ctl 
        {
            using (aux = Qubit()) 
            {
                (ControlledOnInt(1,Z))(register!,aux); 
            }
        }
}

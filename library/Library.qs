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

                    ApplyToEach(X, Register); // Apply Oracle to flip all states that are T[j]<T[y]

                    (Controlled Z)(Register, Marker); // https://quantumcomputing.stackexchange.com/questions/4268/how-to-construct-the-inversion-about-the-mean-operator

                    ApplyToEach(X,Register);
            apply 
                {
                    ApplyToEach(H,Register); // Apply Hadamard to register

                    ApplyConditionalPhase_0(LittleEndian(Register)); // Reflect qubits that are 0s

                    ApplyToEachA(H,Register); // Apply Adjunct Hadamard to register

                    Z(LittleEndian(Register)); //Reflect qubits that are 1s
                }
        let MeasurementArray = MultiM(Register);
        ResetAll(Register);
        let IntegerArray = ResultArrayAsInt(MeausrementArray);
        let Index = Max(IntegerArray);
        return Index;
        }
    }


    operation Algorithm_Odd(TableLength : Int, RandomIndex : Int) : Int
    {
        using ((Register) = (Qubit[TableLength])) // intialize register to number of qubits as there are indices
        {
            within
                {   
                    PrepareUniformSuperposition(TableLength,LittleEndian(Register)); // Create Uniform Superposition of all indices

                    let Marker = Register[RandomIndex]; // Grab the qubit in the RandomIndex and set it aside

                    ApplyToEach(X, Register); // Apply Oracle to flip all states that are T[j]<T[y]

                    (Controlled Z)(Register, Marker); // https://quantumcomputing.stackexchange.com/questions/4268/how-to-construct-the-inversion-about-the-mean-operator

                    ApplyToEach(X,Register);
                }
            apply 
                {
                    QFTLE(LittleEndian(Register)); // Implemntation for odd number of table entries

                    ApplyConditionalPhase_0(LittleEndian(Register)); // Reflect qubits that are 0s

                    QFT(BigEndian(Register)); // Inverse QFT by using BigEndian

                    Z(LittleEndian(Register)); //Reflect qubits that are 1s
                }
        let MeasurementArray = MultiM(Register);
        ResetAll(Register);
        let IntegerArray = ResultArrayAsInt(MeausrementArray);
        let Index = Max(IntegerArray);
        return Index;
        }
    }



    operation ApplyConditionalPhase_0(register: LittleEndian) : Unit is Adj + Ctl
    {
        using (aux = Qubit()) 
        {
            (ControlledOnInt(0,X))(register!,aux); // If qubit is 0 flip it!
        }
    }

}

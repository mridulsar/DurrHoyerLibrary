namespace QESA.Tests {
    
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open QESA;

    @Test("QuantumSimulator")
    operation AllocateQubit () : Unit {
        
        using (q = Qubit()) {
            AssertMeasurement([PauliZ], [q], Zero, "Newly allocated qubit must be in |0> state.");
        }
        
        Message("Test passed.");
    }

    @Test("QuantumSimulator")
    operation RetrieveSmallestNumberTest () : Unit {
        let list = [2,1,3];
        let expected = 1;
        let actual = GetLowestInList(list);
        EqualityFactI(actual, expected, "Expected the lowest value to be returned.");

        Message("Test passed.");
    }

    @Test("QuantumSimulator")
    operation RetrieveSmallestNumberEmptyListTest () : Unit {
        let list = new Int[0];
        let expected = 0;
        let actual = GetLowestInList(list);
        EqualityFactI(actual, expected, "Expected 0 for empty list.");

        Message("Test passed.");
    }
}
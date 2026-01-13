namespace GroversAlgorithm {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Diagnostics; // Required for DumpMachine

    @EntryPoint()
    operation Main() : Unit {
        let nQubits = 5;
        let searchSpaceSize = 1 <<< nQubits; 
        
        // 1. Pick a random "marked" item
        let markedItem = DrawRandomInt(0, searchSpaceSize - 1);
        let optimalIterations = Round( (PI() / 4.0) * Sqrt(IntAsDouble(searchSpaceSize)) );

        Message($"--- Grover's Search Visualization ---");
        Message($"Looking for Hidden Item: {markedItem}");
        Message($"Total items: {searchSpaceSize}");
        Message($"Optimal Iterations: {optimalIterations}\n");

        // 2. Run the visual search
        let result = RunGroversSearch(nQubits, markedItem, optimalIterations);

        if (result == markedItem) {
            Message($"\nSUCCESS: Measured {result}, which matches the hidden item!");
        } else {
            Message($"\nFAILURE: Measured {result}.");
        }
    }

    operation RunGroversSearch(nQubits : Int, markedItem : Int, iterations : Int) : Int {
        use qubits = Qubit[nQubits];

        // Step 1: Initialization
        ApplyToEach(H, qubits);
        
        Message("State 0: Initial Superposition (Equal Probability)");
        // We act like we are peeking, but we won't dump here to save space.

        // Step 2: The Loop
        for i in 1 .. iterations {
            // A. Oracle
            ApplyMarkingOracle(markedItem, qubits);

            // B. Diffuser
            ApplyDiffuser(qubits);

            // VISUALIZATION STEP:
            // This prints the entire wave function. 
            // Look for the line with the highest probability!
            Message($"\n--- Step {i} of {iterations} ---");
            DumpMachine(); 
        }

        // Step 3: Measurement
        let result = MeasureRegister(qubits);
        ResetAll(qubits);
        return result;
    }

    // --- Standard Grover Operations ---

    operation ApplyMarkingOracle(markedItem : Int, qubits : Qubit[]) : Unit is Adj + Ctl {
        ApplyXorInPlace(markedItem, qubits);
        Controlled Z(Most(qubits), Tail(qubits));
        ApplyXorInPlace(markedItem, qubits);
    }

    operation ApplyDiffuser(qubits : Qubit[]) : Unit is Adj + Ctl {
        ApplyToEachCA(H, qubits);
        ApplyToEachCA(X, qubits);
        Controlled Z(Most(qubits), Tail(qubits));
        ApplyToEachCA(X, qubits);
        ApplyToEachCA(H, qubits);
    }

    operation ApplyXorInPlace(value : Int, qubits : Qubit[]) : Unit is Adj + Ctl {
        let n = Length(qubits);
        for i in 0 .. n - 1 {
            let isBitSet = ((value >>> i) &&& 1) == 1;
            if (not isBitSet) { X(qubits[i]); }
        }
    }

    operation MeasureRegister(register : Qubit[]) : Int {
        mutable result = 0;
        for i in 0 .. Length(register) - 1 {
            if (M(register[i]) == One) { set result += (1 <<< i); }
        }
        return result;
    }
}
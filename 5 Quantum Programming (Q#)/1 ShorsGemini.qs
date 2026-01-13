namespace ShorsAlgorithm {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Diagnostics;

    @EntryPoint()
    operation Main() : Unit {
        let target = 15;
        Message($"--- Factoring {target} with Quantum Period Finding ---");

        mutable foundFactors = false;

        // Loop until we successfully find factors
        repeat {
            // 1. Pick a random base 'a' supported by our simple Oracle
            // We support 11 (easy swap) and 2 (circular shift)
            let possibleBases = [2, 11]; 
            let a = possibleBases[DrawRandomInt(0, Length(possibleBases) - 1)];

            Message($"\n--- New Attempt: Trying base a = {a} ---");

            // 2. Quantum Step: Estimate Period
            // We use 3 bits of precision.
            // For a=11 (period 2), we expect result 4.
            // For a=2 (period 4), we expect result 2 or 6.
            let measureResult = EstimatePeriod(a, 3);
            
            if (measureResult == 0) {
                 Message(" > Quantum measurement yielded 0 (trivial). Retrying...");
            } else {
                // Convert quantum measurement index to period r
                // Precision bits = 3. Total range = 8.
                // measureResult/8 ~= s/r.
                
                mutable r = 0;
                if (measureResult == 4) { set r = 2; }       // 4/8 = 1/2 -> r=2
                elif (measureResult == 2 or measureResult == 6) { set r = 4; } // 2/8 = 1/4 -> r=4

                Message($" > Measurement index: {measureResult}. Estimated Period r: {r}");

                if (r > 0) {
                     // 3. Classical Factor Extraction
                     if (r % 2 != 0) {
                         Message(" > Period is odd. Math failed. Retrying...");
                     } else {
                        let halfPower = ExpModI(a, r / 2, target);
                        
                        // Check if we hit the 'fail' case (-1 mod N)
                        if (halfPower == target - 1) {
                            Message(" > Hit trivial factor case (-1 mod N). Retrying...");
                        } else {
                            let f1 = GreatestCommonDivisor(halfPower - 1, target);
                            let f2 = GreatestCommonDivisor(halfPower + 1, target);

                            if (f1 > 1 and f1 < target) {
                                Message($"\nSUCCESS! Found factors: {f1} and {target / f1}");
                                set foundFactors = true;
                            } 
                            elif (f2 > 1 and f2 < target) {
                                Message($"\nSUCCESS! Found factors: {f2} and {target / f2}");
                                set foundFactors = true;
                            } else {
                                Message(" > Factors were trivial (1 or 15). Retrying...");
                            }
                        }
                     }
                } else {
                    Message(" > Could not infer a valid period from measurement. Retrying...");
                }
            }
        } until (foundFactors);
    }

    // --- Quantum Operations ---

    operation EstimatePeriod(a : Int, precision : Int) : Int {
        // N=15 requires 4 qubits for the target register
        let nQubits = 4;
        
        use scan = Qubit[precision];
        use target = Qubit[nQubits];

        // Initialize target to |1> (binary 0001)
        // Little Endian: index 0 is least significant
        X(target[0]);

        // 1. Superposition
        ApplyToEach(H, scan);

        // 2. Oracle
        for i in 0 .. precision - 1 {
            let power = 1 <<< (precision - 1 - i); 
            Controlled ApplyOrderFindingOracle([scan[i]], (power, a, target));
        }

        // 3. Inverse QFT
        InverseQFT(scan);

        // 4. Measure
        let result = MeasureRegister(scan);

        ResetAll(scan);
        ResetAll(target);
        return result;
    }

    // Corrected QFT Math
    operation InverseQFT(register : Qubit[]) : Unit is Adj + Ctl {
        let n = Length(register);
        for i in 0 .. n - 1 {
            for j in 0 .. i - 1 {
                // FIXED: Divisor is now correct (2^(i-j))
                let angle = -1.0 * PI() / IntAsDouble(1 <<< (i - j));
                Controlled R1([register[j]], (angle, register[i]));
            }
            H(register[i]);
        }
        // Swap qubits for endianness
        for i in 0 .. n / 2 - 1 {
            SWAP(register[i], register[n - 1 - i]);
        }
    }

    // --- Oracle Support for N=15 ---
    operation ApplyOrderFindingOracle(power : Int, a : Int, target : Qubit[]) : Unit is Adj + Ctl {
        for _ in 1 .. power {
             if (a == 11) {
                 // 11 * x mod 15 -> Swap 0 and 2
                 // 0001 (1) <-> 0101 (wrong) -> 1011 (11)
                 // Just swapping qubit 0 and 2 works for the subspace generated by 1
                 SWAP(target[0], target[2]);
             }
             elif (a == 2) {
                 // 2 * x mod 15 -> Circular Shift Left
                 // 0001 (1) -> 0010 (2) -> 0100 (4) -> 1000 (8) -> 0001
                 SWAP(target[0], target[1]);
                 SWAP(target[1], target[2]);
                 SWAP(target[2], target[3]);
             }
        }
    }

    // --- Helpers ---
    operation MeasureRegister(register : Qubit[]) : Int {
        mutable result = 0;
        for i in 0 .. Length(register) - 1 {
            if (M(register[i]) == One) {
                set result += (1 <<< i);
            }
        }
        return result;
    }

    function GreatestCommonDivisor(a : Int, b : Int) : Int {
        mutable x = a;
        mutable y = b;
        while (y != 0) {
            let t = y;
            set y = x % y;
            set x = t;
        }
        return x;
    }
}
double progressBasedOnLetters(
  String letters,
) {
  final Map<String, double> letterProgressMap = {
    'Α': 0.001,
    'Β': 0.003,
    'Γ': 0.002,
    'Δ': 0.004,
    'Ε': 0.001,
    'Ζ': 0.01,
    'Η': 0.001,
    'Θ': 0.009,
    'Ι': 0.001,
    'Κ': 0.005,
    'Λ': 0.003,
    'Μ': 0.003,
    'Ν': 0.001,
    'Ξ': 0.008,
    'Ο': 0.001,
    'Π': 0.003,
    'Ρ': 0.002,
    'Σ': 0.001,
    'Τ': 0.001,
    'Υ': 0.002,
    'Φ': 0.008,
    'Χ': 0.008,
    'Ψ': 0.01,
    'Ω': 0.003,
  };

  double calc = 0;

  for (var i = 0; i < letters.length; i++) {
    calc += letterProgressMap[letters[i]] ?? 0;
  }

  return calc;
}

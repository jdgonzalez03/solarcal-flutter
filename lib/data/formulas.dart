import 'package:calculator/models/formula_model.dart';

class FormulasData {
  // Lista de fórmulas eléctricas y solares
  static List<Formula> getFormulas() {
    return [
      const Formula(
        id: "1",
        title: "Potencia Eléctrica",
        formula: r"P = I^2 \cdot R",
        formulaIos: "P = I² · R",
        description:
            "Donde:\nP = Potencia en Watts (W)\nI = Corriente en Amperios (A)\nR = Resistencia en Ohms (Ω)",
      ),
      const Formula(
        id: "2",
        title: "Cálculo de Potencia",
        formula: r"P = V \cdot I",
        formulaIos: "P = V · I",
        description:
            "Donde:\nP = Potencia en Watts (W)\nV = Voltaje en Voltios (V)\nI = Corriente en Amperios (A)",
      ),
      const Formula(
        id: "3",
        title: "Cálculo de Voltaje",
        formula: r"V = \frac{P}{I}",
        formulaIos: "V = P / I",
        description:
            "Donde:\nV = Voltaje en Voltios (V)\nP = Potencia en Watts (W)\nI = Corriente en Amperios (A)",
      ),
      const Formula(
        id: "4",
        title: "Cálculo de Corriente",
        formula: r"I = \frac{P}{V}",
        formulaIos: "I = P / V",
        description:
            "Donde:\nI = Corriente en Amperios (A)\nP = Potencia en Watts (W)\nV = Voltaje en Voltios (V)",
      ),
      const Formula(
        id: "5",
        title: "Cálculo de Energía Eléctrica",
        formula: r"E = P \cdot t",
        formulaIos: "E = P ⋅ t",
        description:
            "Donde:\nE = Energía en Watt-horas (Wh) o Kilowatt-horas (kWh)\nP = Potencia en Watts (W) o Kilowatts (kW)\nt = Tiempo en horas (h)",
      ),
      const Formula(
        id: "6",
        title: "Energía Solar Disponible",
        formula: r"E_{solar} = I \cdot A \cdot t \cdot \eta",
        formulaIos: "Esolar = I · A · t · η",
        description:
            "Donde:\nEsolar = Energía solar disponible (kWh)\nI = Irradiancia solar (kW/m²)\nA = Área del panel solar (m²)\nt = Tiempo de exposición (h)\nη = Eficiencia del panel solar",
      ),
      const Formula(
        id: "7",
        title: "Eficiencia del Panel Solar",
        formula: r"\eta = \frac{P_{salida}}{P_{entrada}} \times 100\%",
        formulaIos: "η = (Psalida/Pentrada) × 100%",
        description:
            "Donde:\nη = Eficiencia del panel solar (%)\nPsalida = Potencia de salida del panel (W)\nPentrada = Potencia solar incidente (W)",
      ),
      const Formula(
        id: "8",
        title: "Ley de Ohm",
        formula: r"V = I \times R",
        formulaIos: "V = I × R",
        description:
            "Donde:\nV = Voltaje en Voltios (V)\nI = Corriente en Amperios (A)\nR = Resistencia en Ohms (Ω)",
      ),
    ];
  }

  // Método para obtener una fórmula por su ID
  static Formula? getFormulaById(String id) {
    final formulas = getFormulas();
    try {
      return formulas.firstWhere((formula) => formula.id == id);
    } catch (e) {
      return null;
    }
  }
}
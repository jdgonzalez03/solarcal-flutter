// utils/full_calculator.dart
double getMaxPower(List<Map<String, dynamic>> equipos) {
  double maxPower = 0;
  for (var equipo in equipos) {
    maxPower += equipo['potencia_total'] as double;
  }
  return maxPower;
}

double getMaxEnergyDaily(List<Map<String, dynamic>> equipos) {
  double maxEnergy = 0;
  for (var equipo in equipos) {
    maxEnergy += equipo['energia'] as double;
  }
  return maxEnergy;
}

double getRealEnergyMax(double maxEnergy, double eficienciaInversor) {
  return maxEnergy / eficienciaInversor;
}

double getMaxCurrent(double realEnergy, double tensionSistema, double factorSeguridad) {
  return (realEnergy * factorSeguridad) / tensionSistema;
}

double getPanelesParalelo(double maxCurrent, double HSP, double corrienteNominalPanel) {
  return maxCurrent / (HSP * corrienteNominalPanel);
}

double getPanelesSerie(double tensionSistema, double voltajeNominalPanel) {
  return tensionSistema / voltajeNominalPanel;
}

double getMaxCurrentControlador(int numPanelParalelo, double corrientCortoPanel, double factorSeguridad) {
  return numPanelParalelo * corrientCortoPanel * factorSeguridad;
}

double getMaxPowerInversor(double maxPower, double factorSeguridad, double eficienciaInversor) {
  return (maxPower * factorSeguridad) / eficienciaInversor;
}

double getBateriasParalelo(double maxCurrent, double numeroDiasAutonomia, double capacidadDescarga, double capacidadBateria) {
  return (maxCurrent * numeroDiasAutonomia) / (capacidadDescarga * capacidadBateria);
}

double getBateriasSerie(double tensionSistema, double voltajeBateria) {
  return tensionSistema / voltajeBateria;
}
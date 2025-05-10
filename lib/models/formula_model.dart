class Formula {
  final String id;
  final String title;
  final String formula;  // Fórmula en formato LaTeX
  final String formulaIos;  // Fórmula simplificada para iOS (opcional)
  final String description;

  const Formula({
    required this.id,
    required this.title,
    required this.formula,
    required this.description,
    this.formulaIos = '',
  });

  // Método para convertir un mapa a un objeto Formula
  factory Formula.fromMap(Map<String, dynamic> map) {
    return Formula(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      formula: map['formula'] ?? '',
      formulaIos: map['formula_ios'] ?? '',
      description: map['description'] ?? '',
    );
  }

  // Método para convertir una Formula a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'formula': formula,
      'formula_ios': formulaIos,
      'description': description,
    };
  }
}
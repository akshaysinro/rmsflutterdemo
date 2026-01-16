enum Unit { kg, gram, liter, ml, pcs }

class Ingredient {
  final String id;
  final String name;
  final double currentStock;
  final double minThreshold; // For low-stock alerts
  final double costPerUnit;
  final Unit unit;

  const Ingredient({
    required this.id,
    required this.name,
    required this.currentStock,
    required this.minThreshold,
    required this.costPerUnit,
    required this.unit,
  });

  bool get isLowStock => currentStock <= minThreshold;
}
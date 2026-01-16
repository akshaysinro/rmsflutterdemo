class KOTItem {
  final String id;
  final String menuItemId;
  final String name;
  final int quantity;
  final List<String> notes;

  const KOTItem({
    required this.id,
    required this.menuItemId,
    required this.name,
    required this.quantity,
    this.notes = const [],
  });
}
import 'package:flutter_rms/features/kitchen/domain/entities/kot_item.dart';

enum KOTStatus { pending, acknowledged, cooking, prepared, served, cancelled }

class KOT {
  final String id;
  final String tableNumber;
  final List<KOTItem> items;
  final KOTStatus status;
  final DateTime createdAt;
  final Duration targetTime;

  const KOT({
    required this.id,
    required this.tableNumber,
    required this.items,
    this.status = KOTStatus.pending,
    required this.createdAt,
    this.targetTime = const Duration(minutes: 20),
  });

  // Business Logic: Calculating delay
  Duration get elapsedTime => DateTime.now().difference(createdAt);
  bool get isDelayed => elapsedTime > targetTime;

  // SOLID: Open/Closed. We don't modify the KOT; we create a new state.
  KOT copyWith({KOTStatus? status}) {
    return KOT(
      id: id,
      tableNumber: tableNumber,
      items: items,
      status: status ?? this.status,
      createdAt: createdAt,
      targetTime: targetTime,
    );
  }
}
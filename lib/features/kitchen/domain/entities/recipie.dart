
import 'package:flutter_rms/features/kitchen/domain/entities/recipie_entry.dart';

class Recipe {
  final String menuItemId;
  final List<RecipeEntry> entries;

  const Recipe({
    required this.menuItemId,
    required this.entries,
  });
}
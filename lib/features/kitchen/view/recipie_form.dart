import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/bloc/recipe/recipe_bloc.dart';

class RecipeFormSheet extends StatelessWidget {
  const RecipeFormSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // We use Padding to handle the keyboard pushing the sheet up
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Fits the content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),

              const Text(
                "Recipe Name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "e.g. Truffle Burger",
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Ingredients",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline, size: 20),
                    label: const Text("Add New"),
                  ),
                ],
              ),
              const Divider(height: 1),
              const SizedBox(height: 16),

              // Scrollable List of Ingredients
              const _IngredientInputRow(
                name: "Beef Patty",
                qty: "1",
                unit: "pcs",
              ),
              const _IngredientInputRow(
                name: "Brioche Bun",
                qty: "1",
                unit: "pcs",
              ),
              const _IngredientInputRow(
                name: "Truffle Oil",
                qty: "10",
                unit: "ml",
              ),

              const SizedBox(height: 32),

              // ACTION BUTTONS
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () =>
                      context.read<RecipeBloc>().router.goBack(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "SAVE RECIPE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Edit Recipe",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () => context.read<RecipeBloc>().router.goBack(context),
          icon: const Icon(Icons.close, color: Colors.grey),
        ),
      ],
    );
  }
}

class _IngredientInputRow extends StatelessWidget {
  final String name;
  final String qty;
  final String unit;

  const _IngredientInputRow({
    required this.name,
    required this.qty,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: qty,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 40,
            child: Text(unit, style: const TextStyle(color: Colors.grey)),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.remove_circle_outline,
              color: Colors.redAccent,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

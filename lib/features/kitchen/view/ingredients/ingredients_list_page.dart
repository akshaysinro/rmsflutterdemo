import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rms/features/kitchen/presentation/bloc/ingredient/ingredient_bloc.dart';
import 'package:flutter_rms/features/kitchen/presentation/bloc/ingredient/ingredient_event.dart';
import 'package:flutter_rms/features/kitchen/presentation/bloc/ingredient/ingredient_state.dart';
import 'package:flutter_rms/features/kitchen/view/ingredients/ingredients_tile.dart';

class IngredientListingPage extends StatefulWidget {
  const IngredientListingPage({super.key});

  @override
  State<IngredientListingPage> createState() => _IngredientListingPageState();
}

class _IngredientListingPageState extends State<IngredientListingPage> {
  @override
  void initState() {
    super.initState();
    context.read<IngredientBloc>().add(const IngredientEvent.initialize());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IngredientBloc, IngredientState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: AppBar(
            title: const Text(
              "INGREDIENTS",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            actions: [
              TextButton.icon(
                onPressed: () => _showAddIngredientSheet(context),
                icon: const Icon(Icons.add, color: Colors.blue),
                label: const Text(
                  "ADD NEW",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loadFailure: (message) => Center(child: Text(message)),
            loadSuccess: (ingredients) => ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 8, // Use ingredients.length in real implementation
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) => const IngredientTileUI(),
            ),
          ),
        );
      },
    );
  }
}

void _showAddIngredientSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add New Ingredient",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              labelText: "Ingredient Name",
              hintText: "e.g. Fresh Milk",
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Unit"),
                  items: ["g", "kg", "ml", "L", "pcs"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Opening Stock"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "SAVE INGREDIENT",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}

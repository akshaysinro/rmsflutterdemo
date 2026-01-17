import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/bloc/recipe/recipe_bloc.dart';
import '../presentation/bloc/recipe/recipe_event.dart';
import '../presentation/bloc/recipe/recipe_state.dart';
import 'package:flutter_rms/features/kitchen/view/recipie_form.dart';
import 'package:flutter_rms/features/kitchen/view/widgets/recipie_list_tile.dart';

class RecipeListingPage extends StatefulWidget {
  const RecipeListingPage({super.key});

  @override
  State<RecipeListingPage> createState() => _RecipeListingPageState();
}

class _RecipeListingPageState extends State<RecipeListingPage> {
  @override
  void initState() {
    super.initState();
    context.read<RecipeBloc>().add(const RecipeEvent.initialize());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              "RECIPE BOOK",
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    context
                        .read<RecipeBloc>()
                        .router
                        .navigateToIngredietsListing(context);
                  },
                  label: const Text("Ingredients"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const RecipeFormSheet(),
                    );
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text("NEW RECIPE"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
            shape: const Border(
              bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
            ),
          ),
          body: Column(
            children: [
              _buildSearchAndFilters(),
              Expanded(
                child: state.when(
                  initial: () =>
                      const Center(child: CircularProgressIndicator()),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loadSuccess: () => ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 10,
                    itemBuilder: (context, index) => const RecipeListTileUI(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search recipes...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFF5F5F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _buildFilterChip("MAIN COURSE"),
          const SizedBox(width: 8),
          _buildFilterChip("DESSERTS"),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFE0E0E0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}

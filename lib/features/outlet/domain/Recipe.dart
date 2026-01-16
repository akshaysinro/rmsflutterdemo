import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecipeSetupPage extends StatefulWidget {
  const RecipeSetupPage({super.key});

  @override
  State<RecipeSetupPage> createState() => _RecipeSetupPageState();
}

class _RecipeSetupPageState extends State<RecipeSetupPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  List<dynamic> _recipes = [];
  String? _selectedOutletId; // store the selected outlet ID as string

  // Hardcoded Assets for your reference
  final List<Map<String, dynamic>> _availableAssets = [
    {"id": "1", "name": "Sugar"},
    {"id": "2", "name": "Salt"},
    {"id": "3", "name": "Flour"},
    {"id": "4", "name": "Cooking Oil"},
  ];

  // Form Controllers
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _methodController = TextEditingController();
  final TextEditingController _heatTimeController = TextEditingController();

  // Dynamic Ingredients List
  List<Map<String, dynamic>> _ingredientRows = [];
  List<Map<String, dynamic>> _outlets = [];

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
    _fetchOutlets();
  }

  Future<void> _fetchRecipes() async {
    setState(() => _isLoading = true);
    // Replace with your real GET endpoint later
    final response = await http.get(
      Uri.parse('http://localhost:8080/recipe/all'),
    );
    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        setState(() {
          _recipes = [];
          _isLoading = false;
        });
      } else {
        setState(() {
          _recipes = jsonDecode(response.body);
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _fetchOutlets() async {
    setState(() => _isLoading = true);

    final response = await http.get(
      Uri.parse('http://localhost:8080/outlet/all'),
    );

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        setState(() {
          _outlets = [];
          _isLoading = false;
        });
      } else {
        final List<dynamic> decoded = jsonDecode(response.body);
        setState(() {
          _outlets = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
          _isLoading = false;

          // Optional: set default outlet
          if (_outlets.isNotEmpty && _selectedOutletId == null) {
            _selectedOutletId = _outlets.first['id'].toString();
          }
        });
      }
    }
  }

  void _addNewIngredientRow() {
    setState(() {
      _ingredientRows.add({
        "assetId": "1", // Default to Sugar
        "quantity": TextEditingController(text: "0"),
        "unit": "g",
      });
    });
  }

  void _removeIngredientRow(int index) {
    setState(() {
      _ingredientRows.removeAt(index);
    });
  }

  void _showAddRecipeModal() {
    // Reset Form
    _recipeNameController.clear();
    _methodController.clear();
    _heatTimeController.clear();
    _ingredientRows = [];
    _addNewIngredientRow();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => StatefulBuilder(
        // Important for dynamic rows in modal
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20,
              right: 20,
              top: 20,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Create New Recipe",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedOutletId,
                      decoration: const InputDecoration(
                        labelText: "Select Outlet",
                        border: OutlineInputBorder(),
                      ),
                      items: _outlets.map((outlet) {
                        return DropdownMenuItem(
                          value: outlet['id']
                              .toString(), // assuming outlet['id'] is int
                          child: Text(outlet['name']),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedOutletId = val;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select an outlet';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: _recipeNameController,
                      decoration: const InputDecoration(
                        labelText: "Recipe Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _heatTimeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Heat Time (Mins)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _methodController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: "Method/Instructions",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const Divider(height: 30),
                    const Text(
                      "Ingredients",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    // Dynamic Ingredients List inside Modal
                    ..._ingredientRows.asMap().entries.map((entry) {
                      int idx = entry.key;
                      var row = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<String>(
                                initialValue: row['assetId'],
                                items: _availableAssets
                                    .map(
                                      (a) => DropdownMenuItem(
                                        value: a['id'].toString(),
                                        child: Text(a['name']),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) =>
                                    setModalState(() => row['assetId'] = val),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                controller: row['quantity'],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Qty",
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                              onPressed: () => setModalState(
                                () => _ingredientRows.removeAt(idx),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    TextButton.icon(
                      onPressed: () =>
                          setModalState(() => _addNewIngredientRow()),
                      icon: const Icon(Icons.add),
                      label: const Text("Add Ingredient"),
                    ),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitRecipe,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Save Recipe"),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _submitRecipe() async {
    if (_formKey.currentState!.validate()) {
      final recipeData = {
        "recipeName": _recipeNameController.text,
        "method": _methodController.text,
        "heatTimeMinutes": int.tryParse(_heatTimeController.text) ?? 0,
        "outletId": "1", // Hardcoded current outlet ID
        "ingredients": _ingredientRows
            .map(
              (row) => {
                "assetId": row['assetId'],
                "quantity": double.tryParse(row['quantity'].text) ?? 0.0,
                "unit": row['unit'],
              },
            )
            .toList(),
        "status": "ACTIVE",
        "isActive": true,
      };

      final response = await http.post(
        Uri.parse('http://localhost:8080/recipe'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(recipeData),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        // 1. Get the new object from the response
        final newRecipe = jsonDecode(response.body);

        // 2. Update local state immediately
        setState(() {
          _recipes.insert(0, newRecipe); // Add to the top of the list
          _isLoading = false;
        });

        // 3. Close Modal
        Navigator.pop(context);

        // 4. Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Recipe Saved Successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception("Failed to save");
      }

      // if (response.statusCode == 201) {
      //   Navigator.pop(context);
      //   _fetchRecipes();
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recipe Manager")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                final recipe = _recipes[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.restaurant_menu,
                      color: Colors.orange,
                    ),
                    title: Text(recipe['recipeName'] ?? ""),
                    subtitle: Text(
                      "Heat: ${recipe['heatTimeMinutes']} mins | Ingredients: ${recipe['ingredients']?.length ?? 0}",
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRecipeModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}

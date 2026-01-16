import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rms/features/pos/dining/OtherOtBottomSheet.dart';
import 'package:http/http.dart' as http;

class DiningPage extends StatefulWidget {
  const DiningPage({super.key});

  @override
  State<DiningPage> createState() => _DiningPageState();
}

class _DiningPageState extends State<DiningPage> {
  List<dynamic> _loadedTables = [];
  bool _isLoading = true;
  List<dynamic> _recipes = [];

  @override
  void initState() {
    super.initState();
    _fetchTables();
    _fetchRecipes();
  }

  Future<void> _fetchTables() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/tables/all'),
      );
      if (response.statusCode == 200) {
        setState(() {
          _loadedTables = jsonDecode(response.body);
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
      print("Error fetching tables: $e");
    }
  }

  Future<void> _fetchRecipes() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/recipe/all'),
      );
      if (response.statusCode == 200) {
        setState(() {
          _recipes = jsonDecode(response.body);
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
      print("Error fetching recipes: $e");
    }
  }

  void _showCreateTableLayoutModal() {
    List<TempTable> sessionTables = []; // Store multiple tables here
    final nameController = TextEditingController();
    double? lastTappedX;
    double? lastTappedY;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) => StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "Build Your Floor Plan",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Text(
                    "1. Tap to place -> 2. Name it -> 3. Add Another",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return GestureDetector(
                          onTapDown: (details) {
                            setModalState(() {
                              lastTappedX = details.localPosition.dx;
                              lastTappedY = details.localPosition.dy;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(
                                color: Colors.orange.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              children: [
                                // Render all tables added in this session
                                ...sessionTables.map(
                                  (t) => Positioned(
                                    left: t.x - 20,
                                    top: t.y - 20,
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.table_restaurant,
                                          color: Colors.green,
                                          size: 40,
                                        ),
                                        Text(
                                          t.name,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Render the current tap indicator
                                if (lastTappedX != null)
                                  Positioned(
                                    left: lastTappedX! - 20,
                                    top: lastTappedY! - 20,
                                    child: const Icon(
                                      Icons.add_location,
                                      color: Colors.orange,
                                      size: 40,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: "Table Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (lastTappedX != null &&
                              nameController.text.isNotEmpty) {
                            setModalState(() {
                              sessionTables.add(
                                TempTable(
                                  name: nameController.text,
                                  x: lastTappedX!,
                                  y: lastTappedY!,
                                ),
                              );
                              nameController.clear();
                              lastTappedX = null;
                              lastTappedY = null;
                            });
                          }
                        },
                        child: const Text("Add to List"),
                      ),
                    ],
                  ),
                  const Divider(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (sessionTables.isNotEmpty) {
                        _saveBulkTableLayout(
                          sessionTables,
                          context.size!.width,
                          400,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text("Save All (${sessionTables.length}) Tables"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showOtherKOTModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const OtherKOTBottomSheet(),
    );
  }

  void _saveBulkTableLayout(
    List<TempTable> tables,
    double totalW,
    double totalH,
  ) async {
    // Map the list to JSON objects with ratios
    List<Map<String, dynamic>> payload = tables
        .map(
          (t) => {
            "name": t.name,
            "posX": t.x / totalW,
            "posY": t.y / totalH,
            "status": "FREE",
            "outletId": "1", // Add your actual outlet ID
          },
        )
        .toList();

    final response = await http.post(
      Uri.parse('http://localhost:8080/tables/create'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(payload),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      Navigator.pop(context);
      _fetchTables(); // Refresh the main view
    }
  }

  Future<void> _submitKOT(
    dynamic tableId,
    String custName,
    List<Map<String, dynamic>> basketItems,
  ) async {
    if (basketItems.isEmpty) return;

    final payload = {
      "id": null, // Backend will generate
      "tableId": tableId,
      "customerId": null, // Optional for now
      "status": "PENDING",
      "orderItems": basketItems.map((item) {
        return {
          "id": null,
          "recipe": {"id": item['recipeId']},
          "orderId": null, // Backend will link this
          "status": "ORDERED",
          "qty": item['qty'],
        };
      }).toList(),
    };

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/tables/ot'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.body == "Success") {
        Navigator.pop(context);
        _fetchTables(); // Refresh map to show occupied status
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("KOT Sent Successfully!")));
      }
    } catch (e) {
      print("Error sending OT: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      // We remove the appBar property entirely to allow the body to take full screen
      body: SafeArea(
        // Ensures content doesn't go under status bar/notches
        child: Stack(
          children: [
            // 1. The Main Content Layer
            _loadedTables.isEmpty ? _buildSetupView() : _buildMapView(),

            // 2. The Overlapping Edit Button Layer (Only show if data exists)
            if (_loadedTables.isNotEmpty)
              Positioned(
                top: 16,
                right: 16,
                child: FloatingActionButton.small(
                  // small FAB looks better as an overlay
                  heroTag: "editLayoutBtn",
                  backgroundColor: Colors.white.withOpacity(0.9),
                  foregroundColor: Colors.orange,
                  onPressed: _showCreateTableLayoutModal,
                  child: const Icon(Icons.edit_location_alt),
                ),
              ),
            Positioned(
              top: 64,
              right: 16,
              child: FloatingActionButton.small(
                // small FAB looks better as an overlay
                heroTag: "otherkot",
                backgroundColor: Colors.white.withOpacity(0.9),
                foregroundColor: const Color.fromARGB(255, 22, 146, 45),
                onPressed: _showOtherKOTModal,
                child: const Icon(Icons.add_moderator),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetupView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.restaurant, size: 80, color: Colors.orange),
          const SizedBox(height: 24),
          const Text(
            "Hi, welcome to dining area",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: _showCreateTableLayoutModal,
            icon: const Icon(Icons.add_location_alt_rounded),
            label: const Text("Setup Table Layout"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // VIEW 2: Loaded Map View (Interactive Floor Plan)
  Widget _buildMapView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: _loadedTables.map((table) {
            // Re-calculate pixel position based on stored ratio
            double x = table['posX'] * constraints.maxWidth;
            double y = table['posY'] * constraints.maxHeight;

            return Positioned(
              left: x - 30,
              top: y - 30,
              child: GestureDetector(
                onTap: () => _onTableTap(table),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: table['status'] == "OCCUPIED"
                            ? Colors.red[100]
                            : Colors.green[100],
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.orange, width: 2),
                      ),
                      child: Icon(
                        Icons.table_restaurant,
                        color: table['status'] == "OCCUPIED"
                            ? Colors.red
                            : Colors.green,
                        size: 40,
                      ),
                    ),
                    Text(
                      table['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _onTableTap(dynamic table) {
    List<Map<String, dynamic>> basket = [];
    final customerNameController = TextEditingController();
    final searchController = TextEditingController();
    List<dynamic> filteredRecipes = [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order: ${table['name']}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Customer Info (Optional)
                TextField(
                  controller: customerNameController,
                  decoration: const InputDecoration(
                    labelText: "Customer Name (Optional)",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 15),

                // Search Recipes
                TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: "Search Recipe...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) {
                    // Filter your globally loaded _recipes list
                    setModalState(() {
                      filteredRecipes = _recipes
                          .where(
                            (r) => r['recipeName']
                                .toString()
                                .toLowerCase()
                                .contains(val.toLowerCase()),
                          )
                          .toList();
                    });
                  },
                ),

                // Search Results List
                if (searchController.text.isNotEmpty)
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      itemCount: filteredRecipes.length,
                      itemBuilder: (context, i) {
                        final r = filteredRecipes[i];
                        return ListTile(
                          title: Text(r['recipeName']),
                          trailing: const Icon(
                            Icons.add_circle,
                            color: Colors.green,
                          ),
                          onTap: () {
                            setModalState(() {
                              basket.add({
                                "recipeId": r['id'],
                                "name": r['recipeName'],
                                "qty": 1,
                              });
                              searchController.clear();
                            });
                          },
                        );
                      },
                    ),
                  ),

                const Divider(),
                const Text(
                  "Current Items",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                // Basket / Current Round
                Expanded(
                  child: ListView.builder(
                    itemCount: basket.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(basket[i]['name']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => setModalState(
                                () => basket[i]['qty'] > 1
                                    ? basket[i]['qty']--
                                    : basket.removeAt(i),
                              ),
                            ),
                            Text(basket[i]['qty'].toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () =>
                                  setModalState(() => basket[i]['qty']++),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                ElevatedButton(
                  onPressed: () => _submitKOT(
                    table['id'],
                    customerNameController.text,
                    basket,
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text(
                    "SEND TO KITCHEN (KOT)",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    // Future: Navigate to Order/Booking page for this specific table
  }
}

class TempTable {
  String name;
  double x;
  double y;
  TempTable({required this.name, required this.x, required this.y});
}

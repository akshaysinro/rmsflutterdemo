import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KitchenPage extends StatefulWidget {
  const KitchenPage({super.key});

  @override
  State<KitchenPage> createState() => _KitchenPageState();
}

class _KitchenPageState extends State<KitchenPage> {
  final String apiUrl = "http://localhost:8080/tables/ot"; // Endpoint to get KOTs

  Future<List<dynamic>> _fetchKOTs() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return [];
  }

  Future<void> _updateStatus(dynamic kotId, String newStatus) async {
    await http.put(
      Uri.parse("http://localhost:8080/tables/kots/$kotId/status/$newStatus"),
    );
    setState(() {}); // Refresh list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KITCHEN DISPLAY"),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: () => setState(() {}))],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchKOTs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          // Filter out finished orders for the kitchen view
          final kots = snapshot.data!.where((k) => k['status'] != "READY").toList();

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Show 2 KOTs per row for tablet/large screens
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: kots.length,
            itemBuilder: (context, index) => _buildKotCard(kots[index]),
          );
        },
      ),
    );
  }

  Widget _buildKotCard(dynamic kot) {
    bool isCooking = kot['status'] == "COOKING";
    List recipes = kot['orderItems'] ?? [];

    return Card(
      color: isCooking ? Colors.orange[50] : Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: isCooking ? Colors.orange : Colors.grey.shade300, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text("TABLE ${kot['tableId']}", style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("KOT #${kot['id']} • ${kot['status']}"),
            trailing: isCooking ? const Icon(Icons.timer, color: Colors.orange) : null,
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, i) {
                final item = recipes[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    children: [
                      Text("${item['qty']} x ", style: const TextStyle(fontWeight: FontWeight.bold)),
                      // Accessing recipe name from the 'recipe' object in your record
                      Expanded(child: Text("${item['recipe']['recipeName']}")),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                String nextStatus = isCooking ? "READY" : "COOKING";
                _updateStatus(kot['id'], nextStatus);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isCooking ? Colors.green : Colors.blue,
                minimumSize: const Size(double.infinity, 45),
              ),
              child: Text(
                isCooking ? "MARK AS READY" : "ACCEPT ORDER",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RunningPage extends StatefulWidget {
  const RunningPage({super.key});

  @override
  State<RunningPage> createState() => _RunningPageState();
}

class _RunningPageState extends State<RunningPage> {
  // Replace with your actual IP if testing on a real device
  final String apiUrl = "http://localhost:8080/tables/orders/ACTIVE";

  Future<List<dynamic>> _fetchRunningOrders() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load orders");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _fetchRunningOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No active orders found."));
          }

          final orders = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return _buildOrderCard(order);
            },
          );
        },
      ),
    );
  }

  Widget _buildOrderCard(dynamic order) {
    List<dynamic> items = order['orderItems'] ?? [];
    List<dynamic> finalItems = [];
    for (var item in items) {
      if(item['orderItems'] != null){
        finalItems.addAll(item['orderItems']);
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange,
          child: Text(
            "${order['table']['name']}",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text("Order #${order['id']}"),
        subtitle: Text("Status: ${order['status']}"),
        trailing: const Icon(Icons.keyboard_arrow_down),
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Items:", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...finalItems.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Recipe Name: ${item['recipe']['recipeName'].toString()}"),
                      Text("Qty: ${item['qty']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(item['status'] ?? "ORDERED", style: const TextStyle(fontSize: 10)),
                      )
                    ],
                  ),
                )),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {/* Add Update Logic */},
                      icon: const Icon(Icons.print, size: 18),
                      label: const Text("Print KOT"),
                    ),
                    ElevatedButton(
                      onPressed: () {/* Add Settle/Bill Logic */},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                      child: const Text("Settle Bill"),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
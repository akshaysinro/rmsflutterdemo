import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key});

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  // Replace with your local IP for physical device testing
  final String apiUrl = "http://localhost:8080/tables/orders/COMPLETED";

  Future<List<dynamic>> _fetchCompletedOrders() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load history");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _fetchCompletedOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No completed orders found."));
          }

          final orders = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return _buildCompletedOrderCard(order);
            },
          );
        },
      ),
    );
  }

  Widget _buildCompletedOrderCard(dynamic order) {
    List<dynamic> items = order['orderItems'] ?? [];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.check_circle, color: Colors.green),
        title: Text("Table ${order['tableId']} - Order #${order['id']}"),
        subtitle: Text("${items.length} items • Finalized"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _showOrderDetails(order), // View full summary
      ),
    );
  }

  void _showOrderDetails(dynamic order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Order #${order['id']} Summary"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: (order['orderItems'] as List).length,
            itemBuilder: (context, i) {
              final item = order['orderItems'][i];
              return ListTile(
                dense: true,
                title: Text("Recipe ID: ${item['recipeId']}"),
                trailing: Text("Qty: ${item['count']}"),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
          ElevatedButton.icon(
            onPressed: () {}, // Optional: Print Invoice
            icon: const Icon(Icons.print),
            label: const Text("Print Bill"),
          )
        ],
      ),
    );
  }
}
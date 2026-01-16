import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("F&B Enterprise Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2, // Two columns for the two domains
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildDomainCard(
              context, 
              "E-POS", 
              Icons.table_chart, 
              const Color.fromARGB(255, 55, 23, 145), 
              '/pos',
            ),
            _buildDomainCard(
              context, 
              "Kitchen", 
              Icons.kitchen_sharp, 
              const Color.fromARGB(255, 148, 5, 105), 
              '/kitchen',
            ),
            _buildDomainCard(
              context, 
              "Recepie Manager", 
              Icons.food_bank, 
              Colors.orange, 
              '/recepie-setup'
            ),
            _buildDomainCard(
              context, 
              "Outlet Manager", 
              Icons.storefront, 
              Colors.orange, 
              '/outlet-setup'
            ),
            _buildDomainCard(
              context, 
              "Hotel Setup", 
              Icons.hotel, 
              Colors.blue, 
              '/hotel-setup'
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDomainCard(BuildContext context, String title, IconData icon, Color color, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
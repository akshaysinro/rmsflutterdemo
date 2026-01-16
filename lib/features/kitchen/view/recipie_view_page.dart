import 'package:flutter/material.dart';

class RecipeViewPage extends StatelessWidget {
  const RecipeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Color(0xFF1A1A1A)),
        title: const Text("RECIPE DETAILS", 
          style: TextStyle(color: Color(0xFF1A1A1A), fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined, color: Colors.blue)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.print_outlined, color: Colors.grey)),
          const SizedBox(width: 8),
        ],
        shape: const Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(),
            const Divider(height: 1),
            _buildCostSummary(),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Text("INGREDIENTS", 
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.1, color: Colors.grey)),
            ),
            _buildIngredientsList(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.restaurant_menu, color: Colors.blue.shade700, size: 40),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Truffle Beef Burger", 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text("Category: Main Course", style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCostSummary() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      color: const Color(0xFFF9F9FB),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetric("Total Cost", "\$4.20", Colors.green),
          _buildMetric("Prep Time", "15 mins", Colors.blue),
          _buildMetric("Difficulty", "Medium", Colors.orange),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildIngredientsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (context, index) => const Divider(indent: 24, endIndent: 24, height: 1),
      itemBuilder: (context, index) {
        return const ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          title: Text("Beef Patty (Prime)"),
          subtitle: Text("Waste factor: 2%"),
          trailing: Text("180g", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        );
      },
    );
  }
}
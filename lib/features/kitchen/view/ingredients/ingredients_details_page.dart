import 'package:flutter/material.dart';

class IngredientDetailPage extends StatelessWidget {
  final String ingredientId;

  const IngredientDetailPage({super.key, required this.ingredientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text("INGREDIENT INFO", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.history, color: Colors.blue)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined, color: Colors.grey)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildStockHeader(),
            const Divider(height: 1),
            _buildQuickStats(),
            _buildSectionHeader("ASSOCIATED RECIPES"),
            _buildLinkedRecipesList(),
            _buildSectionHeader("RECENT STOCK ADJUSTMENTS"),
            _buildStockLogs(),
          ],
        ),
      ),
    );
  }

  Widget _buildStockHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.category_outlined, color: Colors.blue.shade700, size: 30),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Assam Tea Leaves", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text("Asset ID: #003 • Raw Material", style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statItem("Current Stock", "1.5 kg", Colors.green),
          _statItem("Min Alert", "0.5 kg", Colors.orange),
          _statItem("Unit Cost", "\$12.00", Colors.black),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      color: const Color(0xFFF8F9FA),
      child: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.1)),
    );
  }

  Widget _buildLinkedRecipesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) => ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        leading: const Icon(Icons.restaurant_menu, size: 20),
        title: Text(index == 0 ? "Signature Milk Tea" : "Iced Assam Tea"),
        subtitle: Text("Uses: ${index == 0 ? '5g' : '8g'} per serving"),
        trailing: const Icon(Icons.chevron_right, size: 16),
      ),
    );
  }

  Widget _buildStockLogs() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) => ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        title: Text(index == 0 ? "Deducted (Order #102)" : "Restocked (Supplier)"),
        subtitle: Text("Jan 16, 2024 • 14:30"),
        trailing: Text(index == 0 ? "-10g" : "+5kg", 
          style: TextStyle(fontWeight: FontWeight.bold, color: index == 0 ? Colors.red : Colors.green)),
      ),
    );
  }
}
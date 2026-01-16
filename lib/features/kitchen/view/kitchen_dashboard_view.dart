import 'package:flutter/material.dart';
import 'package:flutter_rms/features/kitchen/view/widgets/kot_card.dart';
import '../presenter/kot_presenter.dart';

class KitchenDashboardPage extends StatefulWidget {
  final KotPresenter presenter;

  const KitchenDashboardPage({super.key, required this.presenter});

  @override
  State<KitchenDashboardPage> createState() => _KitchenDashboardPageState();
}

class _KitchenDashboardPageState extends State<KitchenDashboardPage> {
  @override
  void initState() {
    super.initState();
    widget.presenter.onLoadKots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Light grey background for better contrast with white cards
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          "KITCHEN DISPLAY SYSTEM",
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          _buildMetricChip(
            "Recipies",
            Colors.green.shade700,
            onPressed: () => widget.presenter.onRecipeBookPressed(context),
          ),

          _buildMetricChip("ACTIVE: 12", Colors.blue.shade700),
          _buildMetricChip("DELAYED: 3", Colors.red.shade700),

          const SizedBox(width: 16),
        ],
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemCount: 8,
        itemBuilder: (context, index) => KOTCardUI(presenter: widget.presenter),
      ),
    );
  }

  Widget _buildMetricChip(
    String label,
    Color color, {
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: () {
        onPressed != null ? onPressed() : null;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          border: Border.all(color: color.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

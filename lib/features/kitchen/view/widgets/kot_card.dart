import 'package:flutter/material.dart';
import '../../presenter/kot_presenter.dart';

class KOTCardUI extends StatelessWidget {
  final KotPresenter presenter;
  const KOTCardUI({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left accent border via a small Container instead of Border side
          // to keep the card look clean
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(height: 4, color: Colors.orange),
          ),

          // HEADER
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "KOT ID: 14",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "12m",
                    style: TextStyle(
                      color: Colors.orange.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text(
              "Table: 12",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
          const Divider(color: Color(0xFFEEEEEE), height: 1),

          // ITEM LIST
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _KOTItemRow(
                  qty: 2,
                  name: "Truffle Burger",
                  note: "No Onions",
                  presenter: presenter,
                ),
                _KOTItemRow(
                  qty: 1,
                  name: "Classic Fries",
                  note: "Extra Salt",
                  presenter: presenter,
                ),
                _KOTItemRow(qty: 3, name: "Coke Zero", presenter: presenter),
              ],
            ),
          ),

          // FOOTER (Visual Status Only)
          GestureDetector(
            onTapDown: (details) =>
                _showStatusMenu(context, details.globalPosition),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors
                    .orange
                    .shade100, // This color should come from ViewModel
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "IN PROGRESS",
                      style: TextStyle(
                        color: Colors.orange.shade900,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_drop_up, color: Colors.orange.shade900),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showStatusMenu(BuildContext context, Offset offset) async {
    final RenderObject? overlay = Overlay.of(
      context,
    ).context.findRenderObject();

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy - 100, // Positioned slightly above the touch point
        overlay!.paintBounds.size.width - offset.dx,
        0,
      ),
      items: [
        PopupMenuItem(
          value: 'accept',
          child: Row(
            children: const [
              Icon(Icons.check_circle_outline, color: Colors.blue),
              SizedBox(width: 12),
              Text("ACCEPT (Start)"),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'done',
          child: Row(
            children: const [
              Icon(Icons.assignment_turned_in_outlined, color: Colors.green),
              SizedBox(width: 12),
              Text("DONE (Bump)"),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Cancel',
          child: Row(
            children: const [
              Icon(Icons.cancel, color: Colors.red),
              SizedBox(width: 12),
              Text("Cancel (Stop)"),
            ],
          ),
        ),
      ],
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ).then((value) {
      if (value == 'accept') {
        // presenter.onAcceptTapped(kotId);
      } else if (value == 'done') {
        // presenter.onDoneTapped(kotId);
      }
    });
  }
}

class _KOTItemRow extends StatelessWidget {
  final int qty;
  final String name;
  final String? note;
  final KotPresenter presenter;

  const _KOTItemRow({
    required this.qty,
    required this.name,
    this.note,
    required this.presenter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Aligned for the button
            children: [
              // Quantity
              Text(
                "${qty}x",
                style: const TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),

              // Item Name
              Expanded(
                child: Text(
                  name.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // RECIPE BUTTON (New)
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    presenter.onRecipeDetailsPressed(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.menu_book_rounded,
                      size: 18,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Notes section
          if (note != null)
            Padding(
              padding: const EdgeInsets.only(left: 32, top: 4),
              child: Text(
                note!,
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

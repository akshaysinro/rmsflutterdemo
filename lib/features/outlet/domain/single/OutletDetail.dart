import 'package:flutter/material.dart';
import 'package:flutter_rms/features/outlet/services/OutletService.dart';

class OutletDetailPage extends StatefulWidget {
  final Map<String, dynamic> outlet;

  const OutletDetailPage({super.key, required this.outlet});

  @override
  State<OutletDetailPage> createState() => _OutletDetailPageState();
}

class _OutletDetailPageState extends State<OutletDetailPage> {
  final outletService = OutletService(baseUrl: 'http://localhost:8080');

  late TextEditingController nameController;
  late TextEditingController codeController;

  late bool isActive;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.outlet['name']);
    codeController = TextEditingController(text: widget.outlet['code']);
    isActive = widget.outlet['isActive'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Outlet Details"),
        actions: [
          // Activate / Deactivate
          IconButton(
            icon: Icon(isActive ? Icons.toggle_on : Icons.toggle_off, size: 30),
            onPressed: _toggleActiveStatus,
          ),

          // Delete
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: _confirmDelete,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Outlet Name"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(labelText: "Outlet Code"),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                const Text("Status: "),
                Chip(
                  label: Text(isActive ? "Active" : "Inactive"),
                  backgroundColor: isActive
                      ? Colors.green[100]
                      : Colors.red[100],
                ),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _updateOutlet,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: const Text("Update Outlet"),
        ),
      ),
    );
  }

  void _toggleActiveStatus() {
    setState(() {
      isActive = !isActive;
    });

    // Call API here
    outletService.toggleActive(widget.outlet['id']['value'].toString(), isActive);
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Outlet"),
        content: const Text("Are you sure you want to delete this outlet?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Delete needs to be implemented")),
              );
              // outletService.delete(widget.outlet['id']);
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // go back
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _updateOutlet() {
    final updatedOutlet = {
      "name": nameController.text,
      "code": codeController.text,
      "isActive": isActive,
    };

    // outletService.update(widget.outlet['id'], updatedOutlet);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Outlet updated needs to Implemented")),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rms/features/outlet/domain/single/OutletDetail.dart';
import 'package:http/http.dart' as http;

class OutletSetupPage extends StatefulWidget {
  const OutletSetupPage({super.key});

  @override
  State<OutletSetupPage> createState() => _OutletSetupPageState();
}

class _OutletSetupPageState extends State<OutletSetupPage> {
  final _formKey = GlobalKey<FormState>();

  // State Data
  List<dynamic> _outlets = [];
  Map<String, dynamic> _currentHotel = {};
  bool _isLoading = true;

  // Controllers for the Modal Form
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  String _selectedType = 'RESTAURANT';

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  // Fetch both Hotel info and the list of Outlets
  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    try {
      final hotelRes = await http.get(Uri.parse('http://localhost:8080/hotel'));
      final outletRes = await http.get(
        Uri.parse('http://localhost:8080/outlet/all'),
      );

      if (hotelRes.statusCode == 200 && outletRes.statusCode == 200) {
        setState(() {
          _currentHotel = jsonDecode(hotelRes.body);
          _outlets = jsonDecode(outletRes.body);
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error refreshing data: $e");
      setState(() => _isLoading = false);
    }
  }

  // The Modal Popup Form
  void _showAddOutletModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows keyboard to push modal up
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // Keyboard padding
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Add New Outlet",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Outlet Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    labelText: "Unique Code",
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  initialValue: _selectedType,
                  decoration: const InputDecoration(
                    labelText: "Type",
                    border: OutlineInputBorder(),
                  ),
                  items:
                      [
                            'RESTAURANT',
                            'BAR',
                            'CAFE',
                            'GYM',
                            'SHOP',
                            'SWIMMING_POOL',
                          ]
                          .map(
                            (t) => DropdownMenuItem(value: t, child: Text(t)),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => _selectedType = val!),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitOutlet,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("Save Outlet"),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitOutlet() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        "hotelId": _currentHotel['id']['value'].toString(),
        "name":
            _nameController.text, // Field names match your Domain Outlet.java
        "code": _codeController.text,
        "type": _selectedType,
        "status": "ACTIVE",
        "isActive": true,
      };

      final response = await http.post(
        Uri.parse('http://localhost:8080/outlet'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        Navigator.pop(context); // Close Modal
        _nameController.clear();
        _codeController.clear();
        _refreshData(); // Refresh the list
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Outlets: ${_currentHotel['name'] ?? 'Loading...'}"),
        actions: [
          IconButton(onPressed: _refreshData, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _outlets.isEmpty
          ? const Center(child: Text("No outlets registered yet."))
          : ListView.builder(
              itemCount: _outlets.length,
              itemBuilder: (context, index) {
                final outlet = _outlets[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.store)),
                    title: Text(outlet['name']),
                    subtitle: Text(
                      "Code: ${outlet['code']} | Type: ${outlet['type']}",
                    ),
                    trailing: Icon(
                      Icons.circle,
                      color: outlet['isActive'] ? Colors.green : Colors.red,
                      size: 12,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OutletDetailPage(outlet: outlet),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddOutletModal,
        label: const Text("New Outlet"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

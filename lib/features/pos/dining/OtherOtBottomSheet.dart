import 'package:flutter/material.dart';

class OtherKOTBottomSheet extends StatefulWidget {
  const OtherKOTBottomSheet({Key? key}) : super(key: key);

  @override
  State<OtherKOTBottomSheet> createState() => _OtherKOTBottomSheetState();
}

class _OtherKOTBottomSheetState extends State<OtherKOTBottomSheet> {
  String? _orderType; // 'parcel' or 'delivery'

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  void _submitOrder() {
    if (_orderType == null) {
      _showError('Please select Parcel or Delivery');
      return;
    }

    if (_nameController.text.isEmpty ||
        _mobileController.text.isEmpty ||
        _placeController.text.isEmpty) {
      _showError('Please fill all customer details');
      return;
    }

    final requestBody = {
      "orderType": _orderType,
      "name": _nameController.text,
      "mobile": _mobileController.text,
      "place": _placeController.text,
    };

    // TODO: Replace with your backend API call
    print("Submitting Order: $requestBody");

    Navigator.pop(context); // Close bottom sheet after submit
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Text(
                'Other KOT',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            /// Order Type Selection
            const Text(
              'Order Type',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            RadioListTile<String>(
              title: const Text('Parcel'),
              value: 'parcel',
              groupValue: _orderType,
              onChanged: (value) {
                setState(() {
                  _orderType = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Delivery'),
              value: 'delivery',
              groupValue: _orderType,
              onChanged: (value) {
                setState(() {
                  _orderType = value;
                });
              },
            ),

            /// Customer Details (shown only if selected)
            if (_orderType != null) ...[
              const SizedBox(height: 12),
              const Text(
                'Customer Details',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Customer Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: _placeController,
                decoration: const InputDecoration(
                  labelText: 'Place',
                  border: OutlineInputBorder(),
                ),
              ),
            ],

            const SizedBox(height: 20),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitOrder,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

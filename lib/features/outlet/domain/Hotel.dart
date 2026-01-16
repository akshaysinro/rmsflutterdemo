import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HotelSetupPage extends StatefulWidget {
  const HotelSetupPage({super.key});

  @override
  _HotelSetupPageState createState() => _HotelSetupPageState();
}

class _HotelSetupPageState extends State<HotelSetupPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Attributes
  String name = '';
  String license = '';
  double stars = 1.0;
  String ownership = 'Private';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Hotel Profile")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Hotel Name'),
              onSaved: (val) => name = val!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'License Number'),
              onSaved: (val) => license = val!,
            ),
            DropdownButtonFormField(
              initialValue: ownership,
              items: ['Private', 'Corporate', 'Franchise']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => ownership = val as String),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text("Star Rating: ${stars.toInt()} Stars"),
            ),
            Slider(
              value: stars,
              min: 1, max: 5, divisions: 4,
              onChanged: (val) => setState(() => stars = val),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text("Register Hotel & Login"),
            )
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      Map<String, dynamic> hotel = {
        "name": name,
        "licenseNumber": license,
        "stars": stars,
        "ownership": ownership,
      };
      try {
        final response = await http.post(
          Uri.parse("http://localhost:8080/hotel"),
          body: json.encode(hotel),
          headers: {
            "Content-Type": "application/json",
          },
        );
        if (response.statusCode == 201) {
          print("Hotel saved successfully");
        } else {
          print("Failed to save hotel");
        }
      } catch (e) {
        print("Error saving hotel: $e");
      }
      print("Saving Hotel: $hotel");
    }
  }
}
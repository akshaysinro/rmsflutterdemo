import 'dart:convert';
import 'package:http/http.dart' as http;

class OutletService {
  final String baseUrl;

  OutletService({required this.baseUrl});

  // =================== FETCH ALL OUTLETS ===================
  /*Future<List<Map<String, dynamic>>> fetchOutlets() async {
    final res = await http.get(Uri.parse('$baseUrl/outlet/all'));

    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e)).toList();
    } else {
      throw Exception('Failed to fetch outlets');
    }
  }

  // =================== FETCH HOTEL ===================
  Future<Map<String, dynamic>> fetchHotel() async {
    final res = await http.get(Uri.parse('$baseUrl/hotel'));

    if (res.statusCode == 200) {
      return Map<String, dynamic>.from(json.decode(res.body));
    } else {
      throw Exception('Failed to fetch hotel');
    }
  }

  // =================== CREATE OUTLET ===================
  Future<void> createOutlet(Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse('$baseUrl/outlet'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    if (res.statusCode != 201) {
      throw Exception('Failed to create outlet');
    }
  }
  */

  // =================== UPDATE OUTLET ===================
  Future<void> updateOutlet(String id, Map<String, dynamic> data) async {
    final res = await http.put(
      Uri.parse('$baseUrl/outlet/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to update outlet');
    }
  }

  // =================== TOGGLE ACTIVE ===================
  Future<void> toggleActive(String id, bool isActive) async {
    final res = await http.patch(
      Uri.parse('$baseUrl/outlet/$id/toggleActive'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"isActive": isActive}),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to toggle outlet status');
    }
  }

  // =================== DELETE OUTLET ===================
  Future<void> deleteOutlet(String id) async {
    final res = await http.delete(
      Uri.parse('$baseUrl/outlet/$id'),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to delete outlet');
    }
  }
}

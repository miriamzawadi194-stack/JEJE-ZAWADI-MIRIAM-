import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost/api-test/public';

  static Future<bool> testerConnexion() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/famille-membres'));
      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> seConnecter(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/accounts/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      final data = jsonDecode(res.body);
      return res.statusCode == 200 && data['success'] == true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getFamilyMembers() async {
    final res = await http.get(Uri.parse('$baseUrl/famille-membres'));
    final data = jsonDecode(res.body);
    final List list = data['data'] ?? [];
    return list.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static Future<bool> ajouterMembre(Map<String, dynamic> membre) async {
    final res = await http.post(
      Uri.parse('$baseUrl/famille-membres'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(membre),
    );
    final data = jsonDecode(res.body);
    return res.statusCode == 200 && data['success'] == true;
  }

  static Future<bool> modifierMembre(int id, Map<String, dynamic> membre) async {
    final res = await http.put(
      Uri.parse('$baseUrl/famille-membres/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(membre),
    );
    final data = jsonDecode(res.body);
    return res.statusCode == 200 && data['success'] == true;
  }

  static Future<bool> supprimerMembre(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/famille-membres/$id'));
    final data = jsonDecode(res.body);
    return res.statusCode == 200 && data['success'] == true;
  }
}

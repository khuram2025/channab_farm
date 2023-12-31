import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  String? _authToken;
  final String _baseUrl = 'http://farmapp.channab.com';

  // Setter for authToken
  set authToken(String? token) {
    _authToken = token;
  }

  // Function to perform login
  Future<http.Response> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/accounts/api/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    return response;
  }

  // Function to fetch animals
  Future<List<dynamic>> fetchAnimals() async {
    if (_authToken == null) {
      throw Exception('Authentication token not found');
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/dairy/api/animals/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $_authToken',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['animals'];
      } else {
        print('Server response: ${response.body}');
        throw Exception('Failed to load animals: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while fetching animals: $e');
      throw Exception('Error occurred: $e');
    }
  }

  Future<Map<String, dynamic>> fetchAnimalDetails(int animalId) async {
    if (_authToken == null) {
      throw Exception('Authentication token not found');
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/dairy/api/animals/$animalId/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $_authToken',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Server response: ${response.body}');
        throw Exception('Failed to load animal details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while fetching animal details: $e');
      throw Exception('Error occurred: $e');
    }
  }
  Future<Map<String, dynamic>> fetchMilkRecords(int animalId, String timeFilter) async {
    if (_authToken == null) {
      throw Exception('Authentication token not found');
    }

    String url;
    if (timeFilter.contains('~')) {
      List<String> dates = timeFilter.split('~');
      String startDate = dates[0];
      String endDate = dates[1];
      url = '$_baseUrl/dairy/api/animals/$animalId/?time_filter=custom&start_date=$startDate&end_date=$endDate';
    } else {
      url = '$_baseUrl/dairy/api/animals/$animalId/?time_filter=$timeFilter';
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $_authToken',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Server response: ${response.body}');
        throw Exception('Failed to load milk records: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while fetching milk records: $e');
      throw Exception('Error occurred: $e');
    }
  }
  Future<Map<String, dynamic>> fetchMilkRecordsWithCustomRange(int animalId, String startDate, String endDate) async {
    if (_authToken == null) {
      throw Exception('Authentication token not found');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/dairy/api/animals/$animalId/?time_filter=custom&start_date=$startDate&end_date=$endDate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_authToken',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Server response: ${response.body}');
      throw Exception('Failed to load milk records: ${response.statusCode}');
    }
  }

}

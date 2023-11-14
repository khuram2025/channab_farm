import 'package:flutter/material.dart';
import '../widgets/animalCard.dart';
import 'filter_icon_widget.dart'; // Import the FilterIconWidget

class _LoginPageState extends State<LoginPage> {
  // ... other fields and methods ...

  void _handleLogin() async {
    try {
      final response = await _apiService.login(
        _phoneController.text,
        _passwordController.text,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _apiService.authToken = data['token']; // Set token in ApiService
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AnimalListPage(),
            settings: RouteSettings(arguments: data['token']),
          ),
        );
      } else {
        print('Login failed: ${response.body}');
      }
    } catch (e) {
      print('Login failed: $e');
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

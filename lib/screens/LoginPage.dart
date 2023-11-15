import 'package:channab_frm/api/ApiService.dart';
import 'package:channab_frm/screens/AnimalListPage.dart';
import 'package:channab_frm/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TODO: Remove these default values after testing
  final TextEditingController _phoneController = TextEditingController(text: '+966590964893'); // Prefilled username for testing
  final TextEditingController _passwordController = TextEditingController(text: 'Read@123'); // Prefilled password for testing
  final ApiService _apiService = ApiService();
  String? _loginToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                hintText: '+923478181583',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleLogin, // Call the _handleLogin method here
              child: Text('Login'),
            ),


            TextButton(
              onPressed: () {
                // TODO: Navigate to Signup Screen
              },
              child: Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
  void _handleLogin() async {
    try {
      final response = await _apiService.login(
        _phoneController.text,
        _passwordController.text,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _apiService.authToken = data['token'];
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
    } on http.ClientException catch (e) {
      // Handle XMLHttpRequest error
      print('Login failed: $e');
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
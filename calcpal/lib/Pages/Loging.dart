import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalcPal',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.utc(2024);

  void _login() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String selectedDate =
        _selectedDate != null ? _selectedDate.toString() : 'No Date Selected';

    // Here you can implement your login logic
    // For simplicity, I'm just showing a print statement
    print(
        'Username: $username, Password: $password, Selected Date: $selectedDate');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenHeight * 0.7; // 70% of screen height for image
    final boxSize = screenHeight * 0.4;
    return Scaffold(
      body: Stack(
        children: [
          // Image at the top
          Container(
            // alignment: Alignment.topCenter,
            height: imageHeight,
            width: screenWidth,
            child: Image.asset('assets/Images/back.jpeg', fit: BoxFit.cover),
          ),

          // Login fields at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: boxSize,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                          _dateController.text =
                              '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}';
                        });
                      }
                    },
                    child: Text(
                      _selectedDate != null
                          ? 'Selected Date: ${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}'
                          : 'Select Date',
                    ),
                  ),
                  TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      hintText: 'Select a date',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                    readOnly:
                        true, // To prevent manual editing of the text field
                  ),
                  
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

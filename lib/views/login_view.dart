import 'package:flutter/material.dart';
import 'package:songtrace/navigation/tabbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final String correctUsername = "bittrozki";
  final String correctPassword = "bittrozki";

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (_usernameController.text == correctUsername &&
          _passwordController.text == correctPassword) {
        // Successful login
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login Successful!"),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Tabbar()));
      } else {
        // Invalid credentials
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid username or password"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo (optional)
                const Text(
                  "Log in to Spotify",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Username Field
                TextFormField(
                  controller: _usernameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Email or username",
                    labelStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your username";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Login Button
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                  ),
                  child: const Text(
                    "Log In",
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 20),

                // Forgot Password and Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Add functionality for forgot password
                      },
                      child: const Text(
                        "Forgot your password?",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

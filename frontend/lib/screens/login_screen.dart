import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_spend_ai/screens/bottom_nav_screen.dart';

import '../providers/auth_provider.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Future<void> login() async {
  //   final auth = context.read<AuthProvider>();

  //   if (!_formKey.currentState!.validate()) {
  //     return;
  //   }

  //   final success = await auth.login(
  //     email: emailController.text.trim(),
  //     password: passwordController.text.trim(),
  //   );

  //   if (!mounted) return;

  //   if (success) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => const DashboardScreen()),
  //     );
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => const BottomNavScreen()),
  //     );
  //   } else {
  //     debugPrint("❌ Login Failed");
  //     debugPrint("❌ Error: ${auth.error}");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text(auth.error ?? "Login Failed"),
  //       ),
  //     );
  //   }
  // }

  Future<void> login() async {
    debugPrint("🔥 LOGIN BUTTON CLICKED");

    final auth = context.read<AuthProvider>();

    if (!_formKey.currentState!.validate()) {
      debugPrint("❌ FORM VALIDATION FAILED");

      return;
    }

    debugPrint("📧 Email: ${emailController.text.trim()}");

    final success = await auth.login(
      email: emailController.text.trim(),

      password: passwordController.text.trim(),
    );

    debugPrint("🚀 LOGIN SUCCESS VALUE: $success");

    debugPrint("⚠️ AUTH ERROR: ${auth.error}");

    if (!mounted) return;

    if (success) {
      debugPrint("✅ NAVIGATING TO DASHBOARD");

      if (success) {
        print("LOGIN SUCCESS");

        await Future.delayed(const Duration(milliseconds: 300));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BottomNavScreen()),
        );
      }
    } else {
      debugPrint("❌ LOGIN FAILED");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,

          content: Text(auth.error ?? "Login Failed"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          backgroundColor: const Color(0xff050505),

          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),

                child: Form(
                  key: _formKey,

                  child: Column(
                    children: [
                      const Icon(
                        Icons.account_balance_wallet_rounded,
                        size: 90,
                        color: Colors.cyanAccent,
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "SmartSpend AI",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Sign in to continue",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 40),

                      TextFormField(
                        controller: emailController,

                        keyboardType: TextInputType.emailAddress,

                        style: const TextStyle(color: Colors.white),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Email";
                          }

                          if (!value.contains("@")) {
                            return "Invalid Email";
                          }

                          return null;
                        },

                        decoration: InputDecoration(
                          labelText: "Email",

                          labelStyle: const TextStyle(color: Colors.white70),

                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.cyanAccent,
                          ),

                          filled: true,
                          fillColor: Colors.white10,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller: passwordController,

                        obscureText: obscurePassword,

                        style: const TextStyle(color: Colors.white),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Password";
                          }

                          if (value.length < 6) {
                            return "Minimum 6 characters";
                          }

                          return null;
                        },

                        decoration: InputDecoration(
                          labelText: "Password",

                          labelStyle: const TextStyle(color: Colors.white70),

                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.cyanAccent,
                          ),

                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),

                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),

                          filled: true,
                          fillColor: Colors.white10,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),

                      const SizedBox(height: 35),

                      SizedBox(
                        width: double.infinity,
                        height: 55,

                        child: ElevatedButton(
                          onPressed: auth.isLoading ? null : login,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),

                          child: auth.isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.black,
                                  ),
                                )
                              : const Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.white70),
                          ),

                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },

                            child: const Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

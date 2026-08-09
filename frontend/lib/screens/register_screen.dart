import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();

    final success = await auth.register(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    // Console Logs
    debugPrint("========== REGISTER ==========");
    debugPrint("Success : $success");
    debugPrint("Error   : ${auth.error}");
    debugPrint("==============================");

    if (!mounted) return;

    if (success) {
      debugPrint("✅ Registration Successful");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registration Successful"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } else {
      debugPrint("❌ Registration Failed");
      debugPrint("❌ ${auth.error}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.error ?? "Registration Failed"),
          backgroundColor: Colors.red,
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

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text("Create Account"),
          ),

          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),

              child: Form(
                key: formKey,

                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    const Icon(
                      Icons.person_add,
                      size: 90,
                      color: Colors.cyanAccent,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 35),

                    TextFormField(
                      controller: nameController,

                      style: const TextStyle(color: Colors.white),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Name";
                        }

                        return null;
                      },

                      decoration: InputDecoration(
                        labelText: "Name",

                        prefixIcon: const Icon(Icons.person),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                        filled: true,
                        fillColor: Colors.white10,
                      ),
                    ),

                    const SizedBox(height: 20),

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

                        prefixIcon: const Icon(Icons.email),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                        filled: true,
                        fillColor: Colors.white10,
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: passwordController,

                      obscureText: hidePassword,

                      style: const TextStyle(color: Colors.white),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Password";
                        }

                        if (value.length < 6) {
                          return "Minimum 6 Characters";
                        }

                        return null;
                      },

                      decoration: InputDecoration(
                        labelText: "Password",

                        prefixIcon: const Icon(Icons.lock),

                        suffixIcon: IconButton(
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),

                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                        filled: true,
                        fillColor: Colors.white10,
                      ),
                    ),

                    const SizedBox(height: 35),

                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(
                        onPressed: auth.isLoading ? null : register,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyanAccent,
                          foregroundColor: Colors.black,
                        ),

                        child: auth.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : const Text(
                                "REGISTER",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(color: Colors.cyanAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

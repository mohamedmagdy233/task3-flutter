import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group_1/app_settings.dart';
import 'package:flutter_group_1/views/screens/home_page.dart';
import 'package:flutter_group_1/views/widgets/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              SizedBox(
                width: 150,
                height: 150,
                child: Image.network(
                  "https://w7.pngwing.com/pngs/537/866/png-transparent-flutter-hd-logo.png",
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    prefixIcon: const Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value!.length > 8 && value.length < 10) {
                      return null;
                    } else {
                      return "Invalid Phone number";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value!.length < 8) {
                      return "Invalid Password";
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (kDebugMode) {
                      print("Logged in");
                    }
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString(
                      AppSettings.phoneNumberSharedPrefsKey,
                      phoneNumberController.text,
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );

                    passwordController.clear();
                  }
                },
                child: const Text("Log in"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[300],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  // Implement Forgot Password functionality
                  if (kDebugMode) {
                    print("Forgot Password");
                  }
                },
                child: const Text("Forgot Password?. Tap me"),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement Sign Up functionality
                  if (kDebugMode) {
                    print("Sign up");
                  }
                },
                child: const Text("No account, sign up"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

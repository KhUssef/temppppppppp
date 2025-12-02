import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/Custom_Input_Decoration.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final currentKey = GlobalKey<FormState>();
  String username = "";
  String password = "";
  String address = "";
  String birthdate = "";
  String email = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: currentKey,
        child: ListView(
          children: [
            //1: Image
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Image.asset("assets/images.png", width: 250),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                decoration: CustomInputDecoration.getInputDecoration(
                  labelText: "UserName",
                  hintText: "Enter your UserName",
                  prefixIcon: const Icon(Icons.person_3_outlined),
                ),
                onSaved: (newValue) => username = newValue!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "UserName should not be empty";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                decoration: CustomInputDecoration.getInputDecoration(
                  labelText: "email",
                  hintText: "Enter your email",
                  prefixIcon: const Icon(Icons.mail_outline),
                ),
                onSaved: (newValue) => email = newValue!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "email should not be empty";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                decoration: CustomInputDecoration.getInputDecoration(
                  labelText: "password",
                  hintText: "Enter your password",
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
                obscureText: true,
                onSaved: (newValue) => password = newValue!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "password should not be empty";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                decoration: CustomInputDecoration.getInputDecoration(
                  labelText: "birth date",
                  hintText: "Enter your date of birth",
                  prefixIcon: const Icon(Icons.cake),
                ),
                onSaved: (newValue) => birthdate = newValue!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "birth date should not be empty";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                decoration: CustomInputDecoration.getInputDecoration(
                  labelText: "address",
                  hintText: "Enter your address",
                  prefixIcon: const Icon(Icons.house_outlined),
                ),
                onSaved: (newValue) => address = newValue!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "address should not be empty";
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (currentKey.currentState!.validate()) {
                  currentKey.currentState!.save();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("SignUp"),
                        content: Text(
                          "User added successfully! check your inbox",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/bottombar');
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

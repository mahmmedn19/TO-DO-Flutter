import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_assets.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Lottie.asset(AppAssets.todoLogo),
                const SizedBox(height: 24.0),
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: _email,
                  onChanged: (value) {
                    // this when change
                  },
                  validator: (value) {
                    // this for valid
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    hintText: 'Enter Name',
                    hintStyle: TextStyle(fontSize: 12),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _name,
                  onChanged: (value) {
                    // this when change
                  },
                  validator: (value) {
                    // this for valid
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    hintText: 'Enter Email',
                    hintStyle: TextStyle(fontSize: 12),
                    suffixIconColor: Colors.black38,
                    suffixIcon: Icon(Icons.supervised_user_circle_outlined),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _password,
                  onChanged: (value) {
                    // this when change
                  },
                  validator: (value) {
                    // this for valid
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(fontSize: 12),
                    suffixIconColor: Colors.black38,
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                ),
                const SizedBox(height: 32.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: Colors.black87,
                  child: MaterialButton(
                    onPressed: () {
                      /*if (_key.currentState!.validate()) {
                        _dateSource.register(user, _controllerPassword.text);
                      }*/
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Have an account!",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

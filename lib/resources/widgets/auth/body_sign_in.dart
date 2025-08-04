import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/firebase_auth_controller.dart';
import '../../../views/auth/sign_up_screen.dart';
import '../../constants.dart';
import 'auth_button.dart';
import 'auth_text_input.dart';

class BodySignIn extends StatelessWidget {
  final TextEditingController emailEditingController;
  final TextEditingController passwordEditingController;

  const BodySignIn({
    Key? key,
    required this.emailEditingController,
    required this.passwordEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const SizedBox(height: 20),
          AuthTextInput(
            controller: emailEditingController,
            lableText: "Email",
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          AuthTextInput(
            controller: passwordEditingController,
            lableText: "Password",
            keyboardType: TextInputType.text,
            obscure: true,
          ),
          const SizedBox(height: 30),
          AuthButton(
            onTap: () {
              context.read<FirebaseAuthController>().signInWithEmailAndPassword(
                email: emailEditingController.text.trim(),
                password: passwordEditingController.text.trim(),
              );
            },
            title: "Sign In",
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?", style: txtRegular(14)),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                  );
                },
                child: Text("Sign Up", style: txtSemiBold(16, primaryColor)),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              const Expanded(child: Divider(color: Color(0xFFB4B4B4))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("OR", style: txtBold(14)),
              ),
              const Expanded(child: Divider(color: Color(0xFFB4B4B4))),
            ],
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              context.read<FirebaseAuthController>().signInWithGoogle();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: secondaryColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(googleIcon, height: 24, width: 24),
                    const SizedBox(width: 12),
                    Text("Continue with Google", style: txtMedium(16)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

/*
class BodySignIn extends StatelessWidget {

  const BodySignIn({
  Key? key,
  required this.emailEditingController,
  required this.passwordEditingController,

  @override
  Widget build(BuildContext context) {
  return Padding(
  padding: const EdgeInsets.symmetric (horizontal: 32),
  child: Column(
  children:[
  AuthTextInput(
  controller: emailEditingController,
  lableText: "Email",
  keyboardType: TextInputType.emailAddress,
  ),
  SizedBox(height: 30),
  AuthTextInput(
  controller: passwordEditingController,
  lableText: "Password",
  keyboardType: TextInputType.text,
  obscure: true,
  ),
  SizedBox(height: 30),
  AuthButton(
  onTap: () {
  context.read<FirebaseAuthController>().signInWithEmailAndPassword(
  email: emailEditingController.text.trim(),
  password: passwordEditingController.text.trim());
  },
  title: "Sign In"), // AuthButton
  SizedBox (height: 30),
  Row(
children: [
  style: txtRegular(14),
  ),//Text
  TextButton(
  onPressed:() {
  Navigator.push(context,
  MaterialPageRoute (builder: (_) => SignUpScreen()));
  },
  child:Text(
  "Sign Up",
  style: txtSemiBold(18, primaryColor),
  )) // Text, TextButton
  ],
  ), // Row
  SizedBox(height: 50),
  Row(
  children: [
  Expanded(child: Divider(color: secondaryColor)),
  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 18),
  child: Text(
  "OR",
style: txtBold(16),
*/

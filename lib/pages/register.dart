import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseloginapp/widgets/reusable_button.dart';
import 'package:firebaseloginapp/widgets/reusable_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  void Function()? onTap;
  RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> signUp() async {
    //show loading
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(color: Colors.grey[700]),
        );
      },
    );

    //try to create user
    try {
      //check password confirmed
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        //show error message
        errorMessage('Passwords don\'t match!');
      }

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      //wrong e-mail
      if (e.code == 'user-not-found') {
        errorMessage('Incorrect Email');
      }
      //wrong password
      else {
        errorMessage('Incorrect Password');
      }
    }
  }

  void errorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign Up Failed'),
          content: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Icon(Icons.lock, size: 100),
                const SizedBox(height: 25),
                Text(
                  'Let\'s Create your account!',
                  style: TextStyle(color: Colors.grey[800], fontSize: 22),
                ),
                const SizedBox(height: 25),
                ReusableTextField(controller: emailController, hintText: 'E-mail', obscureText: false),
                ReusableTextField(controller: passwordController, hintText: 'Password', obscureText: true),
                ReusableTextField(controller: confirmPasswordController, hintText: 'Confirm Password', obscureText: true),
                const SizedBox(height: 10),
                const SizedBox(height: 25),
                ReusableButton(onTap: () => signUp(), text: 'Sign Up'),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

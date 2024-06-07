import 'dart:developer';

import 'package:d_art/application/controller/auth_service.dart';
import 'package:d_art/presentation/widgets/AfterLoginPage/messagepage.dart';
import 'package:d_art/presentation/widgets/Signuppage/signuppage.dart';
import 'package:d_art/presentation/widgets/commonwidgets/textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Loginpage extends StatelessWidget {
  Loginpage({super.key});

  final _auth = AuthService();

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Lottie.asset('assets/login.json',
                        width: 2000, height: 260),
                  ),
                ),
                const Text(
                  'Log in',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                customformfield(
                  'E mail',
                  _email,
                  TextInputType.emailAddress,
                  false,
                  (value) {
                    const pattern =
                        (r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                    final regex = RegExp(pattern);

                    return value == null ||
                            value.isEmpty ||
                            !regex.hasMatch(value)
                        ? 'Enter a valid email address'
                        : null;
                  },
                ),
                customformfield('Password', _password, TextInputType.text, true,
                    (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                }),
                Padding(
                  padding: const EdgeInsets.only(left: 35, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('Forgot password?'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (builder) => SignupPage(),
                              ));
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(),
                            onPressed: () => _login(context),
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'Or',
                    style: TextStyle(fontSize: 19),
                  ),
                ),
                SignInButton(
                  Buttons.google,
                  onPressed: () => signInWithGoogle(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  gotoHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MessagePage()),
      );

  _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final userDetails = await _auth.getUserDetails();
      if (userDetails['email'] == null || userDetails['password'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('User not signed up. Please sign up first.'),
        ));
        return;
      }
      if (userDetails['email'] != _email.text) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Enter correct email or you don\'t have a valid email.'),
        ));
        return;
      }
      if (userDetails['password'] != _password.text) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Enter valid password.'),
        ));
        return;
      }
      final user =
          await _auth.LoginUserWithEmailAndPAss(_email.text, _password.text);
      if (user != null) {
        log('User Logged in');
        gotoHome(context);
      }
    }
  }

  signInWithGoogle(BuildContext context) async {
    log('message jiiii');
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      log('message');
      if (googleUser != null) {
        GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MessagePage()),
        );
        log('hiii log in aay');
        print(userCredential.user?.displayName);
      } else {
        log('Google sign-in failed.');
      }
    } catch (e) {
      log('ERROR ON AUTH LOGIN >> : $e');
    }
  }
}

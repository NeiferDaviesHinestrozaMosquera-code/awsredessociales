import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.configure(amplifyconfig);
      print('Successfully configured');
    } on Exception catch (e) {
      print('Error configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
  // builder used to show a custom sign in and sign up experience
  authenticatorBuilder: (BuildContext context, AuthenticatorState state) {
    const padding = EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16);
    switch (state.currentStep) {
      case AuthenticatorStep.signIn:
        return Scaffold(
          body: Padding(
            padding: padding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // app logo
                  // const Center(child: FlutterLogo(size: 100)),
                     Container(
              height: 120,
              child: Image.asset('assets/ali.png'),
              ),

             SizedBox(height: 20),

                  // prebuilt sign in form from amplify_authenticator package
                  SignInForm(),
                ],
              ),
            ),
          ),
          // custom button to take the user to sign up
          persistentFooterButtons: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () => state.changeStep(
                    AuthenticatorStep.signUp,
                  ),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        );
      case AuthenticatorStep.signUp:
        return Scaffold(
          
          body: Padding(
            padding: padding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // app logo
                  const Center(child: FlutterLogo(size: 100)),
                  // prebuilt sign up form from amplify_authenticator package
                  SignUpForm(),
                ],
              ),
            ),
          ),
          // custom button to take the user to sign in
          persistentFooterButtons: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () => state.changeStep(
                    AuthenticatorStep.signIn,
                  ),
                  child: const Text('Sign In'),
                  
                ),
              ],
            ),
          ],
        );
      default:
        // returning null defaults to the prebuilt authenticator for all other steps
        return null;
    }
  },
  child: MaterialApp(
    builder: Authenticator.builder(),
    home:  Scaffold(
      
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hola'),
        ),
      body: Column(
        children: [
          Text('You are logged in! Davies'),
          SignOutButton(),
          ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:topline/Constants/Models/signupModels.dart';
import 'package:topline/Constants/animation.dart';
import 'package:topline/Constants/colors.dart';
import 'package:topline/Constants/helperFunctions.dart';
import 'package:topline/Constants/routes.dart';
import 'package:topline/providers/authentication_provider.dart';
import 'package:topline/providers/credential_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

final TextEditingController patientNameController = TextEditingController();
final TextEditingController emiratesIdController = TextEditingController();
final TextEditingController mobileNumberController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();

bool isLoading = false;
bool _obsecureText = true;
bool _confirmobsecureText = true;

Timer? _timer;

class _SignupPageState extends State<SignupPage> {
  void _toggleObscureText() {
    setState(() {
      _obsecureText = !_obsecureText;
      _confirmobsecureText = !_confirmobsecureText;
    });

    if (!_obsecureText || !_confirmobsecureText) {
      _timer?.cancel();
      _timer = Timer(const Duration(seconds: 1), () {
        setState(() {
          _obsecureText = true;
          _confirmobsecureText = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  'assets/Loading.gif',
                  scale: 1.sp,
                ),
              ),
            )
          : Stack(
              children: [
                // Top Left Gradient Container
                Positioned(
                  top: -150,
                  left: -150,
                  child: Container(
                    width: 310.h,
                    height: 310.h,
                    decoration: const BoxDecoration(
                      color: primarylightPurple,
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [primarylightPurple, primarylightPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                // Bottom Right Gradient Container
                Positioned(
                  bottom: -150,
                  right: -150,
                  child: Container(
                    width: 350.sp,
                    height: 350.sp,
                    decoration: const BoxDecoration(
                      color: whitelightPurple,
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [whitelightPurple, whitelightPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Placeholder for the Logo
                        Container(
                          alignment: Alignment.topRight,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            //  crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Tablet EMR',
                                style: TextStyle(
                                  color: primaryPurple,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // const SizedBox(width: 5),
                              Image.asset(
                                'assets/logo.png',
                                scale: 4.h,
                              ),
                              // const SizedBox(width: 10),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Login Form Containerrrr
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Email TextField
                              FadeAnimation(
                                1.1,
                                TextField(
                                  controller: patientNameController,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    prefixIcon: const Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Password TextField
                              FadeAnimation(
                                1.2,
                                TextField(
                                  controller: emiratesIdController,
                                  decoration: InputDecoration(
                                    labelText: 'Emirates ID',
                                    prefixIcon: const Icon(
                                        Icons.card_membership_rounded),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Password TextField
                              FadeAnimation(
                                1.3,
                                TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: const Icon(Icons.mail),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Password TextField
                              FadeAnimation(
                                1.4,
                                TextField(
                                  controller: mobileNumberController,
                                  decoration: InputDecoration(
                                    labelText: 'Phone',
                                    prefixIcon: const Icon(Icons.phone),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              FadeAnimation(
                                1.5,
                                TextField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    labelText: 'UserName',
                                    prefixIcon: const Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              FadeAnimation(
                                1.6,
                                TextField(
                                  controller: passwordController,
                                  obscureText: _confirmobsecureText,
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      prefixIcon: const Icon(Icons.lock),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      suffixIcon: IconButton(
                                          onPressed: _toggleObscureText,
                                          icon: _confirmobsecureText
                                              ? const Icon(
                                                  Icons.visibility,
                                                  color: primarylightPurple,
                                                )
                                              : const Icon(
                                                  Icons.visibility_off,
                                                  color: primarylightPurple,
                                                ))),
                                ),
                              ),
                              const SizedBox(height: 10),
                              FadeAnimation(
                                1.7,
                                TextField(
                                  controller: confirmPasswordController,
                                  obscureText: _obsecureText,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    prefixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    suffixIcon: IconButton(
                                        onPressed: _toggleObscureText,
                                        icon: _obsecureText
                                            ? const Icon(
                                                Icons.visibility,
                                                color: primarylightPurple,
                                              )
                                            : const Icon(
                                                Icons.visibility_off,
                                                color: primarylightPurple,
                                              )),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),
                              // Signup Button
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    backgroundColor: primaryPurple,
                                  ),
                                  onPressed: _submitRegistration,
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Sign Up
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Do you have an account?'),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.login);
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(color: primaryPurple),
                                ))
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // Generate a random registration token
  String generateRegistrationToken() {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
        20, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

  // Form validation logic
  bool _isValid() {
    if (patientNameController.text.isEmpty) {
      _showError('Patient name is required');
      return false;
    }
    if (emiratesIdController.text.length != 15) {
      _showError('Emirates ID must be 15 characters long');
      return false;
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(mobileNumberController.text)) {
      _showError('Enter a valid 10-digit mobile number');
      return false;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text)) {
      _showError('Enter a valid email address');
      return false;
    }
    if (usernameController.text.isEmpty) {
      _showError('Username is required');
      return false;
    }
    if (passwordController.text.isEmpty) {
      _showError('Password is required');
      return false;
    }
    if (confirmPasswordController.text.isEmpty) {
      _showError('Confirm Password is required');
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      _showError('Passwords do not match');
      return false;
    }
    return true;
  }

  // Show error message in Snackbar
  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Submit Registration
  void _submitRegistration() async {
  if (!_isValid()) return;

  setState(() => isLoading = true);

  final newRegistration = Registration(
    patientName: patientNameController.text.trim(),
    emiratesId: emiratesIdController.text.trim(),
    mobileNumber: mobileNumberController.text.trim(),
    email: emailController.text.trim(),
    username: usernameController.text.trim(),
    password: passwordController.text.trim(),
    isKeyActive: true,
    regToken: generateRegistrationToken(),
  );

  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final credentialProvider = Provider.of<CredentialProvider>(context, listen: false);

  authProvider.clearError();
  authProvider.anApiStarted();

  try {
    final result = await credentialProvider.registerPatient(newRegistration);

    if (!mounted) return;
    authProvider.anApiStopped();

    switch (result['status']) {
      case 'success':
        DialogHelper.showCustomAlertDialog(
          context,
          'Registration Successful',
          "assets/success.gif",
          onConfirm: () {
            //_clearFields();
            if (!mounted) return;
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          },
        );
        break;

      case 'already_exists':
        DialogHelper.showCustomAlertDialog(context, 'Patient already registered', "assets/error.gif");
        break;

      case 'permission_error':
        DialogHelper.showCustomAlertDialog(context, 'You don’t have permission', "assets/error.gif");
        break;

      case 'emirates_id_error':
        DialogHelper.showCustomAlertDialog(
          context,
          'Your Emirates ID is not registered. Contact your clinic',
          "assets/error.gif",
        );
        break;

      default:
        DialogHelper.showCustomAlertDialog(
          context,
          'Registration failed: ${result['message']}',
          "assets/error.gif",
        );
    }
  } catch (error) {
    if (!mounted) return;
    authProvider.anApiStopped();
    DialogHelper.showCustomAlertDialog(
      context,
      'Registration Error: ${error.toString()}',
      "assets/error.gif",
    );
  } finally {
    if (mounted) setState(() => isLoading = false);
  }
}


  // @override
  // void dispose() {
  //   // Dispose controllers to prevent memory leaks
  //   patientNameController.dispose();
  //   emiratesIdController.dispose();
  //   mobileNumberController.dispose();
  //   emailController.dispose();
  //   usernameController.dispose();
  //   passwordController.dispose();
  //   confirmPasswordController.dispose();
  //   super.dispose();
  // }
}

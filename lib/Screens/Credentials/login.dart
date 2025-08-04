import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topline/Constants/animation.dart';
import 'package:topline/Constants/colors.dart';
import 'package:topline/Constants/helperFunctions.dart';
import 'package:topline/Constants/routes.dart';
import 'package:topline/Screens/Credentials/signup.dart';
import 'package:topline/providers/authentication_provider.dart';
import 'package:topline/providers/credential_provider.dart';
import 'package:topline/providers/forgotPasswordProvider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool _rememberMe = false;
bool _obsecureText = true;
Timer? _timer;
final List<String> items = ['Option 1', 'Option 2', 'Option 3'];
String? selectedValue;

final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  void _toggleObscureText() {
    setState(() {
      _obsecureText = !_obsecureText;
    });

    if (!_obsecureText) {
      _timer?.cancel();
      _timer = Timer(const Duration(seconds: 1), () {
        setState(() {
          _obsecureText = true;
        });
      });
    }
  }

  Future<void> _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('email');
    String? password = prefs.getString('password');

    setState(() {
      _usernameController.text = username ?? '';
      _passwordController.text = password ?? '';
      _rememberMe = (username != null && password != null);
    });
  }

  Future<void> _saveCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', username);
    await prefs.setString('password', password);
  }

  Future<void> _clearCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
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
              width: 350.h,
              height: 350.h,
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
            child: SingleChildScrollView(
              child: isLoading
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
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/logo.png',
                                    scale: 3.h,
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    'Tablet EMR',
                                    style: TextStyle(
                                      color: primaryPurple,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )),
                          // DropdownButton<String>(
                          //   hint: Text("Select an option"),
                          //   value: selectedValue, // Set the selected value
                          //   items: items.map((String item) {
                          //     return DropdownMenuItem<String>(
                          //       value: item,
                          //       child: Text(item),
                          //     );
                          //   }).toList(),
                          //   onChanged: (newValue) {
                          //     setState(() {
                          //       selectedValue =
                          //           newValue; // Update selected value
                          //     });
                          //   },
                          // ),
                          const SizedBox(height: 40),
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
                                    controller: _usernameController,
                                    decoration: InputDecoration(
                                      labelText: 'Username',
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
                                const SizedBox(height: 20),
                                // Password TextField
                                FadeAnimation(
                                  1.2,
                                  TextField(
                                    controller: _passwordController,
                                    obscureText: _obsecureText,
                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon: const Icon(Icons.lock),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                                  ))),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Forgot Password
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FadeAnimation(
                                            1.7,
                                            Row(
                                              children: [
                                                Checkbox(
                                                  activeColor:
                                                      primarylightPurple,
                                                  value: _rememberMe,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _rememberMe = value!;
                                                    });
                                                    if (_rememberMe) {
                                                      _saveCredentials(
                                                          _usernameController
                                                              .text,
                                                          _passwordController
                                                              .text);
                                                    } else {
                                                      _clearCredentials();
                                                    }
                                                  },
                                                ),
                                                const Text(
                                                  'Remember Me',
                                                  style: TextStyle(
                                                    color: red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        const Text(
                                          '',
                                          style: TextStyle(color: red),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _showInitialDialog(context);
                                      },
                                      child: RichText(
                                        text: const TextSpan(
                                          style: TextStyle(color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Forget Password?',
                                              style: TextStyle(
                                                color: primarylightPurple,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Login Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      backgroundColor: primaryPurple,
                                    ),
                                    onPressed: _submitLogin,
                                    child: Text(
                                      'Login',
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
                          const SizedBox(height: 30),
                          // Sign Up
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.signup);
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'SIGN UP',
                                    style: TextStyle(
                                      color: primarylightPurple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isValid() {
    if (_usernameController.text.isEmpty) {
      _showError('Username is required');
      return false;
    }
    if (_passwordController.text.isEmpty) {
      _showError('Password is required');
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _submitLogin() async {
    if (_isValid()) {
      setState(() {
        isLoading = true;
      });

      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final credentialProvider =
          Provider.of<CredentialProvider>(context, listen: false);

      authProvider.clearError();
      authProvider.anApiStarted();

      try {
        await credentialProvider.loginUser(context, username, password);
        authProvider.anApiStopped();
        //_showError('Login Success');
        print(authProvider.username);
        Navigator.pushReplacementNamed(context, AppRoutes.navi);
      } catch (error) {
        authProvider.anApiStopped();
        // _showError('Sorry: $error');
        DialogHelper.showCustomAlertDialog(
            context, 'Invalid Username Or Password', "assets/error.gif");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      DialogHelper.showCustomAlertDialog(context,
          'Please fill out all required fields', "assets/text-box-error.gif");
      // _showError('Please fill out all required fields');
    }
  }

  // Initial Alert Dialog
  void _showInitialDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Forgot Password',
            style:
                GoogleFonts.montserrat(textStyle: const TextStyle(color: red)),
          ),
          content: Text(
            "You can't create a new password. You can view your password by entering your email ID.",
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(color: secondaryPurple)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the initial dialog
                _showEmailInputDialog(context); // Show the email input dialog
              },
              child: const Text('Next'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Email Input Alert Dialog
  void _showEmailInputDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    // Reset provider state
    Provider.of<ForgotPasswordProvider>(context, listen: false).resetState();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Email'),
          content: Consumer<ForgotPasswordProvider>(
            builder: (context, provider, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Enter your email',
                    ),
                  ),
                  if (provider.errorMessage != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      provider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  if (provider.password != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      "Your password: ${provider.password}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ],
              );
            },
          ),
          actions: [
            Consumer<ForgotPasswordProvider>(
              builder: (context, provider, child) {
                return provider.isLoading
                    ? SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'assets/Loading.gif',
                          scale: 1.sp,
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          final email = emailController.text.trim();
                          if (email.isNotEmpty) {
                            provider.sendPasswordReset(email);
                          } else {
                            Provider.of<ForgotPasswordProvider>(context,
                                listen: false);
                            // .._errorMessage = "Please enter a valid email!";

                            Future.delayed(Duration.zero, () {
                              Provider.of<ForgotPasswordProvider>(context,
                                      listen: false)
                                  .notifyListeners();
                            });
                          }
                        },
                        child: const Text('Send'),
                      );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // @override
  // void dispose() {
  //   _usernameController.dispose();
  //   _passwordController.dispose();

  //   super.dispose();
  // }
}

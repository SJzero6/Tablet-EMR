import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topline/Constants/colors.dart';
import 'package:topline/Constants/helperFunctions.dart';
import 'package:topline/providers/forgotPasswordProvider.dart';
import 'package:topline/providers/resetPasswordProvider.dart';

class ForgotPasswordDialog {
  /// Show dialog to enter registered email + old password
  static void showEmailDialog(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: const Text("Reset Password"),
        backgroundColor: white,
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            // ✅ makes it responsive
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Enter your registered email",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                    if (!emailRegex.hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Enter your Old Password",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your old password";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          Consumer<ForgotPasswordProvider>(
            builder: (ctx, provider, child) => ElevatedButton(
              onPressed: provider.isLoading
                  ? null
                  : () async {
                      if (!formKey.currentState!.validate()) return;

                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      final exists = await provider.checkEmailExists(email);

                      if (exists) {
                        Navigator.pop(context);
                        showNewPasswordDialog(context, email, password);
                      } else {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //       content: Text("This email is not registered")),
                        // );
                        DialogHelper.showCustomAlertDialog(
                            context,
                            'This email is not registered',
                            "assets/no-data.gif");
                        
                      }
                    },
              child: provider.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                  : const Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }

  /// Show dialog to enter new password
  static void showNewPasswordDialog(
      BuildContext context, String email, String oldPassword) {
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("Enter New Password"),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            // ✅ makes it responsive
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "New Password",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter new password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please confirm your password";
                    } else if (value != newPasswordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          Consumer<ResetPasswordProvider>(
            builder: (ctx, provider, child) => ElevatedButton(
              onPressed: provider.isLoading
                  ? null
                  : () async {
                      if (!formKey.currentState!.validate()) return;

                      final newPassword = newPasswordController.text.trim();

                      final result = await provider.resetPassword(
                        email: email,
                        oldPassword: oldPassword,
                        newPassword: newPassword,
                      );

                      Navigator.pop(context);

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //       content: Text(
                      //           result['message'] ?? "Something went wrong")),
                      // );
                      DialogHelper.showCustomAlertDialog(
                            context,
                            '${result['message'] ?? "Something went wrong contact clinic"}',
                            "assets/finder.gif");

                    },
              child: provider.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                  : const Text("Reset"),
            ),
          ),
        ],
      ),
    );
  }
}

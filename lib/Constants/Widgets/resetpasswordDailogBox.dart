import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topline/providers/forgotPasswordProvider.dart';
import 'package:topline/providers/resetPasswordProvider.dart';

class ForgotPasswordDialog {
  /// Show dialog to enter registered email
  static void showEmailDialog(BuildContext context) {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Reset Password"),
        content: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: "Enter your registered email",
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
                      final email = emailController.text.trim();

                      if (email.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter your email")),
                        );
                        return;
                      }

                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                      if (!emailRegex.hasMatch(email)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter a valid email")),
                        );
                        return;
                      }

                      final exists = await provider.checkEmailExists(email);

                      if (exists) {
                        
                        Navigator.pop(context);
                        showNewPasswordDialog(context, email);
                      } else {
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("This email is not registered")),
                        );
                        
                      }
                    },
              child: provider.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }

  /// Show dialog to enter new password
  static void showNewPasswordDialog(BuildContext context, String email) {
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Enter New Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "New Password"),
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Confirm Password"),
            ),
          ],
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
                      final newPassword = newPasswordController.text.trim();
                      final confirmPassword = confirmPasswordController.text.trim();

                      if (newPassword != confirmPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Passwords do not match")),
                        );
                        return;
                      }

                      final result = await provider.resetPassword(
                        email: email,
                        newPassword: newPassword,
                      );

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result['message'] ?? "Something went wrong")),
                      );
                    },
              child: provider.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Text("Reset"),
            ),
          ),
        ],
      ),
    );
  }
}

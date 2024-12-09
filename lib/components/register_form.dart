import 'package:fanchip_mobile/components/button.dart';
import 'package:fanchip_mobile/services/auth_service.dart';
import 'package:fanchip_mobile/utils/config.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool obsecurePass = true;
  bool obsecureConfirmPass = true;

  AuthService authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  String? _emailError;
  String? _generalError;

  // Email validation regex
  final _emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zAAT0-9.-]+\.[a-zA-Z]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Name Field
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                labelText: 'Name',
                labelStyle: const TextStyle(fontSize: 16),
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Address Field
            TextFormField(
              controller: _addressController,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                hintText: 'Enter your address',
                labelText: 'Address',
                labelStyle: const TextStyle(fontSize: 16),
                prefixIcon: const Icon(Icons.location_on_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Phone Number Field
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
                labelText: 'Phone Number',
                labelStyle: const TextStyle(fontSize: 16),
                prefixIcon: const Icon(Icons.phone_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Phone number must be numeric';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Email Field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter your email address',
                labelText: 'Email',
                labelStyle: const TextStyle(fontSize: 16),
                prefixIcon: const Icon(Icons.email_outlined),
                errorText: _emailError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!_emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Password Field
            TextFormField(
              controller: _passController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: obsecurePass,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                labelText: 'Password',
                labelStyle: const TextStyle(fontSize: 16),
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obsecurePass = !obsecurePass;
                    });
                  },
                  icon: obsecurePass
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.visibility_outlined),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Confirm Password Field
            TextFormField(
              controller: _confirmPassController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: obsecureConfirmPass,
              decoration: InputDecoration(
                hintText: 'Confirm your password',
                labelText: 'Confirm Password',
                labelStyle: const TextStyle(fontSize: 16),
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obsecureConfirmPass = !obsecureConfirmPass;
                    });
                  },
                  icon: obsecureConfirmPass
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.visibility_outlined),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                } else if (value != _passController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Register Button
            Button(
              width: double.infinity,
              title: 'Register',
              disable: false,
              onPressed: () async {
                setState(() {
                  _emailError = null;
                  _generalError = null;
                });

                if (_formKey.currentState?.validate() ?? false) {
                  final result = await authService.register(
                      _nameController.text,
                      _addressController.text,
                      _phoneController.text,
                      _emailController.text,
                      _passController.text);
                  if (result['success']) {
                    Navigator.pushNamed(context, '/home');
                  } else {
                    setState(() {
                      if (result['message'] is Map &&
                          result['message']['email'] != null) {
                        _emailError = result['message']['email'][0];
                      } else {
                        _generalError = result['message'];
                      }
                    });
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Name Field
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              hintText: 'Name',
              labelText: 'Name',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_outline),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          Config.spaceSmall,

          // Address Field
          TextFormField(
            controller: _addressController,
            keyboardType: TextInputType.streetAddress,
            decoration: const InputDecoration(
              hintText: 'Address',
              labelText: 'Address',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.location_on_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          Config.spaceSmall,

          // Phone Number Field
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: 'Phone Number',
              labelText: 'Phone Number',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.phone_outlined),
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
          Config.spaceSmall,

          // Email Field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.email_outlined),
              errorText: _emailError,
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
          Config.spaceSmall,

          // Password Field
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: obsecurePass,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obsecurePass = !obsecurePass;
                    });
                  },
                  icon: obsecurePass
                      ? const Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.black38,
                        )
                      : const Icon(
                          Icons.visibility_outlined,
                          color: Colors.black38,
                        )),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
          ),
          Config.spaceSmall,

          // Confirm Password Field
          TextFormField(
            controller: _confirmPassController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: obsecureConfirmPass,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              labelText: 'Confirm Password',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obsecureConfirmPass = !obsecureConfirmPass;
                    });
                  },
                  icon: obsecureConfirmPass
                      ? const Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.black38,
                        )
                      : const Icon(
                          Icons.visibility_outlined,
                          color: Colors.black38,
                        )),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter confirm password';
              } else if (value != _passController.text) {
                return 'Password does not match';
              } else {
                return null;
              }
            },
          ),
          Config.spaceSmall,

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
                      _emailError = result['message']['email']
                          [0]; // Menampilkan error email spesifik
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
    );
  }
}

// lib/features/auth/presentation/widgets/login_form.dart
import 'package:flutter/material.dart';
import '../../../../core/utils/validation_utils.dart';

class LoginForm extends StatefulWidget {
  final Function(String username, String password) onSubmit;
  final bool isLoading;
  final String? error;

  const LoginForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
    this.error,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
        _usernameController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'ชื่อผู้ใช้',
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) => AppValidationUtils.validateRequired(
              value,
              'ชื่อผู้ใช้',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'รหัสผ่าน',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            obscureText: _obscurePassword,
            validator: (value) => AppValidationUtils.validateRequired(
              value,
              'รหัสผ่าน',
            ),
          ),
          if (widget.error != null) ...[
            const SizedBox(height: 16),
            Text(
              widget.error!,
              style: const TextStyle(color: Colors.red),
            ),
          ],
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.isLoading ? null : _handleSubmit,
              child: widget.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('เข้าสู่ระบบ'),
            ),
          ),
        ],
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import '../login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}*/

class SignUpScreen extends StatefulWidget {
  final VoidCallback login;
  final SharedPreferences prefs;
  const SignUpScreen({Key? key, required this.login, required this.prefs}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureText = true;
  bool _obscureConfirmText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                obscureText: _obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirmText
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmText = !_obscureConfirmText;
                      });
                    },
                  ),
                ),
                obscureText: _obscureConfirmText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Lưu email và password vào SharedPreferences
                    await widget.prefs.setString('email', _emailController.text); // Sửa: Sử dụng widget.prefs để truy cập prefs
                    await widget.prefs.setString('password', _passwordController.text); // Sửa: Sử dụng widget.prefs để truy cập prefs
                    // Cập nhật lại isLoggedIn để hiện màn hình Home
                    widget.login(); // Sửa: Gọi login để cập nhật isLoggedIn
                    // Chuyển sang trang Login
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen(login: widget.login, prefs: widget.prefs,)),// Sửa: Truyền widget.prefs vào LoginScreen
                      );
                    }
                  }
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import '../login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback login;
  final SharedPreferences prefs;
  const SignUpScreen({Key? key, required this.login, required this.prefs}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureText = true;
  bool _obscureConfirmText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Màu nền nhẹ nhàng
      body: Center(
        child: SingleChildScrollView( // Cho phép cuộn khi màn hình nhỏ
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card( // Sử dụng Card để tạo bóng đổ
              elevation: 4.0, // Độ bóng đổ
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), // Bo tròn góc
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Giữ kích thước cột vừa đủ
                    children: [
                      // Logo hoặc tiêu đề
                      const Icon(
                        Icons.person_add_alt_1,
                        size: 60,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 24.0),
                      Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      // Ô nhập Email
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0), // Bo tròn ô nhập
                          ),
                          prefixIcon: const Icon(Icons.email), // Thêm icon email
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      // Ô nhập Password
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0), // Bo tròn ô nhập
                          ),
                          prefixIcon: const Icon(Icons.lock), // Thêm icon khóa
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      // Ô nhập Confirm Password
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0), // Bo tròn ô nhập
                          ),
                          prefixIcon: const Icon(Icons.lock), // Thêm icon khóa
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirmText
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmText = !_obscureConfirmText;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscureConfirmText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24.0),
                      // Nút Sign Up
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Lưu email và password vào SharedPreferences
                            await widget.prefs.setString('email', _emailController.text);
                            await widget.prefs.setString('password', _passwordController.text);
                            // Cập nhật lại isLoggedIn để hiện màn hình Home
                            widget.login();
                            // Chuyển sang trang Login
                            if (context.mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen(login: widget.login, prefs: widget.prefs,)),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: const Text('Sign Up',style: TextStyle(fontSize: 18)),
                      ),
                      const SizedBox(height: 16.0),
                      // Nút chuyển sang Login
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text('Already have an account? Login', style: TextStyle(fontSize: 16),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
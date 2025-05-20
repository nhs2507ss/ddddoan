/*import 'package:flutter/material.dart';
import '../home/home.dart';
import '../signup/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  final VoidCallback login;
  final SharedPreferences prefs; // Thêm: Thêm tham số prefs
  const LoginScreen({Key? key, required this.login, required this.prefs}) : super(key: key); // Sửa: Yêu cầu truyền prefs vào constructor

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process login
                    // Here you should send the data to your backend
                    widget.login();
                    Navigator.pop(context); // Close login screen

                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text('Don\'t have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import '../home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback login;
  final SharedPreferences prefs;
  const LoginScreen({Key? key, required this.login, required this.prefs}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

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
                        Icons.lock,
                        size: 60,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 24.0),
                      Text(
                        'Learnify',
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
                      const SizedBox(height: 24.0),
                      // Nút Login
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Lấy email và password từ controller
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            // Lấy thông tin email và password từ SharedPreferences
                            String? savedEmail = widget.prefs.getString('email');
                            String? savedPassword = widget.prefs.getString('password');

                            // Kiểm tra xem email có tồn tại trong SharedPreferences không
                            if (savedEmail != null) {
                              // Nếu có, kiểm tra xem mật khẩu có đúng không
                              if (savedEmail == email && savedPassword == password) {
                                // Đăng nhập thành công
                                widget.login(); // Gọi hàm login ở main.dart
                                // Chuyển sang trang Home
                                if (context.mounted) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MusicHomePage()),
                                  );
                                }
                              } else {
                                // Mật khẩu sai
                                _showErrorSnackBar('Incorrect password or email');
                              }
                            } else {
                              // Email không tồn tại
                              _showErrorSnackBar('Email not found');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: const Text('Login',style: TextStyle(fontSize: 18)),
                      ),
                      const SizedBox(height: 16.0),
                      // Nút chuyển sang Sign Up
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text('Don\'t have an account? Sign up', style: TextStyle(fontSize: 16),),
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

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
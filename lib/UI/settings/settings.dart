import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Settings Tab'),
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/login_screen.dart'; // Import LoginScreen
import '../../main.dart'; // Import main

class SettingsTab extends StatefulWidget {
  final VoidCallback login;
  final SharedPreferences prefs;
  const SettingsTab({Key? key, required this.login, required this.prefs})
      : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Các cài đặt khác có thể được thêm vào đây
            // ...
            // Nút đăng xuất
            ElevatedButton(
              onPressed: () async {
                // Xóa trạng thái đăng nhập
                await widget.prefs.setBool('isLoggedIn', false);
                // Xóa thông tin đăng nhập (ví dụ: email, password) nếu cần
                await widget.prefs.remove('email');
                await widget.prefs.remove('password');
                // Cập nhật lại isLoggedIn
                widget.login();
                // Chuyển về màn hình đăng nhập
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        login: widget.login,
                        prefs: widget.prefs,
                      ), // Sửa: Truyền widget.prefs vào LoginScreen
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Màu đỏ cho nút đăng xuất
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}*/


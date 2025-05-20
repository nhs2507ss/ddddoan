/*import 'package:flutter/material.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Account Tab'),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import '../login/login_screen.dart'; // Import LoginScreen

class AccountTab extends StatefulWidget {
  // Thêm prefs và login như đã làm ở SettingsTab
  final VoidCallback login;
  final SharedPreferences prefs;
  const AccountTab({Key? key, required this.login, required this.prefs}) : super(key: key);

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  // Các biến lưu thông tin người dùng (ví dụ)
  String userName = "Tên người dùng"; // Thay bằng tên thật của người dùng
  String userAvatarUrl = "assets/default_avatar.png"; // Thay bằng đường dẫn ảnh đại diện thật

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    // Ví dụ: Lấy tên người dùng từ SharedPreferences nếu bạn đã lưu nó ở đó
    // Giả sử bạn lưu email làm tên đăng nhập và muốn hiển thị nó
    setState(() {
      userName = widget.prefs.getString('email') ?? "Tên người dùng";
      // Bạn cũng có thể load userAvatarUrl nếu nó được lưu
    });
  }

  Future<void> _handleLogout() async {
    // Xóa trạng thái đăng nhập trong SharedPreferences
    await widget.prefs.setBool('isLoggedIn', false);
    // Xóa các thông tin khác nếu cần
    await widget.prefs.remove('email');
    // await widget.prefs.remove('password'); // Cân nhắc về bảo mật khi lưu password

    // Gọi hàm login callback được truyền từ _MusicHomePageState
    // Hàm này có thể chịu trách nhiệm cập nhật UI ở cấp cao hơn hoặc điều hướng
    widget.login();

    // Tùy chọn: Điều hướng người dùng về màn hình đăng nhập
    // Nếu bạn muốn điều hướng ngay từ đây:
    // if (mounted) { // Kiểm tra widget còn trong cây widget không
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => LoginScreen(prefs: widget.prefs, login: widget.login)), // Cung cấp lại prefs và login cho LoginScreen nếu cần
    //     (Route<dynamic> route) => false, // Xóa tất cả các route trước đó
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa các thành phần chính
            children: [
              // Ảnh đại diện
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(userAvatarUrl), // Hoặc NetworkImage nếu ảnh online
              ),
              const SizedBox(height: 10),
              // Tên người dùng
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Mục Thư viện
              _AccountSection(
                title: 'Library',
                icon: Icons.library_music,
                children: [
                  _AccountListItem(
                    title: 'Playlists',
                    icon: Icons.playlist_play,
                    onTap: () {
                      // Điều hướng đến trang Playlists
                      print('Navigate to Playlists');
                    },
                  ),
                  _AccountListItem(
                    title: 'Liked Songs',
                    icon: Icons.favorite,
                    onTap: () {
                      // Điều hướng đến trang Liked Songs
                      print('Navigate to Liked Songs');
                    },
                  ),
                  _AccountListItem(
                    title: 'Albums',
                    icon: Icons.album,
                    onTap: () {
                      // Điều hướng đến trang Albums
                      print('Navigate to Albums');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Mục Cài đặt (nếu cần trang cài đặt chi tiết hơn)
              // Hiện tại chúng ta đã có tab Settings, nên có thể ẩn mục này hoặc link đến tab Settings
              _AccountSection(
                title: 'General',
                icon: Icons.settings,
                children: [
                  _AccountListItem(
                    title: 'Notifications',
                    icon: Icons.notifications,
                    onTap: () {
                      // Điều hướng đến trang Notifications
                      print('Navigate to Notifications');
                    },
                  ),
                  _AccountListItem(
                    title: 'Storage',
                    icon: Icons.storage,
                    onTap: () {
                      // Điều hướng đến trang Storage
                      print('Navigate to Storage');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Nút Đăng xuất
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
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget con cho từng mục trong Account (Library, Settings, etc.)
class _AccountSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _AccountSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Danh sách các mục con
        ...children, // Dùng spread operator để thêm các widget con vào Column
      ],
    );
  }
}

// Widget con cho từng dòng trong các mục (Playlist, Liked Songs, etc.)
class _AccountListItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _AccountListItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }
}

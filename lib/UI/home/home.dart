import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:ddddoan/UI/discovery/discovery.dart";
import 'package:ddddoan/UI/home/viewmodel.dart';
import 'package:ddddoan/UI/settings/settings.dart';
import 'package:ddddoan/UI/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/song.dart';
import '../now_playing/playing.dart';
class Learnify1 extends StatelessWidget {
  const Learnify1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : 'Learnify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MusicHomePage(),
      debugShowCheckedModeBanner: false,

    );
  }
}

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  late SharedPreferences _prefs;
  bool _isLoadingPrefs = true;

  // Khai báo _tabs nhưng chưa khởi tạo
  late final List<Widget> _tabs;

  // Hàm callback cho login
  void _handleLoginAction() {
    print("Login action triggered!");
    // Logic đăng xuất/cập nhật UI ở đây
    // Ví dụ, có thể điều hướng về màn hình đăng nhập
    // hoặc setState để thay đổi một biến trạng thái nào đó
  }

  @override
  void initState() {
    super.initState();
    _initializeAsyncData(); // Gọi hàm để load dữ liệu bất đồng bộ
  }

  Future<void> _initializeAsyncData() async {
    _prefs = await SharedPreferences.getInstance();

    // Bây giờ _prefs và _handleLoginAction đã có sẵn,
    // bạn có thể khởi tạo _tabs
    _tabs = [
      const HomeTab(),
      const DiscoveryTab(),
      AccountTab(login: _handleLoginAction, prefs: _prefs),
      SettingsTab(), // Giả sử SettingsTab cũng cần prefs
      // Nếu không, hãy xóa `prefs: _prefs`
      // Hoặc nếu SettingsTab cần login, hãy thêm `login: _handleLoginAction`
    ];

    // Sau khi tất cả đã được khởi tạo, gọi setState để build lại UI
    if (mounted) { // Kiểm tra xem State object có còn trong cây widget không
      setState(() {
        _isLoadingPrefs = false; // Đánh dấu đã load xong
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    if (_isLoadingPrefs) {
      return const CupertinoPageScaffold(
        child: Center(child: CupertinoActivityIndicator()),
      );
    }
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Learnify'),

      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          items:const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.album), label: 'Discovery'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return _tabs[index];
        },
      ),
    );
  }
}


class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeTabPage();
  }
}

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<Song> songs = [];
  late MusicAppViewModel _viewModel;

  @override
  void initState() {
    _viewModel = MusicAppViewModel();
    _viewModel.loadSongs();
    observeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody()
    );
  }

  @override
  void dispose(){
    _viewModel.songStream.close();
    super.dispose();
  }

  Widget getBody(){
    bool showLoading= songs.isEmpty;
    if(showLoading){
      return getProgressBar();
    }else{
      return getListView();
    }
  }

  Widget getProgressBar(){
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  ListView getListView(){
    return ListView.separated(
      itemBuilder: (context, position){
        return getRow(position);
      },
      separatorBuilder: (context, index){
        return const Divider(
          color: Colors.blueAccent,
          thickness: 1,
          indent: 24,
          endIndent: 24,
        );
      },
      itemCount: songs.length,
      shrinkWrap: true,
    );
  }

  Widget getRow(int index){
    return _SongItemSection(
      parent: this,
      song:songs[index],
    );
  }

  void observeData(){
    _viewModel.songStream.stream.listen((songList) {
      setState(() {
        songs.addAll(songList);
      });
    });
  }
  void showBottomSheet(){
    showModalBottomSheet(context: context, builder: (context){
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),),
        child: Container(
          height: 400,
          color: Colors.blueAccent,
          child: Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Modal Bottom Sheet'),
                ElevatedButton(onPressed: () => Navigator.pop(context) , child: const Text('Close Bottom Sheet'),)

              ],
            ),
          ),
        ),
      );
    });
  }
  void navigate(Song song){
    Navigator.push(context,
        CupertinoPageRoute(builder: (context){
          return Nowplaying(
            songs: songs,
            playingSong: song,
          );
        })
    );
  }
}

class _SongItemSection extends StatelessWidget {
  const _SongItemSection({
    required this.parent,
    required this.song,
  });
  final _HomeTabPageState parent;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 23,right:14),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10) ,
        child: FadeInImage.assetNetwork(placeholder: 'assets/itunes_256.png',
          image: song.image,
          width: 48,
          height: 48,
          imageErrorBuilder: (context, error, stackTrace){
            return Image.asset(
              'assets/itunes_256.png',
              width: 48,
              height: 48,
            );
          },
        ) ,
      ),
      title: Text(
          song.title
      ),
      subtitle: Text(song.artist),
      trailing: IconButton(
          onPressed: (){
            parent.showBottomSheet();
          },
          icon: const Icon(Icons.more_horiz_sharp)
      ) ,
      onTap: (){
        parent.navigate(song);
      },
    );
  }
}/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:doan1/UI/discovery/discovery.dart";
import 'package:doan1/UI/home/viewmodel.dart';
import 'package:doan1/UI/settings/settings.dart';
import 'package:doan1/UI/user/user.dart'; // Import AccountTab
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

import '../../data/model/song.dart';
import '../now_playing/playing.dart';

class Learnify1 extends StatelessWidget {
  const Learnify1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learnify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MusicHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  // Khai báo để giữ giá trị login và prefs
  String _currentUserLogin = "default_user"; // Giá trị login mặc định hoặc lấy từ nguồn khác
  SharedPreferences? _userPrefs; // Đối tượng prefs

  // Danh sách các tab. Ban đầu có thể để AccountTab là null hoặc indicator
  // cho đến khi prefs được tải
  List<Widget> _tabs = [
    const HomeTab(),
    const DiscoveryTab(),
    // Placeholder hoặc indicator ban đầu
    const Center(child: CircularProgressIndicator()),
    const SettingsTab(),
  ];

  @override
  void initState() {
    super.initState();
    _loadPrefsAndBuildTabs(); // Tải prefs và sau đó xây dựng lại danh sách tab
  }

  Future<void> _loadPrefsAndBuildTabs() async {
    // Giả định bạn lấy giá trị login từ đâu đó
    // Ví dụ: từ SharedPreferences, Auth Service, etc.
    _currentUserLogin = await _getLoginValue(); // Hàm này cần bạn tự triển khai

    _userPrefs = await SharedPreferences.getInstance();

    // Cập nhật danh sách tab sau khi có prefs
    setState(() {
      _tabs = [
        const HomeTab(),
        const DiscoveryTab(),
        // Tạo AccountTab với các tham số bắt buộc
        AccountTab(
          login: _currentUserLogin,
          prefs: _userPrefs!, // Sử dụng ! vì chúng ta đã kiểm tra null bằng cách chỉ tạo khi _userPrefs != null
        ),
        const SettingsTab(),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Learnify'),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.album), label: 'Discovery'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          // Trả về widget tương ứng với index
          return _tabs[index];
        },
      ),
    );
  }
}

// Các lớp HomeTab, HomeTabPage, _SongItemSection giữ nguyên

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeTabPage();
  }
}

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<Song> songs = [];
  late MusicAppViewModel _viewModel;

  @override
  void initState() {
    _viewModel = MusicAppViewModel();
    _viewModel.loadSongs();
    observeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody()
    );
  }

  @override
  void dispose(){
    _viewModel.songStream.close();
    super.dispose();
  }

  Widget getBody(){
    bool showLoading = songs.isEmpty;
    if(showLoading){
      return getProgressBar();
    }else{
      return getListView();
    }
  }

  Widget getProgressBar(){
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  ListView getListView(){
    return ListView.separated(
      itemBuilder: (context, position){
        return getRow(position);
      },
      separatorBuilder: (context, index){
        return const Divider(
          color: Colors.blueAccent,
          thickness: 1,
          indent: 24,
          endIndent: 24,
        );
      },
      itemCount: songs.length,
      shrinkWrap: true,
    );
  }

  Widget getRow(int index){
    return _SongItemSection(
      parent: this,
      song: songs[index],
    );
  }

  void observeData(){
    _viewModel.songStream.stream.listen((songList) {
      setState(() {
        songs.addAll(songList);
      });
    });
  }
  void showBottomSheet(){
    showModalBottomSheet(context: context, builder: (context){
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        child: Container(
          height: 400,
          color: Colors.blueAccent,
          child: Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Modal Bottom Sheet'),
                ElevatedButton(onPressed: () => Navigator.pop(context) , child: const Text('Close Bottom Sheet'),)
              ],
            ),
          ),
        ),
      );
    });
  }
  void navigate(Song song){
    Navigator.push(context,
        CupertinoPageRoute(builder: (context){
          return Nowplaying(
            songs: songs,
            playingSong: song,
          );
        })
    );
  }
}

class _SongItemSection extends StatelessWidget {
  const _SongItemSection({
    required this.parent,
    required this.song,
  });
  final _HomeTabPageState parent;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 23,right:14),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10) ,
        child: FadeInImage.assetNetwork(placeholder: 'assets/itunes_256.png',
          image: song.image,
          width: 48,
          height: 48,
          imageErrorBuilder: (context, error, stackTrace){
            return Image.asset(
              'assets/itunes_256.png',
              width: 48,
              height: 48,
            );
          },
        ) ,
      ),
      title: Text(
          song.title
      ),
      subtitle: Text(song.artist),
      trailing: IconButton(
          onPressed: (){
            parent.showBottomSheet();
          },
          icon: const Icon(Icons.more_horiz_sharp)
      ) ,
      onTap: (){
        parent.navigate(song);
      },
    );
  }
}
*/
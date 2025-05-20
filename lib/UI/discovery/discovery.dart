/*import 'package:flutter/material.dart';

class DiscoveryTab extends StatelessWidget {
  const DiscoveryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Discovery Tab'),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';

class DiscoveryTab extends StatelessWidget {
  const DiscoveryTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm kiếm'),
        // Thanh tìm kiếm ở AppBar
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Bạn muốn nghe gì...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.blueGrey[200],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề "Thể loại"
              const Text(
                'Genres',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Danh sách thể loại (ví dụ)
              SizedBox(
                height: 50, // Điều chỉnh chiều cao tùy ý
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _GenreButton(genre: 'Pop'),
                    _GenreButton(genre: 'Rock'),
                    _GenreButton(genre: 'EDM'),
                    _GenreButton(genre: 'Jazz'),
                    _GenreButton(genre: 'Country'),
                    _GenreButton(genre: 'Hip Hop'),
                    _GenreButton(genre: 'Kpop'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Tiêu đề "Bài hát nổi bật"
              const Text(
                'Trending Songs',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Danh sách bài hát nổi bật (ví dụ)
              Column(
                children: const [
                  _SongTile(songName: 'Đế Vương', artistName: 'Đình Dũng'),
                  _SongTile(songName: 'Where Have You Gone', artistName: 'Ricky J'),
                  _SongTile(songName: 'Lắng Nghe Nước Mắt', artistName: 'Mr.Siro'),
                  _SongTile(songName: 'Beautiful In White', artistName: 'Shayne Ward'),
                ],
              ),
              const SizedBox(height: 20),
              // Tiêu đề "Playlists"
              const Text(
                'Playlists',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: const [
                  _PlaylistTile(playlistName: 'Playlist 1', numberOfSong: 10, image: 'itunes_256.png'),
                  _PlaylistTile(playlistName: 'Playlist 2', numberOfSong: 15, image: 'assets/playlist2.jpg'),
                  _PlaylistTile(playlistName: 'Playlist 3', numberOfSong: 20, image: 'assets/playlist3.jpg'),
                  _PlaylistTile(playlistName: 'Playlist 4', numberOfSong: 5, image: 'assets/playlist4.jpg'),
                ],
              ),
              const SizedBox(height: 20),
              // Tiêu đề "Nghệ sĩ nổi bật"
              const Text(
                'Trending Artists',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Danh sách nghệ sĩ nổi bật (ví dụ)
              SizedBox(
                height: 100, // Điều chỉnh chiều cao tùy ý
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _ArtistCircle(artistName: 'Đế Vương', image: 'https://thantrieu.com/resources/arts/1073969323.webp'),
                    _ArtistCircle(artistName: 'Where Have You Gone', image: 'assets/artist2.jpg'),
                    _ArtistCircle(artistName: 'Lắng Nghe ', image: 'assets/artist3.jpg'),
                    _ArtistCircle(artistName: 'Artist D', image: 'assets/artist4.jpg'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget con cho nút thể loại
class _GenreButton extends StatelessWidget {
  final String genre;

  const _GenreButton({required this.genre});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ElevatedButton(
        onPressed: () {
          // Xử lý khi nhấn vào thể loại
          print('Selected genre: $genre');
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(genre),
      ),
    );
  }
}

// Widget con cho mỗi bài hát trong danh sách bài hát nổi bật
class _SongTile extends StatelessWidget {
  final String songName;
  final String artistName;

  const _SongTile({required this.songName, required this.artistName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.music_note),
      title: Text(songName),
      subtitle: Text(artistName),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          // Xử lý khi nhấn vào nút more
        },
      ),
    );
  }
}

class _PlaylistTile extends StatelessWidget {
  final String playlistName;
  final int numberOfSong;
  final String image;

  const _PlaylistTile({required this.playlistName, required this.numberOfSong, required this.image});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          image,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(playlistName),
      subtitle: Text('$numberOfSong songs'),
      trailing: const Icon(Icons.play_circle_outline),
      onTap: () {
        // Xử lý khi nhấn vào nút play
      },
    );
  }
}

// Widget con cho vòng tròn nghệ sĩ
class _ArtistCircle extends StatelessWidget {
  final String artistName;
  final String image;

  const _ArtistCircle({required this.artistName, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(image),
          ),
          const SizedBox(height: 5),
          Text(artistName),
        ],
      ),
    );
  }
}

/*class Song {
  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.source,
    required this.image,
    required this.duration,
  });

  factory Song.fromJson(Map<String, dynamic> map) {
    return Song(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
      album: map['album'],
      source: map['source'],
      image: map['image'],
      duration: map['duration'],
    );
  }

  String id;
  String title;
  String artist;
  String album;
  String source;
  String image;
  int duration;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Song && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Song{id: $id, title: $title, artist: $artist, album: $album, source: $source, image: $image, duration: $duration}';
  }
}*/
class Song {
  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.source,
    required this.image,
    required this.duration,
    required this.favorite,
    required this.counter,
    required this.replay,
  });

  factory Song.fromJson(Map<String, dynamic> map) {
    return Song(
      id: map['id'] as String,
      title: map['title'] as String,
      artist: map['artist'] as String,
      album: map['album'] as String,
      source: map['source'] as String,
      image: map['image'] as String,
      duration: map['duration'] as int,
      favorite: map['favorite'] == "true",//Chuyển đổi chuỗi "true" hoặc "false" thành boolean
      counter: map['counter'] as int,
      replay: map['replay'] as int,
    );
  }

  String id;
  String title;
  String artist;
  String album;
  String source;
  String image;
  int duration;
  bool favorite;
  int counter;
  int replay;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Song && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Song{id: $id, title: $title, artist: $artist, album: $album, source: $source, image: $image, duration: $duration, favorite: $favorite, counter: $counter, replay: $replay}';
  }
}

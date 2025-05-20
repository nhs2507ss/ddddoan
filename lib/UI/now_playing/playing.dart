

import 'dart:math';
//import 'package:doan1/UI/chat_screen/chat_screen.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../data/model/song.dart';
import 'audio_player_manager.dart';

class Nowplaying extends StatelessWidget {
  const Nowplaying({super.key, required this.songs, required this.playingSong});

  final Song playingSong;
  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return NowplayingPage(songs: songs, playingSong: playingSong);
  }
}

class NowplayingPage extends StatefulWidget {
  const NowplayingPage({
    super.key,
    required this.songs,
    required this.playingSong,
  });
  final Song playingSong;
  final List<Song> songs;

  @override
  State<NowplayingPage> createState() => _NowplayingPageState();
}

class _NowplayingPageState extends State<NowplayingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _imageAnimController;
  late AudioPlayerManager _audioPlayerManager;
  late int _selectedItemIndex;
  late Song _song;
  late double _currentAnimationPosition = 0.0;
  bool _isShuffle = false;
  late LoopMode _loopMode;


  @override
  void initState() {
    super.initState();
    _currentAnimationPosition = 0.0;
    _song = widget.playingSong;
    _imageAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 12000),
    );
    //_imageAnimController.repeat();
    _audioPlayerManager = AudioPlayerManager(
      songUrl: _song.source,
    );
    _audioPlayerManager.init();
    _selectedItemIndex = widget.songs.indexOf(widget.playingSong);
    _loopMode = LoopMode.off;
  }

  void _hienThiLuaChonHocTap() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text('Từ vựng'), // Vocabulary
                onTap: () {
                  // Chuyển đến màn hình từ vựng
                  Navigator.pop(context); // Đóng bottom sheet
                  // TODO: Thêm logic chuyển trang của bạn vào đây, ví dụ:
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => VocabularyScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat),
                title: const Text('Trò chuyện với AI'), // Chat with AI
                onTap: () {
                  // Chuyển đến màn hình trò chuyện với AI
                  Navigator.pop(context); // Đóng bottom sheet
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()), // Loại bỏ const// Chuyển hướng đến ChatScreen
                  );*/
                  // TODO: Thêm logic chuyển trang của bạn vào đây
                },
              ),
              ListTile(
                leading: const Icon(Icons.assignment),
                title: const Text('Bài tập luyện tập'), // Practice Exercises
                onTap: () {
                  // Chuyển đến màn hình bài tập luyện tập
                  Navigator.pop(context); // Đóng bottom sheet
                  // TODO: Thêm logic chuyển trang của bạn vào đây
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    const delta = 200;
    final Radius = (screenWidth - delta) / 2;
    /*return Scaffold(
      body: Center(
        child: Text('Phát nhạc'),
      ),
    );*/
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Phát nhạc'),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_horiz_sharp),
        ),
      ),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_song.album),
              const SizedBox(height: 16),
              Text(''),
              const SizedBox(height: 24),
              RotationTransition(
                turns: Tween(
                  begin: 0.0,
                  end: 1.0,
                ).animate(_imageAnimController),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Radius),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/itunes_256.png',
                    image: _song.image,
                    width: screenWidth - delta,
                    height: screenWidth - delta,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/itunes_256.png',
                        width: screenWidth - delta,
                        height: screenWidth - delta,
                      );
                    },
                  ),
                ),
              ),
              // nút học tập
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: IconButton(
                  onPressed: _hienThiLuaChonHocTap,
                  icon: const Icon(Icons.menu_book_rounded),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 64, bottom: 16),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share_outlined),
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),
                      Column(
                        children: [
                          Text(
                            _song.title,
                            style: Theme
                                .of(
                              context,
                            )
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              color:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _song.artist,
                            style: Theme
                                .of(
                              context,
                            )
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              color:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 32,
                  left: 24,
                  right: 24,
                  bottom: 16,
                ),
                child: _progressBar(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 32,
                  left: 24,
                  right: 24,
                  bottom: 16,
                ),
                child: _mediaButtons(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayerManager.dispose();
    _imageAnimController.dispose();
    super.dispose();
  }

  Widget _mediaButtons() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MediaButtonControl(
            function: _setShuffle,
            icon: Icons.shuffle,
            color: _getShuffleColor(),
            size: 24,
          ),
          MediaButtonControl(
            function: _setPrevSong,
            icon: Icons.skip_previous,
            color: Colors.blueAccent,
            size: 36,
          ),
          /*MediaButtonControl(
            function: null,
            icon: Icons.play_arrow_outlined,
            color: Colors.blueAccent,
            size: 48,
          ),*/
          _playButton(),
          MediaButtonControl(
            function: _setNextSong,
            icon: Icons.skip_next,
            color: Colors.blueAccent,
            size: 36,
          ),
          MediaButtonControl(
            function: _setupRepeatOption,
            icon: _repeatingIcon(),
            color: getRepeatingIconColor(),
            size: 24,
          ),
        ],
      ),
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
      stream: _audioPlayerManager.durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(
          progress: progress,
          total: total,
          buffered: buffered,
          onSeek: _audioPlayerManager.player.seek,
          barHeight: 5.0,
          barCapShape: BarCapShape.round,
          baseBarColor: Colors.blue.withOpacity(0.3),
          progressBarColor: Colors.blue,
          bufferedBarColor: Colors.blueAccent.withOpacity(0.3),
          thumbColor: Colors.blueAccent,
          thumbGlowColor: Colors.blueAccent.withOpacity(0.3),
          thumbRadius: 10.0,
        );
      },
    );
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder(
      stream: _audioPlayerManager.player.playerStateStream,
      builder: (context, snapshot) {
        final playState = snapshot.data;
        final processingState = playState?.processingState;
        final playing = playState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          _pauseRotationAnim();
          return Container(
            margin: EdgeInsets.all(8.0),
            width: 48.0,
            height: 48.0,
            child: CircularProgressIndicator(),
          );
        } else if (playing != true) {
          return MediaButtonControl(
            function: () {
              _audioPlayerManager.player.play();
            },
            icon: Icons.play_arrow,
            color: Colors.blueAccent,
            size: 48,
          );
        } else if (processingState != ProcessingState.completed) {
          _playRotationAnim();
          return MediaButtonControl(
            function: () {
              _audioPlayerManager.player.pause();
              _pauseRotationAnim();
            },
            icon: Icons.pause,
            color: Colors.blueAccent,
            size: 48,
          );
        } else {
          if(processingState == ProcessingState.completed){
            _stopRotationAnim();
            _resetRotationAnim();
          }
          return MediaButtonControl(
            function: () {
              _audioPlayerManager.player.seek(Duration.zero);
              _resetRotationAnim();
              _playRotationAnim();
            },
            icon: Icons.replay,
            color: Colors.blueGrey,
            size: 48,
          );
        }
      },
    );
  }
  void _setShuffle(){
    setState(() {
      _isShuffle = !_isShuffle;
    });
  }
  Color? _getShuffleColor(){
    return _isShuffle ? Colors.blueAccent : Colors.blueGrey;
  }
  void _setNextSong() {
    if(_isShuffle){
      var random = Random();
      _selectedItemIndex = random.nextInt(widget.songs.length - 1);
    }else{
      ++_selectedItemIndex;
    }
    if(_selectedItemIndex >= widget.songs.length){
      _selectedItemIndex = _selectedItemIndex % widget.songs.length;
    }
    final nextSong = widget.songs[_selectedItemIndex];
    _audioPlayerManager.updateSongUrl(nextSong.source);
    _resetRotationAnim();
    setState(() {
      _song = nextSong;
    });
  }


  void _setPrevSong() {
    if(_isShuffle){
      var random = Random();
      _selectedItemIndex = random.nextInt(widget.songs.length - 1);
    }else{
      --_selectedItemIndex;
    }
    if(_selectedItemIndex < 0){
      _selectedItemIndex = (-1 * _selectedItemIndex) % widget.songs.length;
    }
    final nextSong = widget.songs[_selectedItemIndex];
    _audioPlayerManager.updateSongUrl(nextSong.source);
    _resetRotationAnim();
    setState(() {
      _song = nextSong;
    });
  }

  void _setupRepeatOption(){
    if(_loopMode == LoopMode.off){
      _loopMode = LoopMode.one;
    }else if(_loopMode == LoopMode.one){
      _loopMode = LoopMode.all;
    }else{
      _loopMode = LoopMode.off;
    }
    setState(() {
      _audioPlayerManager.player.setLoopMode(_loopMode);
    });
  }

  IconData _repeatingIcon(){
    return switch(_loopMode){
      LoopMode.one => Icons.repeat_one,
      LoopMode.all => Icons.repeat_on,
      _ => Icons.repeat,
    };
  }

  Color? getRepeatingIconColor() {
    return _loopMode == LoopMode.off
        ? Colors.blueAccent : Colors.blueGrey;
  }

  void _playRotationAnim(){
    _imageAnimController.forward(from: _currentAnimationPosition);
    _imageAnimController.repeat();
  }
  void _pauseRotationAnim(){
    _stopRotationAnim();
    _currentAnimationPosition = _imageAnimController.value;
  }
  void _stopRotationAnim(){
    _imageAnimController.stop();
  }
  void _resetRotationAnim(){
    _currentAnimationPosition = 0.0;
    _imageAnimController.value = _currentAnimationPosition;
  }
}







class MediaButtonControl extends StatefulWidget {
  const MediaButtonControl({
    super.key,
    required this.function,
    required this.icon,
    required this.color,
    required this.size,
  });

  final void Function()? function;
  final IconData icon;
  final double? size;
  final Color? color;

  @override
  State<StatefulWidget> createState() => _MediaButtonControlState();
}

class _MediaButtonControlState extends State<MediaButtonControl> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.function,
      icon: Icon(widget.icon),
      iconSize: widget.size,
      color: widget.color ?? Theme
          .of(context)
          .colorScheme
          .primary,
    );
  }
}

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:media_player_app/util.dart';
import 'package:video_player/video_player.dart';

void main() {
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AssetsAudioPlayer _assetsAudioPlayer;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

    _assetsAudioPlayer.open(Audio("assets/audios/country.mp3"), showNotification: true, autoStart: false);
    _assetsAudioPlayer.current.listen((event) {
      print("event $event");
    });

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse("https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true)
    )..initialize().then((value) {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(tabs: [
            Tab(text: "Audio"),
            Tab(text: "Video"),
          ]),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<bool>(
                        stream: _assetsAudioPlayer.isPlaying,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            bool isPlaying = snapshot.data ?? false;
                            return IconButton(
                              onPressed: () {
                                _assetsAudioPlayer.playOrPause();
                              },
                              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                            );
                          } else {
                            return Text("no Data");
                          }
                        }),
                    IconButton(
                      onPressed: () {
                        _assetsAudioPlayer.stop();
                      },
                      icon: Icon(Icons.stop),
                    ),
                  ],
                ),
                StreamBuilder<Duration>(
                    stream: _assetsAudioPlayer.currentPosition,
                    builder: (context, snapshot) {
                      Duration duration = snapshot.data ?? Duration(seconds: 0);
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Slider(
                            value: duration.inSeconds.toDouble(),
                            min: 0,
                            max: (_assetsAudioPlayer.current.value?.audio.duration.inSeconds ?? 0).toDouble(),
                            onChanged: (value) {
                              print(value);
                              _assetsAudioPlayer.seek(Duration(seconds: value.toInt()));
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("0.0"),
                                Text("${duration.inMinutes % 60}:${duration.inSeconds % 60}"),
                                Text("${_assetsAudioPlayer.current.value?.audio.duration.inMinutes ?? 0}")
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    Audio audio = files[index];
                    return ListTile(
                      onTap: () {
                        _assetsAudioPlayer.open(audio, showNotification: true);
                      },
                      title: Text(audio.metas.title ?? ""),
                    );
                  },
                  itemCount: files.length,
                ))
              ],
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    child: (_videoPlayerController.value.isInitialized)
                        ? AspectRatio(
                            aspectRatio: _videoPlayerController.value.aspectRatio,
                            child: VideoPlayer(
                              _videoPlayerController,
                            ),
                          )
                        : CircularProgressIndicator(),
                  ),
                  VideoProgressIndicator(_videoPlayerController, allowScrubbing: true),
                  IconButton(
                    onPressed: () {
                      if (_videoPlayerController.value.isPlaying) {
                        _videoPlayerController.pause();
                      } else {
                        _videoPlayerController.play();
                      }
                      setState(() {});
                    },
                    icon: Icon(_videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void audioPlay() {}

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';

class YoutubeDefaultWidget extends StatefulWidget {
  const YoutubeDefaultWidget({super.key, required this.videoId});
  final String videoId;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<YoutubeDefaultWidget>
    implements YouTubePlayerListener {
  double _currentVideoSecond = 0.0;
  String _playerState = "";

  late FlutterYoutubeViewController _controller;

  @override
  void onCurrentSecond(double second) {
    print("onCurrentSecond second = $second");
    _currentVideoSecond = second;
  }

  @override
  void onError(String error) {
    print("onError error = $error");
  }

  @override
  void onReady() {
    print("onReady");
  }

  @override
  void onStateChange(String state) {
    print("onStateChange state = $state");
    setState(() {
      _playerState = state;
    });
  }

  @override
  void onVideoDuration(double duration) {
    print("onVideoDuration duration = $duration");
  }

  void _onYoutubeCreated(FlutterYoutubeViewController controller) {
    this._controller = controller;
  }

  void _loadOrCueVideo() {
    _controller.loadOrCueVideo(widget.videoId, _currentVideoSecond);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[
            Container(
              height: 300,
                child: FlutterYoutubeView(
              onViewCreated: _onYoutubeCreated,
              listener: this,
              params: YoutubeParam(
                videoId: widget.videoId,
                showUI: true,
                startSeconds: 0.0,
                showYoutube: false,
                showFullScreen: false,
                autoPlay: false
              ),
            )),
            Center(
                child: Column(
              children: <Widget>[
                Text(
                  'Current state: $_playerState',
                  style: TextStyle(color: Colors.blue),
                ),
                MaterialButton(
                  onPressed: _loadOrCueVideo,
                  child: Text('Click reload video'),
                ),
              ],
            ))
          ],
        );
  }
}

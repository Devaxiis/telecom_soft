import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:telecom_soft_ui/common/app_color.dart';
import 'package:telecom_soft_ui/common/app_routes.dart';
import 'package:telecom_soft_ui/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:telecom_soft_ui/features/home/presentation/widgets/custom_navbar_widget.dart';
import 'package:telecom_soft_ui/features/home/presentation/widgets/yt_cart_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../manager/audio_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.title,
    required this.isChat,

  });

  final String title;
  final bool isChat;


  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late YoutubePlayerController _controller;
  FlutterSoundPlayer? _player;
  String? _filePath;
  Map<String, bool> _isPlaying = {};






  @override
  void initState() {
    _player = FlutterSoundPlayer();
    _initPlayer();
    String? videoId = YoutubePlayer.convertUrlToId(
        "https://youtu.be/PLHddf-1MHY?si=iJrS4HoKHEf0Y9Bp");
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? "",
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  Future<void> _initPlayer() async {
    await _player!.openPlayer();
  }

  Future<void> _playAudio(String filePath) async {
    if (_isPlaying[filePath] == true) {
      // Agar o'sha audio ijro etilayotgan bo'lsa, uni to'xtatish
      await _player!.stopPlayer();
      setState(() {
        _isPlaying[filePath] = false;
      });
    } else {
      // Barcha fayllarni ijro holatini o'chirish
      _isPlaying.keys.forEach((key) {
        _isPlaying[key] = false;
      });

      // Yangi audio ijrosini boshlash
      await _player!.startPlayer(
        fromURI: filePath,
        whenFinished: () {
          setState(() {
            _isPlaying[filePath] = false; // Audio tugagach holatni tiklash
          });
        },
      );
      setState(() {
        _isPlaying[filePath] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
        ),
        child: Column(
          spacing: 16,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomAppBar(
                  title: widget.title,
                  onTab: () {
                    context.pop();
                  }),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  // height: 450.h,
                  width: 358.w,
                  decoration: BoxDecoration(
                      color: AppColor.clPrWhiteFFFFFF,
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: YtCartWidget(
                              controller: _controller,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: audioProvider.audioPaths.length,
                            itemBuilder: (context, index) {
                              final audioPath = audioProvider.audioPaths[index];
                              _isPlaying.putIfAbsent(audioPath, () => false);
                              return ListTile(
                                leading: IconButton(
                                  icon: Icon(
                                    _filePath == audioPath
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.green,
                                  ),
                                  onPressed: () => _playAudio(audioPath),
                                ),
                                title: Text('Audio ${index + 1}'),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    audioProvider.removeAudio(audioPath);
                                    if (_filePath == audioPath) {
                                      _player!
                                          .stopPlayer(); // Agar ijro etilayotgan bo'lsa, to'xtatish
                                      setState(() {
                                        _filePath = null;
                                      });
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            CustomNavbarWidget(
              onTab: () {
                // context.push(Routes.record);
                context.push(Routes.audioRecord, extra: widget.title);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _player!.closePlayer();
    super.dispose();
  }

}

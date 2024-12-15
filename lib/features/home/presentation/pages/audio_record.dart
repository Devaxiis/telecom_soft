import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:telecom_soft_ui/common/app_color.dart';
import 'package:telecom_soft_ui/common/app_routes.dart';
import 'package:telecom_soft_ui/common/app_style.dart';
import 'package:telecom_soft_ui/features/home/presentation/widgets/audio_recording_widget.dart';
import 'package:telecom_soft_ui/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:telecom_soft_ui/features/home/presentation/widgets/custom_navbar_second.dart';
import '../../../../common/assets.dart';
import '../manager/audio_provider.dart';

class AudioRecord extends StatefulWidget {
  const AudioRecord({super.key, required this.title});

  final String title;

  @override
  State<AudioRecord> createState() => _AudioRecordState();
}

class _AudioRecordState extends State<AudioRecord> with SingleTickerProviderStateMixin{
  bool isTrueRecording = false;
  bool isNavBar = false;
  int _start = 60;
  Timer? _timer;
  int count =0;
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _filePath;


  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;


  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel(); // Taymerni to'xtatish
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _init();

    // Animatsiya boshqaruvi
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Rang va o'lcham animatsiyasi
    _colorAnimation = ColorTween(
      begin: Colors.red.withOpacity(0.6),
      end: Colors.red.withOpacity(1.0),
    ).animate(_animationController);

    _sizeAnimation = Tween<double>(
      begin: 60.0,
      end: 80.0,
    ).animate(_animationController);

    _loadSingleFile();
    startTimer();
  }

  Future<void> _init() async {
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    await _recorder!.openRecorder();
    await _player!.openPlayer();
    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  Future<void> _startRecording() async {
    _start = 60;
    final directory = await getApplicationDocumentsDirectory();
    _filePath = '${directory.path}/audio_recording.aac';
    await _recorder!.startRecorder(toFile: _filePath!);
    setState(() {
      _isRecording = true;
    });

    _animationController.repeat(reverse: true); // Animatsiyani boshlash
    count = 1;
    if(count != 1){

    }
  }

  Future<void> _stopRecording() async {
    if(count==1){
      isNavBar = true;
    }
    await _recorder!.stopRecorder();

    setState(() {
      _isRecording = false;
    });
    _animationController.stop(); // Animatsiyani to'xtatish
    _start = 0;
  }

  Future<void> _playRecording() async {
    if (_isPlaying) {
      // Agar ijro davom etayotgan bo'lsa, to'xtatish
      await _player!.stopPlayer();
      setState(() {
        _isPlaying = false;
      });
    } else if (_filePath != null) {
      // Yangi faylni ijro qilishni boshlash
      await _player!.startPlayer(
        fromURI: _filePath!,
        whenFinished: () {
          setState(() {
            _isPlaying = false; // Ijro tugagach holatni yangilash
          });
        },
      );

      setState(() {
        _isPlaying = true;

      });
    }
  }

  Future<void> _deleteRecording() async {
    if (_filePath != null && File(_filePath!).existsSync()) {
      File(_filePath!).deleteSync();
      setState(() {
        count = 0;
        isNavBar = false;
        _filePath = null; // Faylni yo'q qilish
        _isPlaying = false; // Ijro holatini tiklash
      });
    }
  }

  Future<void> _loadSingleFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/audio_recording.aac';

    if (File(filePath).existsSync()) {
      setState(() {
        _filePath = filePath;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColor.clPrBackgroundf5f7f9,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          spacing: 8,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomAppBar(title: "${widget.title} surasini qiroat qilish", onTab: (){
                context.pop();
                      }),
            ),
            SizedBox(
                height: 400,
                child: Image(image: AssetImage(Assets.images.imgSurah))),
          _isRecording? Text("00:$_start",style:AppStyle.regular(size: 18,color: AppColor.clPrDark010513) ,) :Column(
              spacing: 8,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Text("Qiroatni yozib yuborish uchun quyidagi tugmani 1 marta bosing",style: AppStyle.medium(size: 14, color: AppColor.clPrDark010513),textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Text("Qiroatni 10dan 120 sekundgacha yuboring",style: AppStyle.regular(size: 12,color: AppColor.clGrey92929D),textAlign: TextAlign.center),
                ),
              ],
            ),

             Spacer(),
           isNavBar? CustomNavbarSecond(icon:_isPlaying ? Icons.pause : Icons.play_arrow,onPush: (){
             // context.pushReplacement(Routes.detail,extra:{
             //   "title": widget.title,
             //   "isChat":true,
             // },
             //   );
             GoRouter.of(context).go(Routes.detail, extra:{
             "title": widget.title,
             "isChat":true,
             },);
             audioProvider.addAudio(_filePath!);

           },onLeftTab: _playRecording,onRightTab: _deleteRecording,): _isRecording
               ? AnimatedBuilder(
             animation: _animationController,
             builder: (context, child) {
               return Container(
                 width: _sizeAnimation.value,
                 height: _sizeAnimation.value,
                 decoration: BoxDecoration(
                   color: _colorAnimation.value,
                   shape: BoxShape.circle,
                 ),
                 child: IconButton(
                   onPressed: _stopRecording,
                   icon: Icon(Icons.stop, color: Colors.white, size: 30),

                 ),
               );
             },
           ):
           AudioRecordingWidget(
              icon: isTrueRecording?Assets.icons.icPause:Assets.icons.icMic,
              onTab: ()=> _startRecording(),
             ),
            isNavBar?SizedBox(): SizedBox(height: 50,),
          ],
        ),
      ),

    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _recorder!.closeRecorder();
    _player!.closePlayer();
    _timer?.cancel();
    super.dispose();
  }


}

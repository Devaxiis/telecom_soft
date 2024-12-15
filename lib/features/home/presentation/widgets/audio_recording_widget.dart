import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../common/app_color.dart';

class AudioRecordingWidget extends StatelessWidget {
  const AudioRecordingWidget({super.key, required this.onTab, required this.icon});

  final Function() onTab;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: ()=>onTab(),
      child: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.clGreen30bf77,
          shape: BoxShape.circle
        ),
        child: SvgPicture.asset(icon,color: AppColor.clPrWhiteFFFFFF,),
      ),
    );
  }
}

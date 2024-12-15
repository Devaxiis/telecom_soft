
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telecom_soft_ui/common/app_color.dart';
import 'package:telecom_soft_ui/common/app_style.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtCartWidget extends StatelessWidget {
  const YtCartWidget({super.key, required this.controller});

  final YoutubePlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 233.h,
      width: 312.w,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColor.clPrBackgroundf5f7f9,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Container(
            height: 169.h,
            width: 296.w,
            decoration: BoxDecoration(
            color: AppColor.clGrey92929D,
              borderRadius: BorderRadius.circular(10)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: YoutubePlayer(
                controller: controller,
                showVideoProgressIndicator: true,
              ),
            ),
          ),
          Text("Fotiha surasida yo‘l qo‘yilishi mumkin bo‘lgan xatolar ",style: AppStyle.medium(size: 14,color: AppColor.clPrDark010513,wordSpace: 2,),textAlign: TextAlign.start,)
        ],
      ),
    );
  }
}

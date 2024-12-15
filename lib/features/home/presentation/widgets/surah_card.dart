import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telecom_soft_ui/common/app_color.dart';
import 'package:telecom_soft_ui/common/app_style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SurahCard extends StatelessWidget {
  const SurahCard({super.key, required this.title, required this.onTab});

  final String title;
  final Function() onTab;
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap:()=> onTab(),
      child: Container(
        height: 52.h,
        width: 343.w,
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
        decoration: BoxDecoration(
          color: AppColor.clPrWhiteFFFFFF,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: AppStyle.medium(size: 17,color: AppColor.clPrDark010513),),
            Icon(Icons.arrow_forward_ios_outlined,color: AppColor.clPrDark010513,)
          ],
        ),
      ),
    );
  }
}

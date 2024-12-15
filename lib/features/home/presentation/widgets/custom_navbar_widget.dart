
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telecom_soft_ui/common/app_color.dart';
import 'package:telecom_soft_ui/common/app_style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CustomNavbarWidget extends StatelessWidget {
  const CustomNavbarWidget({super.key, required this.onTab});

  final Function() onTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 101.h,
      width:MediaQuery.sizeOf(context).width,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.clPrWhiteFFFFFF,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(64),topRight: Radius.circular(64))
      ),
      child: Container(
        height: 64.h,
        width: 356.w,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.clPrBackgroundf5f7f9,
          borderRadius: BorderRadius.circular(62)
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Qiroatni tekshirish...",style: AppStyle.medium(size: 14,color: AppColor.clGrey92929D),),
            ZoomTapAnimation(
              onTap: ()=>onTab(),
              child: Container(
                height: 40.h,
                width: 148.w,
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.clGreen30bf77,
                  borderRadius: BorderRadius.circular(48)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Qiroat qilish",style: AppStyle.medium(size: 15),),
                    Icon(Icons.arrow_forward_ios_outlined,color: AppColor.clPrWhiteFFFFFF,size: 18,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

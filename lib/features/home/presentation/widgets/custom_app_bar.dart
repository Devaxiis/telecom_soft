import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telecom_soft_ui/common/app_color.dart';
import 'package:telecom_soft_ui/common/app_style.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, required this.onTab});

  final String title;
  final Function() onTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      width: 343.w,
      padding: EdgeInsets.symmetric(horizontal: 16.dg,vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.clPrWhiteFFFFFF,
        borderRadius: BorderRadius.circular(16.r)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
           onPressed: ()=> onTab(),
           icon: Icon(Icons.arrow_back_ios,size: 15,),),
          Spacer(),
          Text(title,style: AppStyle.medium(size: 14,color: AppColor.clPrDark010513),),
          Spacer(),
          SizedBox(width: 25.w,height: 25.h,),
        ],
      ),
    );
  }
}


import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:telecom_soft_ui/common/app_color.dart';
import 'package:telecom_soft_ui/common/app_routes.dart';

class CustomNavbarSecond extends StatelessWidget {
  const CustomNavbarSecond({super.key, required this.onLeftTab, required this.onRightTab, required this.onPush, required this.icon});

  final Function() onLeftTab;
  final Function() onPush;
  final Function() onRightTab;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 101.h,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(33),topLeft: Radius.circular(33)),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Play Icon Button
          Container(
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(icon,
                color: Colors.green,
              ),
              onPressed: () => onLeftTab(),
            ),
          ),

          // "Yuborish" Button
          InkWell(
            onTap: ()=> onPush(),

            child: Container(
              width: 180,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  'Yuborish',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Delete Icon Button
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.blueGrey,
              ),
              onPressed: () =>onRightTab(),
            ),
          ),
        ],
      ),
    );
  }
}

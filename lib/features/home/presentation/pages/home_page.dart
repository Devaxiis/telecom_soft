import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:go_router/go_router.dart';
import 'package:telecom_soft_ui/common/constants.dart';
import 'package:telecom_soft_ui/features/home/presentation/widgets/surah_card.dart';

import '../../../../common/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title: Text("Surah"),

      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: ListView.separated(
                itemCount: surahList.length,
                itemBuilder: (context,index){
                  return SurahCard(
                    onTab: (){
                      context.push(Routes.detail,extra: {
                        "title":surahList[index],
                        "isChat":false,
                      },
                       );
                      
                    },
                    title: surahList[index],);
                },
              separatorBuilder: (context,index){
                  return SizedBox(height: 16.h,);
              },

            ),
          ),
      ),
    );
  }
}

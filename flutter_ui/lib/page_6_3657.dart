import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/components/Component_2_427.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_441.dart';
import 'package:flutter_ui/components/Component_2_491.dart';
import 'package:flutter_ui/custom_widget/CustomWidget_21_362.dart';
import 'package:flutter_ui/components/Component_6_3694.dart';
import 'package:flutter_ui/components/Component_6_3796.dart';

class page_6_3657 extends StatefulWidget {

  page_6_3657({super.key,});
  @override
  State<page_6_3657> createState() => _page_6_3657State();
}

class _page_6_3657State extends State<page_6_3657> {


  @override
  void initState() {
    super.initState();
  
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil().rootSize = Size(375, 812);
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView(
          children: [
            Container(
              width: 375.w,
              height: 812.h,
              decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255,1),),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                key: ValueKey("6:3657"),
                children: [
                  CustomWidget_21_362(),
                  Component_6_3694({"6:3694":PixFlutterInterface(width:375.w,height:812.h,left:0.w,top:-0.11.h,),}, false),
                  Component_6_3796({"6:3796":PixFlutterInterface(width:300.w,height:165.h,left:37.5.w,top:323.5.h,),"6:3798":PixFlutterInterface(textColor:Color.fromRGBO(0, 0, 0,1),width:252.w,height:17.h,),"6:3799":PixFlutterInterface(width:252.w,height:32.h,left:8.w,top:33.h,),"2:491":PixFlutterInterface(width:268.w,height:40.h,left:0.w,top:0.h,),"2:493":PixFlutterInterface(width:30.w,height:15.h,left:119.w,top:12.5.h,),"6:3797":PixFlutterInterface(width:268.w,height:73.h,),"6:3800":PixFlutterInterface(left:16.w,top:109.h,),"2:177":PixFlutterInterface(width:39.w,height:15.h,left:45.5.w,top:12.5.h,),}, false),
                ],),),
          ],
          )
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          Component_2_427({"2:427":PixFlutterInterface(width:375.w,height:44.h,left:0.w,top:0.h,),}, false),
        ],),
      );
    }
}

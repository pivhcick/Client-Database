import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/components/Component_2_441.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_25_5705.dart';
import 'package:flutter_ui/components/Component_2_491.dart';
import 'package:flutter_ui/components/Component_2_427.dart';

class page_25_9367 extends StatefulWidget {

  page_25_9367({super.key,});
  @override
  State<page_25_9367> createState() => _page_25_9367State();
}

class _page_25_9367State extends State<page_25_9367> {


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
                key: ValueKey("25:9367"),
                children: [
                  Positioned(
                    height: 768.h,
                    left: 0.w,
                    top: 44.h,
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      physics: NeverScrollableScrollPhysics(),
                      child: Container(
                        constraints: BoxConstraints(minWidth: 375.w, minHeight: 768.h),
                        padding: EdgeInsets.only(left: 24.w,right: 24.w, top: 24.h,bottom: 24.h),
                        child: Column(
                          key: ValueKey("25:9368"),
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 24.h,
                          children: [
                            SizedBox(
                              width: 327.w,
                              height: 100.h,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                physics: NeverScrollableScrollPhysics(),
                                child: Container(
                                  constraints: BoxConstraints(minWidth: 327.w, minHeight: 100.h),
                                  child: Column(
                                    key: ValueKey("25:9369"),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 8.h,
                                    children: [
                                      Container(
                                        width: 327.w,
                                        child: Text("Изминение напоминания",
                                          key: ValueKey("25:9370"),
                                          style: TextStyle(color: Color.fromRGBO(31, 32, 36,1), fontFamily: "Inter", fontWeight: FontWeight.bold, fontSize: 15.5.sp, letterSpacing: 0.07999999821186066.w),),),
                                      Container(
                                        width: 327.w,
                                        child: Text("После изменения в указанную вами дату и время вам придет уведомление от присложения. Проверьте что у вас включены уведомленияю",
                                          key: ValueKey("25:9371"),
                                          style: TextStyle(color: Color.fromRGBO(113, 114, 122,1), fontFamily: "Sora", fontSize: 13.5.sp, height: 0.07142857142857142, letterSpacing: 0.14.w),),),
                                    ],),),),),
                            SizedBox(
                              width: 327.w,
                              height: 259.h,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                physics: NeverScrollableScrollPhysics(),
                                child: Container(
                                  constraints: BoxConstraints(minWidth: 327.w, minHeight: 259.h),
                                  child: Column(
                                    key: ValueKey("25:9372"),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 16.h,
                                    children: [
                                      Component_2_441({"2:441":PixFlutterInterface(width:327.w,height:69.h,left:0.w,top:0.h,),"2:442":PixFlutterInterface(width:327.w,height:15.h,),"2:445":PixFlutterInterface(width:10.w,height:18.h,),"2:446":PixFlutterInterface(width:295.w,height:18.h,),"2:447":PixFlutterInterface(width:159.w,height:18.h,left:0.w,top:0.h,),"2:443":PixFlutterInterface(width:327.w,height:48.h,),"2:444":PixFlutterInterface(width:295.w,height:18.h,left:16.w,top:15.h,),"2:450":PixFlutterInterface(width:295.w,height:14.h,),}, true),
                                      Component_25_5705({"25:5705":PixFlutterInterface(width:327.w,height:71.h,left:0.w,top:87.h,),"25:5706":PixFlutterInterface(width:327.w,height:15.h,),"25:5711":PixFlutterInterface(width:59.w,height:20.h,),"25:5707":PixFlutterInterface(width:327.w,height:48.h,),"25:5708":PixFlutterInterface(width:295.w,height:20.h,),"25:5710":PixFlutterInterface(width:295.w,height:20.h,),"2:506":PixFlutterInterface(left:1.72.w,top:0.h,),"2:507":PixFlutterInterface(left:0.w,top:1.38.h,),}, true),
                                      Component_2_491({"2:491":PixFlutterInterface(backgroundColor:Color.fromRGBO(245, 49, 120,1),width:327.w,height:48.h,left:0.w,top:174.h,),"2:493":PixFlutterInterface(width:83.w,height:21.h,left:122.w,top:13.5.h,),}, true),
                                      Container(
                                        width: 327.w,
                                        child: Text("Отмена",
                                          key: ValueKey("25:9376"),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Color.fromRGBO(0, 111, 253,1), fontFamily: "Sora", fontSize: 15.5.sp, letterSpacing: 0.w),),),
                                    ],),),),),
                          ],),),),),
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

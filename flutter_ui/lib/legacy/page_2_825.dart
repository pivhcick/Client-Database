import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/components/Component_2_461.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_451.dart';
import 'package:flutter_ui/components/Component_2_441.dart';
import 'package:flutter_ui/components/Component_2_491.dart';
import 'package:flutter_ui/components/Component_2_427.dart';

class page_2_825 extends StatefulWidget {

  page_2_825({super.key,});
  @override
  State<page_2_825> createState() => _page_2_825State();
}

class _page_2_825State extends State<page_2_825> {


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
                key: ValueKey("2:825"),
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
                          key: ValueKey("2:826"),
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 24.h,
                          children: [
                            SizedBox(
                              width: 327.w,
                              height: 46.h,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                physics: NeverScrollableScrollPhysics(),
                                child: Container(
                                  constraints: BoxConstraints(minWidth: 327.w, minHeight: 46.h),
                                  child: Column(
                                    key: ValueKey("2:827"),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 8.h,
                                    children: [
                                      Container(
                                        width: 327.w,
                                        child: Text("Создание пользователя",
                                          key: ValueKey("2:828"),
                                          style: TextStyle(color: Color.fromRGBO(31, 32, 36,1), fontFamily: "Inter", fontWeight: FontWeight.bold, fontSize: 15.5.sp, letterSpacing: 0.07999999821186066.w),),),
                                      Container(
                                        width: 327.w,
                                        child: Text("Укажите данные нового пользователя",
                                          key: ValueKey("2:829"),
                                          style: TextStyle(color: Color.fromRGBO(113, 114, 122,1), fontFamily: "Sora", fontSize: 13.5.sp, height: 0.07142857142857142, letterSpacing: 0.14.w),),),
                                    ],),),),),
                            SizedBox(
                              width: 327.w,
                              height: 671.h,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                physics: NeverScrollableScrollPhysics(),
                                child: Container(
                                  constraints: BoxConstraints(minWidth: 327.w, minHeight: 671.h),
                                  child: Column(
                                    key: ValueKey("2:830"),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 16.h,
                                    children: [
                                      Component_2_461({"2:461":PixFlutterInterface(width:327.w,height:71.h,left:0.w,top:0.h,),"2:462":PixFlutterInterface(width:327.w,height:15.h,),"2:465":PixFlutterInterface(width:10.w,height:18.h,),"2:466":PixFlutterInterface(width:295.w,height:18.h,),"2:467":PixFlutterInterface(width:116.w,height:18.h,left:0.w,top:0.h,),"2:463":PixFlutterInterface(width:327.w,height:48.h,),"2:464":PixFlutterInterface(width:295.w,height:18.h,left:16.w,top:15.h,),"2:470":PixFlutterInterface(width:295.w,height:14.h,),"2:506":PixFlutterInterface(left:1.72.w,top:0.h,),"2:507":PixFlutterInterface(left:0.w,top:1.38.h,),}, true),
                                      Component_2_451({"2:451":PixFlutterInterface(width:327.w,height:69.h,left:0.w,top:87.h,),"2:452":PixFlutterInterface(width:327.w,height:15.h,),"2:456":PixFlutterInterface(width:295.w,height:18.h,),"2:457":PixFlutterInterface(width:27.w,height:18.h,left:0.w,top:0.h,),"2:458":PixFlutterInterface(left:28.w,top:9.h,),"2:453":PixFlutterInterface(width:327.w,height:48.h,),"2:454":PixFlutterInterface(width:295.w,height:18.h,left:16.w,top:15.h,),}, true),
                                      Component_2_441({"2:441":PixFlutterInterface(width:327.w,height:69.h,left:0.w,top:174.h,),"2:442":PixFlutterInterface(width:327.w,height:15.h,),"2:446":PixFlutterInterface(width:295.w,height:18.h,),"2:447":PixFlutterInterface(width:30.w,height:18.h,left:0.w,top:0.h,),"2:443":PixFlutterInterface(width:327.w,height:48.h,),"2:444":PixFlutterInterface(width:295.w,height:18.h,left:16.w,top:15.h,),}, true),
                                      Component_2_441({"2:441":PixFlutterInterface(width:327.w,height:69.h,left:0.w,top:261.h,),"2:442":PixFlutterInterface(width:327.w,height:15.h,),"2:446":PixFlutterInterface(width:295.w,height:18.h,),"2:447":PixFlutterInterface(width:63.w,height:18.h,left:0.w,top:0.h,),"2:443":PixFlutterInterface(width:327.w,height:48.h,),"2:444":PixFlutterInterface(width:295.w,height:18.h,left:16.w,top:15.h,),}, true),
                                      Component_2_441({"2:441":PixFlutterInterface(width:327.w,height:69.h,left:0.w,top:348.h,),"2:442":PixFlutterInterface(width:327.w,height:15.h,),"2:446":PixFlutterInterface(width:295.w,height:18.h,),"2:447":PixFlutterInterface(width:39.w,height:18.h,left:0.w,top:0.h,),"2:443":PixFlutterInterface(width:327.w,height:48.h,),"2:444":PixFlutterInterface(width:295.w,height:18.h,left:16.w,top:15.h,),}, true),
                                      Component_2_441({"2:441":PixFlutterInterface(width:327.w,height:69.h,left:0.w,top:435.h,),"2:442":PixFlutterInterface(width:327.w,height:15.h,),"2:446":PixFlutterInterface(width:271.w,height:18.h,),"2:447":PixFlutterInterface(width:108.w,height:18.h,left:0.w,top:0.h,),"2:504":PixFlutterInterface(width:12.w,height:12.w,left:295.w,top:16.h,),"2:510":PixFlutterInterface(backgroundColor:Color.fromRGBO(143, 144, 152,1),width:16.w,height:16.w,),"2:443":PixFlutterInterface(width:327.w,height:48.h,),"2:444":PixFlutterInterface(width:271.w,height:18.h,left:16.w,top:15.h,),"2:505":PixFlutterInterface(width:16.w,height:13.67.h,left:0.w,top:1.16.h,),"2:506":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.72.w,top:0.h,),"2:507":PixFlutterInterface(width:16.w,height:10.91.h,left:0.w,top:1.38.h,),"2:508":PixFlutterInterface(width:16.w,height:10.91.h,),"2:509":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.17.w,top:-2.55.h,),}, true),
                                      Component_2_441({"2:441":PixFlutterInterface(width:327.w,height:69.h,left:0.w,top:522.h,),"2:446":PixFlutterInterface(width:271.w,height:18.h,),"2:447":PixFlutterInterface(width:89.w,height:18.h,left:0.w,top:0.h,),"2:504":PixFlutterInterface(width:12.w,height:12.w,left:295.w,top:16.h,),"2:510":PixFlutterInterface(backgroundColor:Color.fromRGBO(143, 144, 152,1),width:16.w,height:16.w,),"2:443":PixFlutterInterface(width:327.w,height:48.h,left:0.w,top:0.h,),"2:444":PixFlutterInterface(width:271.w,height:18.h,left:16.w,top:15.h,),"2:505":PixFlutterInterface(width:16.w,height:13.67.h,left:0.w,top:1.16.h,),"2:506":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.72.w,top:0.h,),"2:507":PixFlutterInterface(width:16.w,height:10.91.h,left:0.w,top:1.38.h,),"2:508":PixFlutterInterface(width:16.w,height:10.91.h,),"2:509":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.17.w,top:-2.55.h,),}, true),
                                      Component_2_491({"2:491":PixFlutterInterface(backgroundColor:Color.fromRGBO(245, 49, 120,1),width:327.w,height:48.h,left:0.w,top:586.h,),"2:493":PixFlutterInterface(width:83.w,height:21.h,left:122.w,top:13.5.h,),}, true),
                                      Container(
                                        width: 327.w,
                                        child: Text("Отмена",
                                          key: ValueKey("25:1386"),
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

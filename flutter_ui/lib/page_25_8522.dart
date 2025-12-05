import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/components/Component_2_427.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_1476.dart';
import 'package:flutter_ui/components/Component_2_441.dart';
import 'package:flutter_ui/components/Component_2_461.dart';
import 'package:flutter_ui/components/Component_2_491.dart';

class page_25_8522 extends StatefulWidget {

  page_25_8522({super.key,});
  @override
  State<page_25_8522> createState() => _page_25_8522State();
}

class _page_25_8522State extends State<page_25_8522> {


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
                key: ValueKey("25:8522"),
                children: [
                  Positioned(
                    height: 433.h,
                    left: 24.w,
                    top: 94.h,
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      physics: NeverScrollableScrollPhysics(),
                      child: Container(
                        constraints: BoxConstraints(minWidth: 327.w, minHeight: 433.h),
                        child: Column(
                          key: ValueKey("25:8920"),
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 16.h,
                          children: [
                            Component_2_441({"2:441":PixFlutterInterface(width:327.w,height:69.h,left:0.w,top:0.h,),"2:442":PixFlutterInterface(width:327.w,height:15.h,),"2:446":PixFlutterInterface(width:295.w,height:18.h,),"2:447":PixFlutterInterface(width:161.w,height:18.h,left:0.w,top:0.h,),"2:443":PixFlutterInterface(width:327.w,height:48.h,),"2:444":PixFlutterInterface(width:295.w,height:18.h,left:16.w,top:15.h,),}, true),
                            Component_2_441({"2:441":PixFlutterInterface(width:327.w,height:69.h,left:0.w,top:87.h,),"2:442":PixFlutterInterface(width:327.w,height:15.h,),"2:446":PixFlutterInterface(width:295.w,height:18.h,),"2:447":PixFlutterInterface(width:63.w,height:18.h,left:0.w,top:0.h,),"2:443":PixFlutterInterface(width:327.w,height:48.h,),"2:444":PixFlutterInterface(width:295.w,height:18.h,left:16.w,top:15.h,),}, true),
                            Component_2_461({"2:461":PixFlutterInterface(width:327.w,height:71.h,left:0.w,top:174.h,),"2:462":PixFlutterInterface(width:327.w,height:15.h,),"2:465":PixFlutterInterface(width:10.w,height:18.h,),"2:466":PixFlutterInterface(width:295.w,height:18.h,),"2:467":PixFlutterInterface(width:116.w,height:18.h,left:0.w,top:0.h,),"2:463":PixFlutterInterface(width:327.w,height:48.h,),"2:464":PixFlutterInterface(width:295.w,height:18.h,left:16.w,top:15.h,),"2:470":PixFlutterInterface(width:295.w,height:14.h,),"2:506":PixFlutterInterface(left:1.72.w,top:0.h,),"2:507":PixFlutterInterface(left:0.w,top:1.38.h,),}, true),
                            Component_2_441({"2:441":PixFlutterInterface(width:327.w,height:69.h,left:0.w,top:261.h,),"2:442":PixFlutterInterface(width:327.w,height:15.h,),"2:446":PixFlutterInterface(width:295.w,height:18.h,),"2:447":PixFlutterInterface(width:39.w,height:18.h,left:0.w,top:0.h,),"2:443":PixFlutterInterface(width:327.w,height:48.h,),"2:444":PixFlutterInterface(width:295.w,height:18.h,left:16.w,top:15.h,),}, true),
                            Component_2_491({"2:491":PixFlutterInterface(backgroundColor:Color.fromRGBO(245, 49, 120,1),width:327.w,height:48.h,left:0.w,top:348.h,),"2:493":PixFlutterInterface(width:83.w,height:21.h,left:122.w,top:13.5.h,),}, true),
                            Container(
                              width: 327.w,
                              child: Text("Удалить",
                                key: ValueKey("25:8926"),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color.fromRGBO(255, 97, 109,1), fontFamily: "Sora", fontSize: 15.5.sp, letterSpacing: 0.w),),),
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
          Component_2_1476({"2:1476":PixFlutterInterface(width:375.w,height:56.h,left:0.w,top:44.h,),"2:1478":PixFlutterInterface(width:142.w,height:20.h,left:117.w,top:19.5.h,),"23:1435":PixFlutterInterface(width:19.17.w,height:19.17.w,left:0.42.w,top:0.42.h,),"23:1436":PixFlutterInterface(width:20.w,height:20.w,left:0.w,top:0.h,),}, false),
        ],),
      );
    }
}

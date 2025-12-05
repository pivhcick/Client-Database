import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/components/Component_25_5705.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_491.dart';
import 'package:flutter_ui/components/Component_2_427.dart';

class page_26_1872 extends StatefulWidget {

  page_26_1872({super.key,});
  @override
  State<page_26_1872> createState() => _page_26_1872State();
}

class _page_26_1872State extends State<page_26_1872> {


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
                key: ValueKey("26:1872"),
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
                          key: ValueKey("26:1873"),
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 24.h,
                          children: [
                            SizedBox(
                              width: 327.w,
                              height: 20.h,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                physics: NeverScrollableScrollPhysics(),
                                child: Container(
                                  constraints: BoxConstraints(minWidth: 327.w, minHeight: 20.h),
                                  child: Column(
                                    key: ValueKey("26:1874"),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 8.h,
                                    children: [
                                      Container(
                                        width: 327.w,
                                        child: Text("Изминение записи о контакте",
                                          key: ValueKey("26:1875"),
                                          style: TextStyle(color: Color.fromRGBO(31, 32, 36,1), fontFamily: "Inter", fontWeight: FontWeight.bold, fontSize: 15.5.sp, letterSpacing: 0.07999999821186066.w),),),
                                    ],),),),),
                            SizedBox(
                              width: 327.w,
                              height: 172.h,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                physics: NeverScrollableScrollPhysics(),
                                child: Container(
                                  constraints: BoxConstraints(minWidth: 327.w, minHeight: 172.h),
                                  child: Column(
                                    key: ValueKey("26:1877"),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 16.h,
                                    children: [
                                      Component_25_5705({"25:5705":PixFlutterInterface(width:327.w,height:71.h,left:0.w,top:0.h,),"25:5706":PixFlutterInterface(width:327.w,height:15.h,),"25:5707":PixFlutterInterface(width:327.w,height:48.h,),"25:5708":PixFlutterInterface(width:295.w,height:20.h,),"25:5709":PixFlutterInterface(width:10.w,height:18.h,),"25:5710":PixFlutterInterface(width:295.w,height:20.h,),"25:5711":PixFlutterInterface(width:59.w,height:20.h,),"25:5712":PixFlutterInterface(width:16.w,height:0.h,),"2:504":PixFlutterInterface(width:16.w,height:16.w,),"25:5714":PixFlutterInterface(width:295.w,height:14.h,),"2:505":PixFlutterInterface(width:16.w,height:13.67.h,),"2:506":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.72.w,top:0.h,),"2:507":PixFlutterInterface(width:16.w,height:10.91.h,left:0.w,top:1.38.h,),"2:508":PixFlutterInterface(width:16.w,height:10.91.h,),"2:509":PixFlutterInterface(width:13.67.w,height:13.67.w,),"2:510":PixFlutterInterface(width:16.w,height:16.w,),}, true),
                                      Component_2_491({"2:491":PixFlutterInterface(backgroundColor:Color.fromRGBO(245, 49, 120,1),width:327.w,height:48.h,left:0.w,top:87.h,),"2:493":PixFlutterInterface(width:83.w,height:21.h,left:122.w,top:13.5.h,),}, true),
                                      Container(
                                        width: 327.w,
                                        child: Text("Отмена",
                                          key: ValueKey("26:1881"),
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

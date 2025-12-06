import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/components/Component_2_427.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_1376.dart';
import 'package:flutter_ui/components/Component_2_1513.dart';
import 'package:flutter_ui/components/Component_25_3671.dart';
import 'package:flutter_ui/components/Size4.dart';
import 'package:flutter_ui/components/ArrowRight0.dart';
import 'package:flutter_ui/components/Component_25_7043.dart';
import 'package:flutter_ui/custom_widget/CustomWidget_25_7085.dart';
import 'package:flutter_ui/components/ArrowLeft.dart';

class page_25_6586 extends StatefulWidget {

  page_25_6586({super.key,});
  @override
  State<page_25_6586> createState() => _page_25_6586State();
}

class _page_25_6586State extends State<page_25_6586> {


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
              height: 1000.h,
              decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255,1),),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                key: ValueKey("25:6586"),
                children: [
                  Positioned(
                    width: 375.w,
                    height: 1000.h,
                    left: 0.w,
                    top: 0.h,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(),
                      child: Stack(
                        key: ValueKey("25:6587"),),),),
                  CustomWidget_25_7085(),
                ],),),
          ],
          )
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          Component_2_427({"2:427":PixFlutterInterface(width:375.w,height:44.h,left:0.w,top:0.h,),"2:429":PixFlutterInterface(width:54.w,height:18.h,),"2:431":PixFlutterInterface(width:29.w,height:20.h,),"2:437":PixFlutterInterface(width:19.w,height:17.h,),}, false),
          Component_2_1376({"2:1376":PixFlutterInterface(left:0.w,top:966.h,),}, false),
          Component_2_1513({"2:1513":PixFlutterInterface(width:375.w,height:88.h,left:0.w,top:912.h,),"2:1520":PixFlutterInterface(width:111.67.w,height:40.h,left:16.w,top:16.h,),"2:1523":PixFlutterInterface(width:111.67.w,height:42.h,left:247.33.w,top:16.h,),"2:194":PixFlutterInterface(width:20.w,height:20.w,left:45.83.w,top:0.h,),"2:1522":PixFlutterInterface(width:44.w,height:12.h,left:33.83.w,top:28.h,text:"Tab 2",),"2:1525":PixFlutterInterface(width:28.w,height:14.h,left:22.w,top:28.h,text:"Profile",),"2:1539":PixFlutterInterface(backgroundColor:Color.fromRGBO(212, 214, 221,1),width:20.w,height:20.w,),"2:1548":PixFlutterInterface(backgroundColor:Color.fromRGBO(212, 214, 221,1),width:20.w,height:20.w,left:0.w,top:0.h,),"2:1553":PixFlutterInterface(backgroundColor:Color.fromRGBO(212, 214, 221,1),width:18.33.w,height:18.33.w,left:0.83.w,top:0.83.h,),"2:1554":PixFlutterInterface(backgroundColor:Color.fromRGBO(0, 111, 253,1),width:20.w,height:20.w,),"2:1538":PixFlutterInterface(width:20.w,height:20.w,left:0.w,top:0.h,),"2:1547":PixFlutterInterface(width:16.67.w,height:20.h,left:1.67.w,top:0.h,),}, false),
          Positioned(
            width: 375.w,
            height: 56.h,
            top: 44.h,
            left: 0.w,
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255,1),),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                key: ValueKey("25:6886"),
                children: [
                  Positioned(
                    left: 129.w,
                    top: 19.5.h,
                    child: Text("Имя компании",
                      key: ValueKey("25:6890"),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color.fromRGBO(31, 32, 36,1), fontFamily: "Inter", fontWeight: FontWeight.bold, fontSize: 15.5.sp, letterSpacing: 0.07999999821186066.w),),),
                  ArrowLeft({"2:1540":PixFlutterInterface(width:20.w,height:20.w,left:24.w,top:18.h,),"2:1541":PixFlutterInterface(width:11.67.w,height:19.17.h,left:4.17.w,top:0.42.h,),"2:1542":PixFlutterInterface(width:20.w,height:20.w,left:0.w,top:0.h,),}, false),
                  Positioned(
                    left: 300.w,
                    top: 20.h,
                    child: Text("Удалить",
                      key: ValueKey("25:7100"),
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Color.fromRGBO(255, 97, 109,1), fontFamily: "Inter", fontWeight: FontWeight.bold, fontSize: 11.5.sp, letterSpacing: 0.w),),),
                ],),),),
        ],),
      );
    }
}

import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/components/Component_25_1789.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_427.dart';
import 'package:flutter_ui/components/Component_2_1376.dart';
import 'package:flutter_ui/components/Size3.dart';
import 'package:flutter_ui/components/Component_2_1476.dart';
import 'package:flutter_ui/custom_widget/CustomWidget_24_1302.dart';
import 'package:flutter_ui/components/Component_2_1513.dart';

class page_2_1339 extends StatefulWidget {

  page_2_1339({super.key,});
  @override
  State<page_2_1339> createState() => _page_2_1339State();
}

class _page_2_1339State extends State<page_2_1339> {


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
                key: ValueKey("2:1339"),
                children: [
                  Positioned(
                    height: 514.h,
                    left: 24.w,
                    top: 279.h,
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      physics: NeverScrollableScrollPhysics(),
                      child: Container(
                        constraints: BoxConstraints(minWidth: 327.w, minHeight: 514.h),
                        child: Column(
                          key: ValueKey("5:8571"),
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 16.h,
                          children: [
                            Component_25_1789({"25:1789":PixFlutterInterface(width:327.w,height:90.h,left:0.w,top:106.h,),"25:1793":PixFlutterInterface(width:199.w,height:18.h,),"25:1794":PixFlutterInterface(width:199.w,height:36.h,),}, true),
                            Component_25_1789({"25:1789":PixFlutterInterface(width:327.w,height:90.h,left:0.w,top:212.h,),"25:1793":PixFlutterInterface(width:199.w,height:18.h,),"25:1794":PixFlutterInterface(width:199.w,height:36.h,),}, true),
                            Component_25_1789({"25:1789":PixFlutterInterface(width:327.w,height:90.h,left:0.w,top:318.h,),"25:1793":PixFlutterInterface(width:199.w,height:18.h,),"25:1794":PixFlutterInterface(width:199.w,height:36.h,),}, true),
                            Component_25_1789({"25:1789":PixFlutterInterface(width:327.w,height:90.h,left:0.w,top:424.h,),"25:1793":PixFlutterInterface(width:199.w,height:18.h,),"25:1794":PixFlutterInterface(width:199.w,height:36.h,),}, true),
                          ],),),),),
                  Positioned(
                    width: 375.w,
                    height: 812.h,
                    left: 0.w,
                    top: 0.h,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(),
                      child: Stack(
                        key: ValueKey("24:1300"),),),),
                  CustomWidget_24_1302(),
                ],),),
          ],
          )
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          Component_2_427({"2:427":PixFlutterInterface(width:375.w,height:44.h,left:0.w,top:0.h,),}, false),
          Component_2_1376({"2:1376":PixFlutterInterface(left:0.w,top:778.h,),}, false),
          Component_2_1476({"2:1476":PixFlutterInterface(width:375.w,height:56.h,left:0.w,top:0.h,),"2:1478":PixFlutterInterface(width:90.w,height:20.h,left:143.w,top:19.5.h,),"23:1435":PixFlutterInterface(width:19.17.w,height:19.17.w,left:0.42.w,top:0.42.h,),"23:1436":PixFlutterInterface(width:20.w,height:20.w,left:0.w,top:0.h,),}, false),
          Component_2_1513({"2:1513":PixFlutterInterface(width:375.w,height:88.h,left:0.w,top:724.h,),"2:1520":PixFlutterInterface(width:111.67.w,height:42.h,left:16.w,top:16.h,),"2:1523":PixFlutterInterface(width:111.67.w,height:40.h,left:247.33.w,top:16.h,),"2:194":PixFlutterInterface(width:20.w,height:20.w,left:45.83.w,top:0.h,),"2:1522":PixFlutterInterface(width:55.w,height:12.h,left:28.33.w,top:28.h,),"2:1525":PixFlutterInterface(width:28.w,height:14.h,left:22.w,top:28.h,text:"Profile",),"2:1539":PixFlutterInterface(backgroundColor:Color.fromRGBO(0, 111, 253,1),width:20.w,height:20.w,),"2:1548":PixFlutterInterface(backgroundColor:Color.fromRGBO(212, 214, 221,1),width:20.w,height:20.w,),"2:1554":PixFlutterInterface(backgroundColor:Color.fromRGBO(212, 214, 221,1),width:20.w,height:20.w,),"2:1538":PixFlutterInterface(width:20.w,height:20.w,),"2:1547":PixFlutterInterface(width:16.67.w,height:20.h,left:1.67.w,top:0.h,),"2:1553":PixFlutterInterface(width:18.33.w,height:18.33.w,left:0.83.w,top:0.83.h,),}, false),
        ],),
      );
    }
}

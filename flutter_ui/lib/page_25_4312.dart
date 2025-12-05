import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/components/Component_2_427.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_1376.dart';
import 'package:flutter_ui/components/Component_25_3652.dart';
import 'package:flutter_ui/components/Component_25_4498.dart';
import 'package:flutter_ui/components/Add.dart';
import 'package:flutter_ui/components/Component_25_7050.dart';
import 'package:flutter_ui/components/ArrowRight0.dart';
import 'package:flutter_ui/custom_widget/CustomWidget_25_4726.dart';
import 'package:flutter_ui/components/Component_2_1513.dart';

class page_25_4312 extends StatefulWidget {

  page_25_4312({super.key,});
  @override
  State<page_25_4312> createState() => _page_25_4312State();
}

class _page_25_4312State extends State<page_25_4312> {


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
                key: ValueKey("25:4312"),
                children: [
                  Positioned(
                    width: 375.w,
                    height: 812.h,
                    left: 0.w,
                    top: 0.h,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(),
                      child: Stack(
                        key: ValueKey("25:4313"),),),),
                  Component_25_3652({"25:3652":PixFlutterInterface(backgroundColor:Color.fromRGBO(245, 246, 250,1),width:343.w,height:44.h,left:16.w,top:54.h,),"25:3654":PixFlutterInterface(width:279.w,height:20.h,),"25:3655":PixFlutterInterface(width:47.w,height:20.h,),}, false),
                  Positioned(
                    width: 343.w,
                    left: 16.w,
                    top: 96.h,
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        constraints: BoxConstraints(minWidth: 343.w, minHeight: 68.h),
                        padding: EdgeInsets.only(left: 16.w,right: 16.w, top: 16.h,bottom: 16.h),
                        child: Row(
                          key: ValueKey("25:4489"),
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Component_25_4498({"25:4498":PixFlutterInterface(width:141.w,height:36.h,left:16.w,top:16.h,),"2:3271":PixFlutterInterface(width:12.w,height:12.w,),"25:4501":PixFlutterInterface(width:79.w,height:16.h,),"25:4505":PixFlutterInterface(backgroundColor:Color.fromRGBO(143, 144, 152,1),width:12.w,height:12.w,left:0.w,top:0.h,),"25:4499":PixFlutterInterface(width:99.w,height:16.h,),"2:3268":PixFlutterInterface(left:123.w,top:13.h,),"25:4504":PixFlutterInterface(width:11.55.w,height:10.25.h,left:0.22.w,top:0.88.h,),}, true),
                            Component_25_4498({"25:4498":PixFlutterInterface(width:84.w,height:36.h,left:188.w,top:16.h,),"25:4501":PixFlutterInterface(width:42.w,height:16.h,left:0.w,top:0.h,),"25:4499":PixFlutterInterface(width:42.w,height:16.h,),"2:3268":PixFlutterInterface(left:66.w,top:13.h,),}, true),
                            Add({"23:1434":PixFlutterInterface(width:24.w,height:24.w,left:303.w,top:22.h,),"23:1435":PixFlutterInterface(width:23.w,height:23.w,left:0.5.w,top:0.5.h,),"23:1436":PixFlutterInterface(width:24.w,height:24.w,left:0.w,top:0.h,),}, true),
                          ],),),),),
                  CustomWidget_25_4726(),
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
          Component_2_1513({"2:1513":PixFlutterInterface(width:375.w,height:88.h,left:0.w,top:724.h,),"2:1520":PixFlutterInterface(width:111.67.w,height:40.h,left:16.w,top:16.h,),"2:1523":PixFlutterInterface(width:111.67.w,height:42.h,left:247.33.w,top:16.h,),"2:194":PixFlutterInterface(width:20.w,height:20.w,left:45.83.w,top:0.h,),"2:1522":PixFlutterInterface(width:44.w,height:12.h,left:33.83.w,top:28.h,text:"Tab 2",),"2:1525":PixFlutterInterface(width:28.w,height:14.h,left:22.w,top:28.h,text:"Profile",),"2:1539":PixFlutterInterface(backgroundColor:Color.fromRGBO(212, 214, 221,1),width:20.w,height:20.w,),"2:1548":PixFlutterInterface(backgroundColor:Color.fromRGBO(212, 214, 221,1),width:20.w,height:20.w,left:0.w,top:0.h,),"2:1553":PixFlutterInterface(backgroundColor:Color.fromRGBO(212, 214, 221,1),width:18.33.w,height:18.33.w,left:0.83.w,top:0.83.h,),"2:1554":PixFlutterInterface(backgroundColor:Color.fromRGBO(0, 111, 253,1),width:20.w,height:20.w,),"2:1538":PixFlutterInterface(width:20.w,height:20.w,left:0.w,top:0.h,),"2:1547":PixFlutterInterface(width:16.67.w,height:20.h,left:1.67.w,top:0.h,),}, false),
        ],),
      );
    }
}

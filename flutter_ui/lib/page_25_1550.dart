import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/components/Component_2_427.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_451.dart';
import 'package:flutter_ui/components/Component_2_441.dart';
import 'package:flutter_ui/components/Component_2_491.dart';
import 'package:flutter_ui/custom_widget/CustomWidget_25_2087.dart';
import 'package:flutter_ui/components/Component_2_1476.dart';

class page_25_1550 extends StatefulWidget {

  page_25_1550({super.key,});
  @override
  State<page_25_1550> createState() => _page_25_1550State();
}

class _page_25_1550State extends State<page_25_1550> {


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
                key: ValueKey("25:1550"),
                children: [
                  CustomWidget_25_2087(),
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

import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/components/Component_2_192.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_441.dart';
import 'package:flutter_ui/components/Component_2_491.dart';
import 'package:flutter_ui/custom_widget/CustomWidget_2_392.dart';
import 'package:flutter_ui/components/Component_2_427.dart';

class page_2_391 extends StatefulWidget {

  page_2_391({super.key,});
  @override
  State<page_2_391> createState() => _page_2_391State();
}

class _page_2_391State extends State<page_2_391> {


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
                key: ValueKey("2:391"),
                children: [
                  Component_2_192({"2:192":PixFlutterInterface(backgroundColor:Color.fromRGBO(255, 255, 255,1),width:375.w,height:812.h,left:0.w,top:0.h,),"2:200":PixFlutterInterface(left:171.5.w,top:140.h,),}, false),
                  CustomWidget_2_392(),
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

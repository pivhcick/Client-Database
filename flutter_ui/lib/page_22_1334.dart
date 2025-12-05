import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/components/Component_2_427.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_451.dart';
import 'package:flutter_ui/components/Component_2_441.dart';
import 'package:flutter_ui/components/Component_2_491.dart';
import 'package:flutter_ui/custom_widget/CustomWidget_25_2940.dart';
import 'package:flutter_ui/components/Component_2_1476.dart';
import 'package:flutter_ui/components/Component_6_3694.dart';
import 'package:flutter_ui/components/Component_6_3796.dart';

class page_22_1334 extends StatefulWidget {

  page_22_1334({super.key,});
  @override
  State<page_22_1334> createState() => _page_22_1334State();
}

class _page_22_1334State extends State<page_22_1334> {


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
                key: ValueKey("22:1334"),
                children: [
                  CustomWidget_25_2940(),
                  Component_6_3694({"6:3694":PixFlutterInterface(width:375.w,height:812.h,left:0.w,top:0.h,),}, false),
                  Component_6_3796({"6:3796":PixFlutterInterface(width:300.w,height:165.h,left:37.w,top:323.h,),"6:3798":PixFlutterInterface(textColor:Color.fromRGBO(0, 0, 0,1),width:252.w,height:17.h,),"6:3799":PixFlutterInterface(width:252.w,height:32.h,left:8.w,top:33.h,),"2:491":PixFlutterInterface(left:138.w,top:0.h,),"2:493":PixFlutterInterface(width:17.w,height:15.h,left:56.5.w,top:12.5.h,),"6:3797":PixFlutterInterface(width:268.w,height:73.h,),"6:3800":PixFlutterInterface(left:16.w,top:109.h,),"2:177":PixFlutterInterface(width:23.w,height:15.h,left:53.5.w,top:12.5.h,),}, false),
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

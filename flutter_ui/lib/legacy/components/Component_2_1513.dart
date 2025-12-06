import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_1520.dart';
import 'package:flutter_ui/components/Component_2_1523.dart';

class Component_2_1513 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1513(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1513> createState() => _Component_2_1513State();
}

class _Component_2_1513State extends State<Component_2_1513> {


  @override
  void initState() {
    super.initState();
  
  }

  PixFlutterInterface? _getPropValueById(String id) {
    return widget.datas[id];
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Visibility(
      visible: _getPropValueById('2:1513')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('2:1513')?.width ?? 423.w, minHeight: _getPropValueById('2:1513')?.height ?? 89.h),
          padding: EdgeInsets.only(left: 16.w,right: 16.w),
          decoration: BoxDecoration(color: _getPropValueById('2:1513')?.backgroundColor ?? Color.fromRGBO(255, 255, 255,1),),
          child: Row(
            key: ValueKey("2:1513"),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.w,
            children: [
              Component_2_1520({"2:1520":PixFlutterInterface(width:75.w,height:40.h,left:16.w,top:16.h,supInterface:_getPropValueById('2:1520'),),"2:1521":PixFlutterInterface(left:27.5.w,top:0.h,supInterface:_getPropValueById('2:1521'),),"2:1522":PixFlutterInterface(width:26.w,height:12.h,left:24.5.w,top:28.h,supInterface:_getPropValueById('2:1522'),),}, true),
              Component_2_1523({"2:1523":PixFlutterInterface(width:75.w,height:40.h,left:95.w,top:16.h,supInterface:_getPropValueById('2:1523'),),"2:1525":PixFlutterInterface(width:27.w,height:14.h,left:24.w,top:28.h,text:"Tab 2",supInterface:_getPropValueById('2:1525'),),"2:1524":PixFlutterInterface(left:27.5.w,top:0.h,supInterface:_getPropValueById('2:1524'),),}, true),
              Component_2_1523({"2:1523":PixFlutterInterface(width:75.w,height:40.h,left:174.w,top:16.h,supInterface:_getPropValueById('2:1523'),),"2:1525":PixFlutterInterface(width:28.w,height:14.h,left:23.5.w,top:28.h,text:"Tab 3",supInterface:_getPropValueById('2:1525'),),"2:1524":PixFlutterInterface(left:27.5.w,top:0.h,supInterface:_getPropValueById('2:1524'),),}, true),
              Component_2_1523({"2:1523":PixFlutterInterface(width:75.w,height:40.h,left:253.w,top:16.h,supInterface:_getPropValueById('2:1523'),),"2:1525":PixFlutterInterface(width:28.w,height:14.h,left:23.5.w,top:28.h,text:"Tab 4",supInterface:_getPropValueById('2:1525'),),"2:1524":PixFlutterInterface(left:27.5.w,top:0.h,supInterface:_getPropValueById('2:1524'),),}, true),
              Component_2_1523({"2:1523":PixFlutterInterface(width:75.w,height:40.h,left:332.w,top:16.h,supInterface:_getPropValueById('2:1523'),),"2:1525":PixFlutterInterface(width:28.w,height:14.h,left:23.5.w,top:28.h,text:"Tab 5",supInterface:_getPropValueById('2:1525'),),"2:1524":PixFlutterInterface(left:27.5.w,top:0.h,supInterface:_getPropValueById('2:1524'),),}, true),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1513')?.width ?? 423.w,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1513')?.width ?? 423.w,
          left: _getPropValueById('2:1513')?.left ?? 548.34.w,
          top: _getPropValueById('2:1513')?.top ?? 689.h,
          child: child
        );
  }
}

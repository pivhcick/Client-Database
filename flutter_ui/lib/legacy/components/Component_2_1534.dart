import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_963.dart';

class Component_2_1534 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1534(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1534> createState() => _Component_2_1534State();
}

class _Component_2_1534State extends State<Component_2_1534> {


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
      visible: _getPropValueById('2:1534')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('2:1534')?.width ?? 16.w, minHeight: _getPropValueById('2:1534')?.height ?? 16.h),
          padding: EdgeInsets.only(left: 4.w,right: 4.w),
          decoration: BoxDecoration(color: _getPropValueById('2:1534')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),borderRadius: _getPropValueById('2:1534')?.borderRadius ?? BorderRadius.circular(12.h),),
          child: Row(
            key: ValueKey("2:1534"),
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.w,
            children: [
              Component_2_963({"2:963":PixFlutterInterface(width:8.w,height:8.w,left:4.w,top:4.h,supInterface:_getPropValueById('2:963'),),"2:964":PixFlutterInterface(backgroundColor:Color.fromRGBO(255, 255, 255,1),width:8.w,height:5.67.h,left:0.w,top:1.36.h,supInterface:_getPropValueById('2:964'),),"2:965":PixFlutterInterface(backgroundColor:Color.fromRGBO(255, 255, 255,1),width:8.w,height:8.w,left:0.w,top:0.h,supInterface:_getPropValueById('2:965'),),}, true),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1534')?.width ?? 16.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1534')?.width ?? 16.minPx,
          left: _getPropValueById('2:1534')?.left ?? 72.w,
          top: _getPropValueById('2:1534')?.top ?? 28.h,
          child: child
        );
  }
}

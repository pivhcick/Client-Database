import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_1376 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1376(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1376> createState() => _Component_2_1376State();
}

class _Component_2_1376State extends State<Component_2_1376> {


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
      visible: _getPropValueById('2:1376')?.visible ?? true,
      child: Stack(
        key: ValueKey("2:1376"),
        clipBehavior: Clip.none,
        children: [
          Positioned(
            width: _getPropValueById('2:1377')?.width ?? 134.w,
            height: _getPropValueById('2:1377')?.height ?? 5.h,
            left: _getPropValueById('2:1377')?.left ?? 121.w,
            top: _getPropValueById('2:1377')?.top ?? 21.h,
            child: Visibility(
              visible: _getPropValueById('2:1377')?.visible ?? true,
              child: Container(
                key: ValueKey("2:1377"),
                decoration: BoxDecoration(color: _getPropValueById('2:1377')?.backgroundColor ?? Color.fromRGBO(31, 32, 36,1),borderRadius: _getPropValueById('2:1377')?.borderRadius ?? BorderRadius.circular(100.h),),),),),
        ],),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1376')?.width ?? 375.w,
          height: _getPropValueById('2:1376')?.height ?? 34.h,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1376')?.width ?? 375.w,
          height: _getPropValueById('2:1376')?.height ?? 34.h,
          left: _getPropValueById('2:1376')?.left ?? 12690.w,
          top: _getPropValueById('2:1376')?.top ?? 612.h,
          child: child
        );
  }
}

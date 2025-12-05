import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_1536 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1536(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1536> createState() => _Component_2_1536State();
}

class _Component_2_1536State extends State<Component_2_1536> {


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
      visible: _getPropValueById('2:1536')?.visible ?? true,
      child: Container(
        decoration: BoxDecoration(color: _getPropValueById('2:1536')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),borderRadius: _getPropValueById('2:1536')?.borderRadius ?? BorderRadius.circular(20.h),),
        child: Stack(
          key: ValueKey("2:1536"),
          clipBehavior: Clip.none,),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1536')?.width ?? 16.minPx,
          height: _getPropValueById('2:1536')?.height ?? 16.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1536')?.width ?? 16.minPx,
          height: _getPropValueById('2:1536')?.height ?? 16.minPx,
          left: _getPropValueById('2:1536')?.left ?? 112.w,
          top: _getPropValueById('2:1536')?.top ?? 28.h,
          child: child
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_3290 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_3290(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_3290> createState() => _Component_2_3290State();
}

class _Component_2_3290State extends State<Component_2_3290> {


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
      visible: _getPropValueById('2:3290')?.visible ?? true,
      child: Stack(
        key: ValueKey("2:3290"),
        clipBehavior: Clip.none,
        children: [
          Positioned(
            width: 96.w,
            height: 96.h,
            left: 0.w,
            top: 0.h,
            child: Image(
              key: ValueKey("2:3291"),
              image: AssetImage("assets/images/Ellipse_2_3291.png"),),),
        ],),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:3290')?.width ?? 96.minPx,
          height: _getPropValueById('2:3290')?.height ?? 96.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:3290')?.width ?? 96.minPx,
          height: _getPropValueById('2:3290')?.height ?? 96.minPx,
          left: _getPropValueById('2:3290')?.left ?? 3801.w,
          top: _getPropValueById('2:3290')?.top ?? 170.h,
          child: child
        );
  }
}

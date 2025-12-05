import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_6_3694 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_6_3694(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_6_3694> createState() => _Component_6_3694State();
}

class _Component_6_3694State extends State<Component_6_3694> {


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
      visible: _getPropValueById('6:3694')?.visible ?? true,
      child: Container(
        decoration: BoxDecoration(color: _getPropValueById('6:3694')?.backgroundColor ?? Color.fromRGBO(31, 32, 36,1),),
        clipBehavior: Clip.hardEdge,
        child: Opacity(
          opacity: _getPropValueById('6:3694')?.opacity ?? 0.85,
          child: Stack(
            key: ValueKey("6:3694"),),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('6:3694')?.width ?? 255.w,
          height: _getPropValueById('6:3694')?.height ?? 478.h,
          child: child
        )
      : Positioned(
          width: _getPropValueById('6:3694')?.width ?? 255.w,
          height: _getPropValueById('6:3694')?.height ?? 478.h,
          left: _getPropValueById('6:3694')?.left ?? 12285.87.w,
          top: _getPropValueById('6:3694')?.top ?? 538.h,
          child: child
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_25_3671 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_25_3671(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_25_3671> createState() => _Component_25_3671State();
}

class _Component_25_3671State extends State<Component_25_3671> {


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
      visible: _getPropValueById('25:3671')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("25:3671"),
          children: [
            Positioned(
              width: 22.25.w,
              height: 22.25.h,
              left: 0.75.w,
              top: 1.h,
              child: Image(
                key: ValueKey("25:3672"),
                image: AssetImage("assets/images/Vector_25_3672.png"),),),
            Positioned(
              width: _getPropValueById('25:3673')?.width ?? 24.minPx,
              height: _getPropValueById('25:3673')?.height ?? 24.minPx,
              left: _getPropValueById('25:3673')?.left ?? 0.w,
              top: _getPropValueById('25:3673')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('25:3673')?.visible ?? true,
                child: Container(
                  key: ValueKey("25:3673"),
                  decoration: BoxDecoration(color: _getPropValueById('25:3673')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('25:3671')?.width ?? 24.minPx,
          height: _getPropValueById('25:3671')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('25:3671')?.width ?? 24.minPx,
          height: _getPropValueById('25:3671')?.height ?? 24.minPx,
          left: _getPropValueById('25:3671')?.left ?? -11743.36.w,
          top: _getPropValueById('25:3671')?.top ?? 498.h,
          child: child
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_25_7050 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_25_7050(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_25_7050> createState() => _Component_25_7050State();
}

class _Component_25_7050State extends State<Component_25_7050> {


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
      visible: _getPropValueById('25:7050')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("25:7050"),
          children: [
            Positioned(
              width: 24.w,
              height: 20.92.h,
              left: 0.w,
              top: 1.54.h,
              child: Image(
                key: ValueKey("25:7051"),
                image: AssetImage("assets/images/Vector_25_7051.png"),),),
            Positioned(
              width: _getPropValueById('25:7052')?.width ?? 24.minPx,
              height: _getPropValueById('25:7052')?.height ?? 24.minPx,
              left: _getPropValueById('25:7052')?.left ?? 0.w,
              top: _getPropValueById('25:7052')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('25:7052')?.visible ?? true,
                child: Container(
                  key: ValueKey("25:7052"),
                  decoration: BoxDecoration(color: _getPropValueById('25:7052')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('25:7050')?.width ?? 24.minPx,
          height: _getPropValueById('25:7050')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('25:7050')?.width ?? 24.minPx,
          height: _getPropValueById('25:7050')?.height ?? 24.minPx,
          left: _getPropValueById('25:7050')?.left ?? 0.w,
          top: _getPropValueById('25:7050')?.top ?? 0.h,
          child: child
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_25_4503 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_25_4503(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_25_4503> createState() => _Component_25_4503State();
}

class _Component_25_4503State extends State<Component_25_4503> {


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
      visible: _getPropValueById('25:4503')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("25:4503"),
          children: [
            Positioned(
              width: 23.11.w,
              height: 20.5.h,
              left: 0.45.w,
              top: 1.75.h,
              child: Image(
                key: ValueKey("25:4504"),
                image: AssetImage("assets/images/Vector_25_4504.png"),),),
            Positioned(
              width: _getPropValueById('25:4505')?.width ?? 24.minPx,
              height: _getPropValueById('25:4505')?.height ?? 24.minPx,
              left: _getPropValueById('25:4505')?.left ?? 0.w,
              top: _getPropValueById('25:4505')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('25:4505')?.visible ?? true,
                child: Container(
                  key: ValueKey("25:4505"),
                  decoration: BoxDecoration(color: _getPropValueById('25:4505')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('25:4503')?.width ?? 24.minPx,
          height: _getPropValueById('25:4503')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('25:4503')?.width ?? 24.minPx,
          height: _getPropValueById('25:4503')?.height ?? 24.minPx,
          left: _getPropValueById('25:4503')?.left ?? -11671.36.w,
          top: _getPropValueById('25:4503')?.top ?? 570.h,
          child: child
        );
  }
}

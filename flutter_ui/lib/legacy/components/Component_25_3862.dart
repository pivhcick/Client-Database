import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_25_3862 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_25_3862(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_25_3862> createState() => _Component_25_3862State();
}

class _Component_25_3862State extends State<Component_25_3862> {


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
      visible: _getPropValueById('25:3862')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("25:3862"),
          children: [
            Positioned(
              width: _getPropValueById('25:3863')?.width ?? 22.minPx,
              height: _getPropValueById('25:3863')?.height ?? 22.minPx,
              left: _getPropValueById('25:3863')?.left ?? 1.w,
              top: _getPropValueById('25:3863')?.top ?? 1.h,
              child: Visibility(
                visible: _getPropValueById('25:3863')?.visible ?? true,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(),
                  child: Stack(
                    key: ValueKey("25:3863"),
                    children: [
                      Positioned(
                        width: 22.w,
                        height: 22.h,
                        left: 0.w,
                        top: 0.h,
                        child: Image(
                          key: ValueKey("25:3864"),
                          image: AssetImage("assets/images/Ellipse_25_3864.png"),),),
                      Positioned(
                        width: _getPropValueById('25:3865')?.width ?? 24.minPx,
                        height: _getPropValueById('25:3865')?.height ?? 24.minPx,
                        left: _getPropValueById('25:3865')?.left ?? -1.w,
                        top: _getPropValueById('25:3865')?.top ?? -1.h,
                        child: Visibility(
                          visible: _getPropValueById('25:3865')?.visible ?? true,
                          child: Container(
                            key: ValueKey("25:3865"),
                            decoration: BoxDecoration(color: _getPropValueById('25:3865')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
                    ],),),),),
            Positioned(
              width: 2.74.w,
              height: 12.11.h,
              left: 10.63.w,
              top: 5.94.h,
              child: Image(
                key: ValueKey("25:3866"),
                image: AssetImage("assets/images/Vector_25_3866.png"),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('25:3862')?.width ?? 24.minPx,
          height: _getPropValueById('25:3862')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('25:3862')?.width ?? 24.minPx,
          height: _getPropValueById('25:3862')?.height ?? 24.minPx,
          left: _getPropValueById('25:3862')?.left ?? -11959.36.w,
          top: _getPropValueById('25:3862')?.top ?? 498.h,
          child: child
        );
  }
}

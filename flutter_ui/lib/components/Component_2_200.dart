import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_200 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_200(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_200> createState() => _Component_2_200State();
}

class _Component_2_200State extends State<Component_2_200> {


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
      visible: _getPropValueById('2:200')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("2:200"),
          children: [
            Positioned(
              width: 24.w,
              height: 20.h,
              left: 0.w,
              top: 2.h,
              child: Image(
                key: ValueKey("2:201"),
                image: AssetImage("assets/images/Vector_2_201.png"),),),
            Positioned(
              width: _getPropValueById('2:202')?.width ?? 24.minPx,
              height: _getPropValueById('2:202')?.height ?? 24.minPx,
              left: _getPropValueById('2:202')?.left ?? 0.w,
              top: _getPropValueById('2:202')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('2:202')?.visible ?? true,
                child: Container(
                  key: ValueKey("2:202"),
                  decoration: BoxDecoration(color: _getPropValueById('2:202')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:200')?.width ?? 24.minPx,
          height: _getPropValueById('2:200')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:200')?.width ?? 24.minPx,
          height: _getPropValueById('2:200')?.height ?? 24.minPx,
          left: _getPropValueById('2:200')?.left ?? -12103.36.w,
          top: _getPropValueById('2:200')?.top ?? 282.h,
          child: child
        );
  }
}

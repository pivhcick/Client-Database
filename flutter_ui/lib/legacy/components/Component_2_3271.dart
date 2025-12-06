import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_3271 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_3271(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_3271> createState() => _Component_2_3271State();
}

class _Component_2_3271State extends State<Component_2_3271> {


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
      visible: _getPropValueById('2:3271')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("2:3271"),
          children: [
            Positioned(
              width: 20.w,
              height: 18.2.h,
              left: 2.w,
              top: 3.h,
              child: Image(
                key: ValueKey("2:3272"),
                image: AssetImage("assets/images/Vector_2_3272.png"),),),
            Positioned(
              width: _getPropValueById('2:3273')?.width ?? 24.minPx,
              height: _getPropValueById('2:3273')?.height ?? 24.minPx,
              left: _getPropValueById('2:3273')?.left ?? 0.w,
              top: _getPropValueById('2:3273')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('2:3273')?.visible ?? true,
                child: Container(
                  key: ValueKey("2:3273"),
                  decoration: BoxDecoration(color: _getPropValueById('2:3273')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:3271')?.width ?? 24.minPx,
          height: _getPropValueById('2:3271')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:3271')?.width ?? 24.minPx,
          height: _getPropValueById('2:3271')?.height ?? 24.minPx,
          left: _getPropValueById('2:3271')?.left ?? -11743.36.w,
          top: _getPropValueById('2:3271')?.top ?? 570.h,
          child: child
        );
  }
}

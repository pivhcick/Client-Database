import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_3268 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_3268(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_3268> createState() => _Component_2_3268State();
}

class _Component_2_3268State extends State<Component_2_3268> {


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
      visible: _getPropValueById('2:3268')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("2:3268"),
          children: [
            Positioned(
              width: 23.w,
              height: 14.h,
              left: 23.5.w,
              top: 19.h,
              child: Image(
                key: ValueKey("2:3269"),
                image: AssetImage("assets/images/Vector_2_3269.png"),),),
            Positioned(
              width: _getPropValueById('2:3270')?.width ?? 24.minPx,
              height: _getPropValueById('2:3270')?.height ?? 24.minPx,
              left: _getPropValueById('2:3270')?.left ?? 0.w,
              top: _getPropValueById('2:3270')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('2:3270')?.visible ?? true,
                child: Container(
                  key: ValueKey("2:3270"),
                  decoration: BoxDecoration(color: _getPropValueById('2:3270')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:3268')?.width ?? 24.minPx,
          height: _getPropValueById('2:3268')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:3268')?.width ?? 24.minPx,
          height: _getPropValueById('2:3268')?.height ?? 24.minPx,
          left: _getPropValueById('2:3268')?.left ?? -12031.36.w,
          top: _getPropValueById('2:3268')?.top ?? 354.h,
          child: child
        );
  }
}

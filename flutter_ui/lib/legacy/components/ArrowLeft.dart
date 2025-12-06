import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class ArrowLeft extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  ArrowLeft(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<ArrowLeft> createState() => _ArrowLeftState();
}

class _ArrowLeftState extends State<ArrowLeft> {


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
      visible: _getPropValueById('2:1540')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("2:1540"),
          children: [
            Positioned(
              width: 14.w,
              height: 23.h,
              left: 5.w,
              top: 0.5.h,
              child: Image(
                key: ValueKey("2:1541"),
                image: AssetImage("assets/images/Vector_2_1541.png"),),),
            Positioned(
              width: _getPropValueById('2:1542')?.width ?? 24.minPx,
              height: _getPropValueById('2:1542')?.height ?? 24.minPx,
              left: _getPropValueById('2:1542')?.left ?? 0.w,
              top: _getPropValueById('2:1542')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('2:1542')?.visible ?? true,
                child: Container(
                  key: ValueKey("2:1542"),
                  decoration: BoxDecoration(color: _getPropValueById('2:1542')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1540')?.width ?? 24.minPx,
          height: _getPropValueById('2:1540')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1540')?.width ?? 24.minPx,
          height: _getPropValueById('2:1540')?.height ?? 24.minPx,
          left: _getPropValueById('2:1540')?.left ?? -12175.36.w,
          top: _getPropValueById('2:1540')?.top ?? 354.h,
          child: child
        );
  }
}

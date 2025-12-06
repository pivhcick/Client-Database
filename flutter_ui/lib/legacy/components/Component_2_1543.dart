import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_1543 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1543(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1543> createState() => _Component_2_1543State();
}

class _Component_2_1543State extends State<Component_2_1543> {


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
      visible: _getPropValueById('2:1543')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("2:1543"),
          children: [
            Positioned(
              width: 23.5.w,
              height: 21.23.h,
              left: 0.25.w,
              top: 1.39.h,
              child: Image(
                key: ValueKey("2:1544"),
                image: AssetImage("assets/images/Vector_2_1544.png"),),),
            Positioned(
              width: _getPropValueById('2:1545')?.width ?? 24.minPx,
              height: _getPropValueById('2:1545')?.height ?? 24.minPx,
              left: _getPropValueById('2:1545')?.left ?? 0.w,
              top: _getPropValueById('2:1545')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('2:1545')?.visible ?? true,
                child: Container(
                  key: ValueKey("2:1545"),
                  decoration: BoxDecoration(color: _getPropValueById('2:1545')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1543')?.width ?? 24.minPx,
          height: _getPropValueById('2:1543')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1543')?.width ?? 24.minPx,
          height: _getPropValueById('2:1543')?.height ?? 24.minPx,
          left: _getPropValueById('2:1543')?.left ?? -12175.36.w,
          top: _getPropValueById('2:1543')?.top ?? 426.h,
          child: child
        );
  }
}

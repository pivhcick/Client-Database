import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_504 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_504(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_504> createState() => _Component_2_504State();
}

class _Component_2_504State extends State<Component_2_504> {


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
      visible: _getPropValueById('2:504')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("2:504"),
          children: [
            Positioned(
              width: 24.w,
              height: 20.5.h,
              left: 0.w,
              top: 1.75.h,
              child: Image(
                key: ValueKey("2:505"),
                image: AssetImage("assets/images/Boolean_operation_2_505.png"),),),
            Positioned(
              width: _getPropValueById('2:510')?.width ?? 24.minPx,
              height: _getPropValueById('2:510')?.height ?? 24.minPx,
              left: _getPropValueById('2:510')?.left ?? 0.w,
              top: _getPropValueById('2:510')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('2:510')?.visible ?? true,
                child: Container(
                  key: ValueKey("2:510"),
                  decoration: BoxDecoration(color: _getPropValueById('2:510')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:504')?.width ?? 24.minPx,
          height: _getPropValueById('2:504')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:504')?.width ?? 24.minPx,
          height: _getPropValueById('2:504')?.height ?? 24.minPx,
          left: _getPropValueById('2:504')?.left ?? -11887.36.w,
          top: _getPropValueById('2:504')?.top ?? 426.h,
          child: child
        );
  }
}

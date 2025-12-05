import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_1552 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1552(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1552> createState() => _Component_2_1552State();
}

class _Component_2_1552State extends State<Component_2_1552> {


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
      visible: _getPropValueById('2:1552')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("2:1552"),
          children: [
            Positioned(
              width: 22.w,
              height: 22.h,
              left: 1.w,
              top: 1.h,
              child: Image(
                key: ValueKey("2:1553"),
                image: AssetImage("assets/images/Vector_2_1553.png"),),),
            Positioned(
              width: _getPropValueById('2:1554')?.width ?? 24.minPx,
              height: _getPropValueById('2:1554')?.height ?? 24.minPx,
              left: _getPropValueById('2:1554')?.left ?? 0.w,
              top: _getPropValueById('2:1554')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('2:1554')?.visible ?? true,
                child: Container(
                  key: ValueKey("2:1554"),
                  decoration: BoxDecoration(color: _getPropValueById('2:1554')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1552')?.width ?? 24.minPx,
          height: _getPropValueById('2:1552')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1552')?.width ?? 24.minPx,
          height: _getPropValueById('2:1552')?.height ?? 24.minPx,
          left: _getPropValueById('2:1552')?.left ?? -11671.36.w,
          top: _getPropValueById('2:1552')?.top ?? 498.h,
          child: child
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_963 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_963(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_963> createState() => _Component_2_963State();
}

class _Component_2_963State extends State<Component_2_963> {


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
      visible: _getPropValueById('2:963')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("2:963"),
          children: [
            Positioned(
              width: 24.w,
              height: 17.h,
              left: 0.w,
              top: 4.09.h,
              child: Image(
                key: ValueKey("2:964"),
                image: AssetImage("assets/images/Vector_2_964.png"),),),
            Positioned(
              width: _getPropValueById('2:965')?.width ?? 24.minPx,
              height: _getPropValueById('2:965')?.height ?? 24.minPx,
              left: _getPropValueById('2:965')?.left ?? 0.w,
              top: _getPropValueById('2:965')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('2:965')?.visible ?? true,
                child: Container(
                  key: ValueKey("2:965"),
                  decoration: BoxDecoration(color: _getPropValueById('2:965')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:963')?.width ?? 24.minPx,
          height: _getPropValueById('2:963')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:963')?.width ?? 24.minPx,
          height: _getPropValueById('2:963')?.height ?? 24.minPx,
          left: _getPropValueById('2:963')?.left ?? -11671.36.w,
          top: _getPropValueById('2:963')?.top ?? 354.h,
          child: child
        );
  }
}

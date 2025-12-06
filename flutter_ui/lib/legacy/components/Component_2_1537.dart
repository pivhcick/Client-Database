import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_1537 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1537(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1537> createState() => _Component_2_1537State();
}

class _Component_2_1537State extends State<Component_2_1537> {


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
      visible: _getPropValueById('2:1537')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("2:1537"),
          children: [
            Positioned(
              width: 24.w,
              height: 24.h,
              left: 0.w,
              top: 0.h,
              child: Image(
                key: ValueKey("2:1538"),
                image: AssetImage("assets/images/Vector_2_1538.png"),),),
            Positioned(
              width: _getPropValueById('2:1539')?.width ?? 24.minPx,
              height: _getPropValueById('2:1539')?.height ?? 24.minPx,
              left: _getPropValueById('2:1539')?.left ?? 0.w,
              top: _getPropValueById('2:1539')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('2:1539')?.visible ?? true,
                child: Container(
                  key: ValueKey("2:1539"),
                  decoration: BoxDecoration(color: _getPropValueById('2:1539')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1537')?.width ?? 24.minPx,
          height: _getPropValueById('2:1537')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1537')?.width ?? 24.minPx,
          height: _getPropValueById('2:1537')?.height ?? 24.minPx,
          left: _getPropValueById('2:1537')?.left ?? -11743.36.w,
          top: _getPropValueById('2:1537')?.top ?? 282.h,
          child: child
        );
  }
}

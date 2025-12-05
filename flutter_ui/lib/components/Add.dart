import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Add extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Add(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {


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
      visible: _getPropValueById('23:1434')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("23:1434"),
          children: [
            Positioned(
              width: 23.w,
              height: 23.h,
              left: 0.5.w,
              top: 0.5.h,
              child: Image(
                key: ValueKey("23:1435"),
                image: AssetImage("assets/images/Vector_23_1435.png"),),),
            Positioned(
              width: _getPropValueById('23:1436')?.width ?? 24.minPx,
              height: _getPropValueById('23:1436')?.height ?? 24.minPx,
              left: _getPropValueById('23:1436')?.left ?? 0.w,
              top: _getPropValueById('23:1436')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('23:1436')?.visible ?? true,
                child: Container(
                  key: ValueKey("23:1436"),
                  decoration: BoxDecoration(color: _getPropValueById('23:1436')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('23:1434')?.width ?? 24.minPx,
          height: _getPropValueById('23:1434')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('23:1434')?.width ?? 24.minPx,
          height: _getPropValueById('23:1434')?.height ?? 24.minPx,
          left: _getPropValueById('23:1434')?.left ?? -11815.36.w,
          top: _getPropValueById('23:1434')?.top ?? 354.h,
          child: child
        );
  }
}

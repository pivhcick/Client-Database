import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class ArrowRight0 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  ArrowRight0(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<ArrowRight0> createState() => _ArrowRight0State();
}

class _ArrowRight0State extends State<ArrowRight0> {


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
      visible: _getPropValueById('2:197')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("2:197"),
          children: [
            Positioned(
              width: 14.w,
              height: 23.h,
              left: 19.w,
              top: 0.5.h,
              child: Image(
                key: ValueKey("2:198"),
                image: AssetImage("assets/images/Vector_2_198.png"),),),
            Positioned(
              width: _getPropValueById('2:199')?.width ?? 24.minPx,
              height: _getPropValueById('2:199')?.height ?? 24.minPx,
              left: _getPropValueById('2:199')?.left ?? 0.w,
              top: _getPropValueById('2:199')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('2:199')?.visible ?? true,
                child: Container(
                  key: ValueKey("2:199"),
                  decoration: BoxDecoration(color: _getPropValueById('2:199')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:197')?.width ?? 24.minPx,
          height: _getPropValueById('2:197')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:197')?.width ?? 24.minPx,
          height: _getPropValueById('2:197')?.height ?? 24.minPx,
          left: _getPropValueById('2:197')?.left ?? -12103.36.w,
          top: _getPropValueById('2:197')?.top ?? 354.h,
          child: child
        );
  }
}

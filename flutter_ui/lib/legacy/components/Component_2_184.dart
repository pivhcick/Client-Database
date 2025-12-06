import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_184 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_184(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_184> createState() => _Component_2_184State();
}

class _Component_2_184State extends State<Component_2_184> {


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
      visible: _getPropValueById('2:184')?.visible ?? true,
      child: Container(
        decoration: BoxDecoration(color: _getPropValueById('2:184')?.backgroundColor ?? Color.fromRGBO(234, 242, 255,1),borderRadius: _getPropValueById('2:184')?.borderRadius ?? BorderRadius.circular(20.h),),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          key: ValueKey("2:184"),
          children: [
            Positioned(
              width: _getPropValueById('2:185')?.width ?? 40.w,
              height: _getPropValueById('2:185')?.height ?? 65.h,
              left: _getPropValueById('2:185')?.left ?? 8.w,
              top: _getPropValueById('2:185')?.top ?? 10.h,
              child: Visibility(
                visible: _getPropValueById('2:185')?.visible ?? true,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(),
                  child: Stack(
                    key: ValueKey("2:185"),
                    children: [
                      Positioned(
                        width: 40.w,
                        height: 40.h,
                        left: 0.w,
                        top: 25.h,
                        child: Image(
                          key: ValueKey("2:186"),
                          image: AssetImage("assets/images/Vector_2_186.png"),),),
                      Positioned(
                        width: 22.w,
                        height: 22.h,
                        left: 9.w,
                        top: 0.h,
                        child: Image(
                          key: ValueKey("2:187"),
                          image: AssetImage("assets/images/Ellipse_2_187.png"),),),
                    ],),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:184')?.width ?? 56.minPx,
          height: _getPropValueById('2:184')?.height ?? 56.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:184')?.width ?? 56.minPx,
          height: _getPropValueById('2:184')?.height ?? 56.minPx,
          left: _getPropValueById('2:184')?.left ?? 36.w,
          top: _getPropValueById('2:184')?.top ?? 87.h,
          child: child
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Size3 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Size3(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Size3> createState() => _Size3State();
}

class _Size3State extends State<Size3> {


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
      visible: _getPropValueById('2:188')?.visible ?? true,
      child: Container(
        decoration: BoxDecoration(color: _getPropValueById('2:188')?.backgroundColor ?? Color.fromRGBO(234, 242, 255,1),borderRadius: _getPropValueById('2:188')?.borderRadius ?? BorderRadius.circular(32.h),),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          key: ValueKey("2:188"),
          children: [
            Positioned(
              width: _getPropValueById('2:189')?.width ?? 60.w,
              height: _getPropValueById('2:189')?.height ?? 97.76.h,
              left: _getPropValueById('2:189')?.left ?? 10.w,
              top: _getPropValueById('2:189')?.top ?? 12.h,
              child: Visibility(
                visible: _getPropValueById('2:189')?.visible ?? true,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(),
                  child: Stack(
                    key: ValueKey("2:189"),
                    children: [
                      Positioned(
                        width: 60.w,
                        height: 60.h,
                        left: 0.w,
                        top: 37.76.h,
                        child: Image(
                          key: ValueKey("2:190"),
                          image: AssetImage("assets/images/Vector_2_190.png"),),),
                      Positioned(
                        width: 32.w,
                        height: 32.h,
                        left: 14.w,
                        top: 0.h,
                        child: Image(
                          key: ValueKey("2:191"),
                          image: AssetImage("assets/images/Ellipse_2_191.png"),),),
                    ],),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:188')?.width ?? 80.minPx,
          height: _getPropValueById('2:188')?.height ?? 80.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:188')?.width ?? 80.minPx,
          height: _getPropValueById('2:188')?.height ?? 80.minPx,
          left: _getPropValueById('2:188')?.left ?? 24.w,
          top: _getPropValueById('2:188')?.top ?? 167.h,
          child: child
        );
  }
}

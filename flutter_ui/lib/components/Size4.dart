import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Size4 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Size4(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Size4> createState() => _Size4State();
}

class _Size4State extends State<Size4> {


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
      visible: _getPropValueById('2:180')?.visible ?? true,
      child: Container(
        decoration: BoxDecoration(color: _getPropValueById('2:180')?.backgroundColor ?? Color.fromRGBO(234, 242, 255,1),borderRadius: _getPropValueById('2:180')?.borderRadius ?? BorderRadius.circular(16.h),),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          key: ValueKey("2:180"),
          children: [
            Positioned(
              width: _getPropValueById('2:181')?.width ?? 24.w,
              height: _getPropValueById('2:181')?.height ?? 42.h,
              left: _getPropValueById('2:181')?.left ?? 8.w,
              top: _getPropValueById('2:181')?.top ?? 8.h,
              child: Visibility(
                visible: _getPropValueById('2:181')?.visible ?? true,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(),
                  child: Stack(
                    key: ValueKey("2:181"),
                    children: [
                      Positioned(
                        width: 24.w,
                        height: 24.h,
                        left: 0.w,
                        top: 18.h,
                        child: Image(
                          key: ValueKey("2:182"),
                          image: AssetImage("assets/images/Vector_2_182.png"),),),
                      Positioned(
                        width: 16.w,
                        height: 16.h,
                        left: 4.36.w,
                        top: 0.h,
                        child: Image(
                          key: ValueKey("2:183"),
                          image: AssetImage("assets/images/Ellipse_2_183.png"),),),
                    ],),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:180')?.width ?? 40.minPx,
          height: _getPropValueById('2:180')?.height ?? 40.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:180')?.width ?? 40.minPx,
          height: _getPropValueById('2:180')?.height ?? 40.minPx,
          left: _getPropValueById('2:180')?.left ?? 44.w,
          top: _getPropValueById('2:180')?.top ?? 23.h,
          child: child
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_1499 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1499(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1499> createState() => _Component_2_1499State();
}

class _Component_2_1499State extends State<Component_2_1499> {


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
      visible: _getPropValueById('2:1499')?.visible ?? true,
      child: Container(
        decoration: BoxDecoration(color: _getPropValueById('2:1499')?.backgroundColor ?? Color.fromRGBO(255, 255, 255,1),),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          key: ValueKey("2:1499"),
          children: [
            Positioned(
              left: _getPropValueById('2:1500')?.left ?? 153.5.w,
              top: _getPropValueById('2:1500')?.top ?? 19.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1500')?.visible ?? true,
                child: Text(_getPropValueById('2:1500')?.text ?? "Page Title",
                  key: ValueKey("2:1500"),
                  textAlign: _getPropValueById('2:1500')?.textAlign ?? TextAlign.center,
                  style: TextStyle(color: _getPropValueById('2:1500')?.textGradient == null? _getPropValueById('2:1500')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:1500')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1500')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1500')?.left ?? 153.5.w, _getPropValueById('2:1500')?.top ?? 19.5.h, _getPropValueById('2:1500')?.width ?? 69.w, _getPropValueById('2:1500')?.height ?? 17.h))): null, fontFamily: _getPropValueById('2:1500')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1500')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1500')?.fontSize ?? 13.5.sp, letterSpacing: _getPropValueById('2:1500')?.letterSpacing ?? 0.w),),),),
            Positioned(
              left: _getPropValueById('2:1501')?.left ?? 24.w,
              top: _getPropValueById('2:1501')?.top ?? 20.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1501')?.visible ?? true,
                child: Text(_getPropValueById('2:1501')?.text ?? "Cancel",
                  key: ValueKey("2:1501"),
                  style: TextStyle(color: _getPropValueById('2:1501')?.textGradient == null? _getPropValueById('2:1501')?.textColor ?? Color.fromRGBO(0, 111, 253,1): null, foreground: _getPropValueById('2:1501')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1501')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1501')?.left ?? 24.w, _getPropValueById('2:1501')?.top ?? 20.5.h, _getPropValueById('2:1501')?.width ?? 41.w, _getPropValueById('2:1501')?.height ?? 15.h))): null, fontFamily: _getPropValueById('2:1501')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1501')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1501')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('2:1501')?.letterSpacing ?? 0.w),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1499')?.width ?? 375.w,
          height: _getPropValueById('2:1499')?.height ?? 56.h,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1499')?.width ?? 375.w,
          height: _getPropValueById('2:1499')?.height ?? 56.h,
          left: _getPropValueById('2:1499')?.left ?? 24.w,
          top: _getPropValueById('2:1499')?.top ?? 584.h,
          child: child
        );
  }
}

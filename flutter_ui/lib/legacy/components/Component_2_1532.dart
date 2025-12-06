import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'dart:math';

class Component_2_1532 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1532(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1532> createState() => _Component_2_1532State();
}

class _Component_2_1532State extends State<Component_2_1532> {


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
      visible: _getPropValueById('2:1532')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('2:1532')?.width ?? 24.w, minHeight: _getPropValueById('2:1532')?.height ?? 24.h),
          padding: EdgeInsets.only(left: 6.w,right: 6.w, top: 6.h,bottom: 6.h),
          decoration: BoxDecoration(color: _getPropValueById('2:1532')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),borderRadius: _getPropValueById('2:1532')?.borderRadius ?? BorderRadius.circular(20.h),),
          child: Column(
            key: ValueKey("2:1532"),
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10.h,
            children: [
              Visibility(
                visible: _getPropValueById('2:1533')?.visible ?? true,
                child: Text(_getPropValueById('2:1533')?.text ?? "9",
                  key: ValueKey("2:1533"),
                  textAlign: _getPropValueById('2:1533')?.textAlign ?? TextAlign.center,
                  style: TextStyle(color: _getPropValueById('2:1533')?.textGradient == null? _getPropValueById('2:1533')?.textColor ?? Color.fromRGBO(255, 255, 255,1): null, foreground: _getPropValueById('2:1533')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1533')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1533')?.left ?? 8.5.w, _getPropValueById('2:1533')?.top ?? 6.h, _getPropValueById('2:1533')?.width ?? 7.w, _getPropValueById('2:1533')?.height ?? 12.h))): null, fontFamily: _getPropValueById('2:1533')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1533')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1533')?.fontSize ?? 9.5.sp, letterSpacing: _getPropValueById('2:1533')?.letterSpacing ?? 0.5000000074505806.w),),),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          height: _getPropValueById('2:1532')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          height: _getPropValueById('2:1532')?.height ?? 24.minPx,
          left: _getPropValueById('2:1532')?.left ?? 24.w,
          top: _getPropValueById('2:1532')?.top ?? 24.h,
          child: child
        );
  }
}

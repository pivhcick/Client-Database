import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Size.dart';

class Component_2_1508 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1508(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1508> createState() => _Component_2_1508State();
}

class _Component_2_1508State extends State<Component_2_1508> {


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
      visible: _getPropValueById('2:1508')?.visible ?? true,
      child: Container(
        decoration: BoxDecoration(color: _getPropValueById('2:1508')?.backgroundColor ?? Color.fromRGBO(255, 255, 255,1),),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          key: ValueKey("2:1508"),
          children: [
            Positioned(
              left: _getPropValueById('2:1509')?.left ?? 153.5.w,
              top: _getPropValueById('2:1509')?.top ?? 19.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1509')?.visible ?? true,
                child: Text(_getPropValueById('2:1509')?.text ?? "Page Title",
                  key: ValueKey("2:1509"),
                  textAlign: _getPropValueById('2:1509')?.textAlign ?? TextAlign.center,
                  style: TextStyle(color: _getPropValueById('2:1509')?.textGradient == null? _getPropValueById('2:1509')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:1509')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1509')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1509')?.left ?? 153.5.w, _getPropValueById('2:1509')?.top ?? 19.5.h, _getPropValueById('2:1509')?.width ?? 69.w, _getPropValueById('2:1509')?.height ?? 17.h))): null, fontFamily: _getPropValueById('2:1509')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1509')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1509')?.fontSize ?? 13.5.sp, letterSpacing: _getPropValueById('2:1509')?.letterSpacing ?? 0.w),),),),
            Size({"2:180":PixFlutterInterface(width:40.w,height:40.w,left:319.w,top:8.h,supInterface:_getPropValueById('2:180'),),}, false),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1508')?.width ?? 375.w,
          height: _getPropValueById('2:1508')?.height ?? 56.h,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1508')?.width ?? 375.w,
          height: _getPropValueById('2:1508')?.height ?? 56.h,
          left: _getPropValueById('2:1508')?.left ?? 24.w,
          top: _getPropValueById('2:1508')?.top ?? 824.h,
          child: child
        );
  }
}

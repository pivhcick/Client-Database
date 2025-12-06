import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Size.dart';

class Component_2_1495 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1495(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1495> createState() => _Component_2_1495State();
}

class _Component_2_1495State extends State<Component_2_1495> {


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
      visible: _getPropValueById('2:1495')?.visible ?? true,
      child: Container(
        decoration: BoxDecoration(color: _getPropValueById('2:1495')?.backgroundColor ?? Color.fromRGBO(255, 255, 255,1),),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          key: ValueKey("2:1495"),
          children: [
            Positioned(
              left: _getPropValueById('2:1496')?.left ?? 153.5.w,
              top: _getPropValueById('2:1496')?.top ?? 19.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1496')?.visible ?? true,
                child: Text(_getPropValueById('2:1496')?.text ?? "Page Title",
                  key: ValueKey("2:1496"),
                  textAlign: _getPropValueById('2:1496')?.textAlign ?? TextAlign.center,
                  style: TextStyle(color: _getPropValueById('2:1496')?.textGradient == null? _getPropValueById('2:1496')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:1496')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1496')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1496')?.left ?? 153.5.w, _getPropValueById('2:1496')?.top ?? 19.5.h, _getPropValueById('2:1496')?.width ?? 69.w, _getPropValueById('2:1496')?.height ?? 17.h))): null, fontFamily: _getPropValueById('2:1496')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1496')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1496')?.fontSize ?? 13.5.sp, letterSpacing: _getPropValueById('2:1496')?.letterSpacing ?? 0.w),),),),
            Positioned(
              left: _getPropValueById('2:1497')?.left ?? 24.w,
              top: _getPropValueById('2:1497')?.top ?? 20.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1497')?.visible ?? true,
                child: Text(_getPropValueById('2:1497')?.text ?? "Cancel",
                  key: ValueKey("2:1497"),
                  style: TextStyle(color: _getPropValueById('2:1497')?.textGradient == null? _getPropValueById('2:1497')?.textColor ?? Color.fromRGBO(0, 111, 253,1): null, foreground: _getPropValueById('2:1497')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1497')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1497')?.left ?? 24.w, _getPropValueById('2:1497')?.top ?? 20.5.h, _getPropValueById('2:1497')?.width ?? 41.w, _getPropValueById('2:1497')?.height ?? 15.h))): null, fontFamily: _getPropValueById('2:1497')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1497')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1497')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('2:1497')?.letterSpacing ?? 0.w),),),),
            Size({"2:180":PixFlutterInterface(width:40.w,height:40.w,left:319.w,top:8.h,supInterface:_getPropValueById('2:180'),),}, false),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1495')?.width ?? 375.w,
          height: _getPropValueById('2:1495')?.height ?? 56.h,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1495')?.width ?? 375.w,
          height: _getPropValueById('2:1495')?.height ?? 56.h,
          left: _getPropValueById('2:1495')?.left ?? 24.w,
          top: _getPropValueById('2:1495')?.top ?? 504.h,
          child: child
        );
  }
}

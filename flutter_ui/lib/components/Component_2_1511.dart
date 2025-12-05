import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_1511 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1511(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1511> createState() => _Component_2_1511State();
}

class _Component_2_1511State extends State<Component_2_1511> {


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
      visible: _getPropValueById('2:1511')?.visible ?? true,
      child: Container(
        decoration: BoxDecoration(color: _getPropValueById('2:1511')?.backgroundColor ?? Color.fromRGBO(255, 255, 255,1),),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          key: ValueKey("2:1511"),
          children: [
            Positioned(
              left: _getPropValueById('2:1512')?.left ?? 153.5.w,
              top: _getPropValueById('2:1512')?.top ?? 19.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1512')?.visible ?? true,
                child: Text(_getPropValueById('2:1512')?.text ?? "Page Title",
                  key: ValueKey("2:1512"),
                  textAlign: _getPropValueById('2:1512')?.textAlign ?? TextAlign.center,
                  style: TextStyle(color: _getPropValueById('2:1512')?.textGradient == null? _getPropValueById('2:1512')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:1512')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1512')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1512')?.left ?? 153.5.w, _getPropValueById('2:1512')?.top ?? 19.5.h, _getPropValueById('2:1512')?.width ?? 69.w, _getPropValueById('2:1512')?.height ?? 17.h))): null, fontFamily: _getPropValueById('2:1512')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1512')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1512')?.fontSize ?? 13.5.sp, letterSpacing: _getPropValueById('2:1512')?.letterSpacing ?? 0.w),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1511')?.width ?? 375.w,
          height: _getPropValueById('2:1511')?.height ?? 56.h,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1511')?.width ?? 375.w,
          height: _getPropValueById('2:1511')?.height ?? 56.h,
          left: _getPropValueById('2:1511')?.left ?? 24.w,
          top: _getPropValueById('2:1511')?.top ?? 904.h,
          child: child
        );
  }
}

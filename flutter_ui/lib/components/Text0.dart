import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Text0 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Text0(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Text0> createState() => _Text0State();
}

class _Text0State extends State<Text0> {


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
      visible: _getPropValueById('2:1487')?.visible ?? true,
      child: Container(
        decoration: BoxDecoration(color: _getPropValueById('2:1487')?.backgroundColor ?? Color.fromRGBO(255, 255, 255,1),),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          key: ValueKey("2:1487"),
          children: [
            Positioned(
              left: _getPropValueById('2:1488')?.left ?? 153.5.w,
              top: _getPropValueById('2:1488')?.top ?? 19.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1488')?.visible ?? true,
                child: Text(_getPropValueById('2:1488')?.text ?? "Page Title",
                  key: ValueKey("2:1488"),
                  textAlign: _getPropValueById('2:1488')?.textAlign ?? TextAlign.center,
                  style: TextStyle(color: _getPropValueById('2:1488')?.textGradient == null? _getPropValueById('2:1488')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:1488')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1488')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1488')?.left ?? 153.5.w, _getPropValueById('2:1488')?.top ?? 19.5.h, _getPropValueById('2:1488')?.width ?? 69.w, _getPropValueById('2:1488')?.height ?? 17.h))): null, fontFamily: _getPropValueById('2:1488')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1488')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1488')?.fontSize ?? 13.5.sp, letterSpacing: _getPropValueById('2:1488')?.letterSpacing ?? 0.w),),),),
            Positioned(
              left: _getPropValueById('2:1489')?.left ?? 24.w,
              top: _getPropValueById('2:1489')?.top ?? 20.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1489')?.visible ?? true,
                child: Text(_getPropValueById('2:1489')?.text ?? "Cancel",
                  key: ValueKey("2:1489"),
                  style: TextStyle(color: _getPropValueById('2:1489')?.textGradient == null? _getPropValueById('2:1489')?.textColor ?? Color.fromRGBO(0, 111, 253,1): null, foreground: _getPropValueById('2:1489')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1489')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1489')?.left ?? 24.w, _getPropValueById('2:1489')?.top ?? 20.5.h, _getPropValueById('2:1489')?.width ?? 41.w, _getPropValueById('2:1489')?.height ?? 15.h))): null, fontFamily: _getPropValueById('2:1489')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1489')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1489')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('2:1489')?.letterSpacing ?? 0.w),),),),
            Positioned(
              left: _getPropValueById('2:1490')?.left ?? 328.w,
              top: _getPropValueById('2:1490')?.top ?? 20.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1490')?.visible ?? true,
                child: Text(_getPropValueById('2:1490')?.text ?? "Edit",
                  key: ValueKey("2:1490"),
                  textAlign: _getPropValueById('2:1490')?.textAlign ?? TextAlign.right,
                  style: TextStyle(color: _getPropValueById('2:1490')?.textGradient == null? _getPropValueById('2:1490')?.textColor ?? Color.fromRGBO(0, 111, 253,1): null, foreground: _getPropValueById('2:1490')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1490')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1490')?.left ?? 328.w, _getPropValueById('2:1490')?.top ?? 20.5.h, _getPropValueById('2:1490')?.width ?? 23.w, _getPropValueById('2:1490')?.height ?? 15.h))): null, fontFamily: _getPropValueById('2:1490')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1490')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1490')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('2:1490')?.letterSpacing ?? 0.w),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1487')?.width ?? 375.w,
          height: _getPropValueById('2:1487')?.height ?? 56.h,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1487')?.width ?? 375.w,
          height: _getPropValueById('2:1487')?.height ?? 56.h,
          left: _getPropValueById('2:1487')?.left ?? 24.w,
          top: _getPropValueById('2:1487')?.top ?? 344.h,
          child: child
        );
  }
}

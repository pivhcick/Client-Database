import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/ArrowLeft.dart';

class Text1 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Text1(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Text1> createState() => _Text1State();
}

class _Text1State extends State<Text1> {


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
      visible: _getPropValueById('2:1472')?.visible ?? true,
      child: Container(
        decoration: BoxDecoration(color: _getPropValueById('2:1472')?.backgroundColor ?? Color.fromRGBO(255, 255, 255,1),),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          key: ValueKey("2:1472"),
          children: [
            Positioned(
              left: _getPropValueById('2:1473')?.left ?? 328.w,
              top: _getPropValueById('2:1473')?.top ?? 20.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1473')?.visible ?? true,
                child: Text(_getPropValueById('2:1473')?.text ?? "Edit",
                  key: ValueKey("2:1473"),
                  textAlign: _getPropValueById('2:1473')?.textAlign ?? TextAlign.right,
                  style: TextStyle(color: _getPropValueById('2:1473')?.textGradient == null? _getPropValueById('2:1473')?.textColor ?? Color.fromRGBO(0, 111, 253,1): null, foreground: _getPropValueById('2:1473')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1473')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1473')?.left ?? 328.w, _getPropValueById('2:1473')?.top ?? 20.5.h, _getPropValueById('2:1473')?.width ?? 23.w, _getPropValueById('2:1473')?.height ?? 15.h))): null, fontFamily: _getPropValueById('2:1473')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1473')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1473')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('2:1473')?.letterSpacing ?? 0.w),),),),
            Positioned(
              left: _getPropValueById('2:1474')?.left ?? 153.5.w,
              top: _getPropValueById('2:1474')?.top ?? 19.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1474')?.visible ?? true,
                child: Text(_getPropValueById('2:1474')?.text ?? "Page Title",
                  key: ValueKey("2:1474"),
                  textAlign: _getPropValueById('2:1474')?.textAlign ?? TextAlign.center,
                  style: TextStyle(color: _getPropValueById('2:1474')?.textGradient == null? _getPropValueById('2:1474')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:1474')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1474')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1474')?.left ?? 153.5.w, _getPropValueById('2:1474')?.top ?? 19.5.h, _getPropValueById('2:1474')?.width ?? 69.w, _getPropValueById('2:1474')?.height ?? 17.h))): null, fontFamily: _getPropValueById('2:1474')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1474')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1474')?.fontSize ?? 13.5.sp, letterSpacing: _getPropValueById('2:1474')?.letterSpacing ?? 0.w),),),),
            ArrowLeft({"2:1540":PixFlutterInterface(width:20.w,height:20.w,left:24.w,top:18.h,supInterface:_getPropValueById('2:1540'),),"2:1541":PixFlutterInterface(width:11.67.w,height:19.17.h,left:4.17.w,top:0.42.h,supInterface:_getPropValueById('2:1541'),),"2:1542":PixFlutterInterface(width:20.w,height:20.w,left:0.w,top:0.h,supInterface:_getPropValueById('2:1542'),),}, false),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1472')?.width ?? 375.w,
          height: _getPropValueById('2:1472')?.height ?? 56.h,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1472')?.width ?? 375.w,
          height: _getPropValueById('2:1472')?.height ?? 56.h,
          left: _getPropValueById('2:1472')?.left ?? 24.w,
          top: _getPropValueById('2:1472')?.top ?? 24.h,
          child: child
        );
  }
}

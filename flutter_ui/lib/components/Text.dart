import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Text extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Text(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Text> createState() => _TextState();
}

class _TextState extends State<Text> {


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
      visible: _getPropValueById('2:1502')?.visible ?? true,
      child: Container(
        decoration: BoxDecoration(color: _getPropValueById('2:1502')?.backgroundColor ?? Color.fromRGBO(255, 255, 255,1),),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          key: ValueKey("2:1502"),
          children: [
            Positioned(
              left: _getPropValueById('2:1503')?.left ?? 328.w,
              top: _getPropValueById('2:1503')?.top ?? 20.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1503')?.visible ?? true,
                child: Text(_getPropValueById('2:1503')?.text ?? "Edit",
                  key: ValueKey("2:1503"),
                  textAlign: _getPropValueById('2:1503')?.textAlign ?? TextAlign.right,
                  style: TextStyle(color: _getPropValueById('2:1503')?.textGradient == null? _getPropValueById('2:1503')?.textColor ?? Color.fromRGBO(0, 111, 253,1): null, foreground: _getPropValueById('2:1503')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1503')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1503')?.left ?? 328.w, _getPropValueById('2:1503')?.top ?? 20.5.h, _getPropValueById('2:1503')?.width ?? 23.w, _getPropValueById('2:1503')?.height ?? 15.h))): null, fontFamily: _getPropValueById('2:1503')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1503')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1503')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('2:1503')?.letterSpacing ?? 0.w),),),),
            Positioned(
              left: _getPropValueById('2:1504')?.left ?? 153.5.w,
              top: _getPropValueById('2:1504')?.top ?? 19.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1504')?.visible ?? true,
                child: Text(_getPropValueById('2:1504')?.text ?? "Page Title",
                  key: ValueKey("2:1504"),
                  textAlign: _getPropValueById('2:1504')?.textAlign ?? TextAlign.center,
                  style: TextStyle(color: _getPropValueById('2:1504')?.textGradient == null? _getPropValueById('2:1504')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:1504')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1504')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1504')?.left ?? 153.5.w, _getPropValueById('2:1504')?.top ?? 19.5.h, _getPropValueById('2:1504')?.width ?? 69.w, _getPropValueById('2:1504')?.height ?? 17.h))): null, fontFamily: _getPropValueById('2:1504')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1504')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1504')?.fontSize ?? 13.5.sp, letterSpacing: _getPropValueById('2:1504')?.letterSpacing ?? 0.w),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1502')?.width ?? 375.w,
          height: _getPropValueById('2:1502')?.height ?? 56.h,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1502')?.width ?? 375.w,
          height: _getPropValueById('2:1502')?.height ?? 56.h,
          left: _getPropValueById('2:1502')?.left ?? 24.w,
          top: _getPropValueById('2:1502')?.top ?? 664.h,
          child: child
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_1543.dart';

class Component_2_1491 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1491(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1491> createState() => _Component_2_1491State();
}

class _Component_2_1491State extends State<Component_2_1491> {


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
      visible: _getPropValueById('2:1491')?.visible ?? true,
      child: Container(
        decoration: BoxDecoration(color: _getPropValueById('2:1491')?.backgroundColor ?? Color.fromRGBO(255, 255, 255,1),),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          key: ValueKey("2:1491"),
          children: [
            Component_2_1543({"2:1543":PixFlutterInterface(width:20.w,height:20.w,left:331.w,top:18.h,supInterface:_getPropValueById('2:1543'),),"2:1544":PixFlutterInterface(width:19.58.w,height:17.69.h,left:0.21.w,top:1.16.h,supInterface:_getPropValueById('2:1544'),),"2:1545":PixFlutterInterface(width:20.w,height:20.w,supInterface:_getPropValueById('2:1545'),),}, false),
            Positioned(
              left: _getPropValueById('2:1493')?.left ?? 153.5.w,
              top: _getPropValueById('2:1493')?.top ?? 19.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1493')?.visible ?? true,
                child: Text(_getPropValueById('2:1493')?.text ?? "Page Title",
                  key: ValueKey("2:1493"),
                  textAlign: _getPropValueById('2:1493')?.textAlign ?? TextAlign.center,
                  style: TextStyle(color: _getPropValueById('2:1493')?.textGradient == null? _getPropValueById('2:1493')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:1493')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1493')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1493')?.left ?? 153.5.w, _getPropValueById('2:1493')?.top ?? 19.5.h, _getPropValueById('2:1493')?.width ?? 69.w, _getPropValueById('2:1493')?.height ?? 17.h))): null, fontFamily: _getPropValueById('2:1493')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1493')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1493')?.fontSize ?? 13.5.sp, letterSpacing: _getPropValueById('2:1493')?.letterSpacing ?? 0.w),),),),
            Positioned(
              left: _getPropValueById('2:1494')?.left ?? 24.w,
              top: _getPropValueById('2:1494')?.top ?? 20.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1494')?.visible ?? true,
                child: Text(_getPropValueById('2:1494')?.text ?? "Cancel",
                  key: ValueKey("2:1494"),
                  style: TextStyle(color: _getPropValueById('2:1494')?.textGradient == null? _getPropValueById('2:1494')?.textColor ?? Color.fromRGBO(0, 111, 253,1): null, foreground: _getPropValueById('2:1494')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1494')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1494')?.left ?? 24.w, _getPropValueById('2:1494')?.top ?? 20.5.h, _getPropValueById('2:1494')?.width ?? 41.w, _getPropValueById('2:1494')?.height ?? 15.h))): null, fontFamily: _getPropValueById('2:1494')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1494')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1494')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('2:1494')?.letterSpacing ?? 0.w),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1491')?.width ?? 375.w,
          height: _getPropValueById('2:1491')?.height ?? 56.h,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1491')?.width ?? 375.w,
          height: _getPropValueById('2:1491')?.height ?? 56.h,
          left: _getPropValueById('2:1491')?.left ?? 24.w,
          top: _getPropValueById('2:1491')?.top ?? 424.h,
          child: child
        );
  }
}

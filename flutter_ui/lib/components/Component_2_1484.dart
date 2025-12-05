import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/ArrowLeft.dart';

class Component_2_1484 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1484(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1484> createState() => _Component_2_1484State();
}

class _Component_2_1484State extends State<Component_2_1484> {


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
      visible: _getPropValueById('2:1484')?.visible ?? true,
      child: Container(
        decoration: BoxDecoration(color: _getPropValueById('2:1484')?.backgroundColor ?? Color.fromRGBO(255, 255, 255,1),),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          key: ValueKey("2:1484"),
          children: [
            Positioned(
              left: _getPropValueById('2:1485')?.left ?? 153.5.w,
              top: _getPropValueById('2:1485')?.top ?? 19.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1485')?.visible ?? true,
                child: Text(_getPropValueById('2:1485')?.text ?? "Page Title",
                  key: ValueKey("2:1485"),
                  textAlign: _getPropValueById('2:1485')?.textAlign ?? TextAlign.center,
                  style: TextStyle(color: _getPropValueById('2:1485')?.textGradient == null? _getPropValueById('2:1485')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:1485')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1485')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1485')?.left ?? 153.5.w, _getPropValueById('2:1485')?.top ?? 19.5.h, _getPropValueById('2:1485')?.width ?? 69.w, _getPropValueById('2:1485')?.height ?? 17.h))): null, fontFamily: _getPropValueById('2:1485')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1485')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1485')?.fontSize ?? 13.5.sp, letterSpacing: _getPropValueById('2:1485')?.letterSpacing ?? 0.w),),),),
            ArrowLeft({"2:1540":PixFlutterInterface(width:20.w,height:20.w,left:24.w,top:18.h,supInterface:_getPropValueById('2:1540'),),"2:1541":PixFlutterInterface(width:11.67.w,height:19.17.h,left:4.17.w,top:0.42.h,supInterface:_getPropValueById('2:1541'),),"2:1542":PixFlutterInterface(width:20.w,height:20.w,left:0.w,top:0.h,supInterface:_getPropValueById('2:1542'),),}, false),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1484')?.width ?? 375.w,
          height: _getPropValueById('2:1484')?.height ?? 56.h,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1484')?.width ?? 375.w,
          height: _getPropValueById('2:1484')?.height ?? 56.h,
          left: _getPropValueById('2:1484')?.left ?? 24.w,
          top: _getPropValueById('2:1484')?.top ?? 264.h,
          child: child
        );
  }
}

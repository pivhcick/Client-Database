import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_1543.dart';

class Component_2_1505 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1505(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1505> createState() => _Component_2_1505State();
}

class _Component_2_1505State extends State<Component_2_1505> {


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
      visible: _getPropValueById('2:1505')?.visible ?? true,
      child: Container(
        decoration: BoxDecoration(color: _getPropValueById('2:1505')?.backgroundColor ?? Color.fromRGBO(255, 255, 255,1),),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          key: ValueKey("2:1505"),
          children: [
            Component_2_1543({"2:1543":PixFlutterInterface(width:20.w,height:20.w,left:331.w,top:18.h,supInterface:_getPropValueById('2:1543'),),"2:1544":PixFlutterInterface(width:19.58.w,height:17.69.h,left:0.21.w,top:1.16.h,supInterface:_getPropValueById('2:1544'),),"2:1545":PixFlutterInterface(width:20.w,height:20.w,supInterface:_getPropValueById('2:1545'),),}, false),
            Positioned(
              left: _getPropValueById('2:1507')?.left ?? 153.5.w,
              top: _getPropValueById('2:1507')?.top ?? 19.5.h,
              child: Visibility(
                visible: _getPropValueById('2:1507')?.visible ?? true,
                child: Text(_getPropValueById('2:1507')?.text ?? "Page Title",
                  key: ValueKey("2:1507"),
                  textAlign: _getPropValueById('2:1507')?.textAlign ?? TextAlign.center,
                  style: TextStyle(color: _getPropValueById('2:1507')?.textGradient == null? _getPropValueById('2:1507')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:1507')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1507')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1507')?.left ?? 153.5.w, _getPropValueById('2:1507')?.top ?? 19.5.h, _getPropValueById('2:1507')?.width ?? 69.w, _getPropValueById('2:1507')?.height ?? 17.h))): null, fontFamily: _getPropValueById('2:1507')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1507')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1507')?.fontSize ?? 13.5.sp, letterSpacing: _getPropValueById('2:1507')?.letterSpacing ?? 0.w),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1505')?.width ?? 375.w,
          height: _getPropValueById('2:1505')?.height ?? 56.h,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1505')?.width ?? 375.w,
          height: _getPropValueById('2:1505')?.height ?? 56.h,
          left: _getPropValueById('2:1505')?.left ?? 24.w,
          top: _getPropValueById('2:1505')?.top ?? 744.h,
          child: child
        );
  }
}

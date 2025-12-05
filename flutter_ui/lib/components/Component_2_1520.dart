import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_194.dart';

class Component_2_1520 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1520(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1520> createState() => _Component_2_1520State();
}

class _Component_2_1520State extends State<Component_2_1520> {


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
      visible: _getPropValueById('2:1520')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('2:1520')?.width ?? 26.w, minHeight: _getPropValueById('2:1520')?.height ?? 40.h),
          child: Column(
            key: ValueKey("2:1520"),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8.h,
            children: [
              Component_2_194({"2:194":PixFlutterInterface(width:20.w,height:20.w,left:3.w,top:0.h,supInterface:_getPropValueById('2:194'),),"2:195":PixFlutterInterface(width:18.33.w,height:18.33.w,left:0.83.w,top:0.83.h,supInterface:_getPropValueById('2:195'),),"2:196":PixFlutterInterface(backgroundColor:Color.fromRGBO(0, 111, 253,1),width:20.w,height:20.w,supInterface:_getPropValueById('2:196'),),}, true),
              Visibility(
                visible: _getPropValueById('2:1522')?.visible ?? true,
                child: Text(_getPropValueById('2:1522')?.text ?? "Tab 1",
                  key: ValueKey("2:1522"),
                  textAlign: _getPropValueById('2:1522')?.textAlign ?? TextAlign.center,
                  style: TextStyle(color: _getPropValueById('2:1522')?.textGradient == null? _getPropValueById('2:1522')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:1522')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1522')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1522')?.left ?? 0.w, _getPropValueById('2:1522')?.top ?? 28.h, _getPropValueById('2:1522')?.width ?? 26.w, _getPropValueById('2:1522')?.height ?? 12.h))): null, fontFamily: _getPropValueById('2:1522')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:1522')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:1522')?.fontSize ?? 9.5.sp, letterSpacing: _getPropValueById('2:1522')?.letterSpacing ?? 0.15.w),),),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          height: _getPropValueById('2:1520')?.height ?? 40.h,
          child: child
        )
      : Positioned(
          height: _getPropValueById('2:1520')?.height ?? 40.h,
          left: _getPropValueById('2:1520')?.left ?? 24.w,
          top: _getPropValueById('2:1520')?.top ?? 24.h,
          child: child
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_194.dart';

class Component_2_1523 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1523(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1523> createState() => _Component_2_1523State();
}

class _Component_2_1523State extends State<Component_2_1523> {


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
      visible: _getPropValueById('2:1523')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('2:1523')?.width ?? 26.w, minHeight: _getPropValueById('2:1523')?.height ?? 42.h),
          child: Column(
            key: ValueKey("2:1523"),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8.h,
            children: [
              Component_2_194({"2:194":PixFlutterInterface(width:20.w,height:20.w,left:3.w,top:0.h,supInterface:_getPropValueById('2:194'),),"2:195":PixFlutterInterface(width:18.33.w,height:18.33.w,left:0.83.w,top:0.83.h,supInterface:_getPropValueById('2:195'),),"2:196":PixFlutterInterface(backgroundColor:Color.fromRGBO(212, 214, 221,1),width:20.w,height:20.w,supInterface:_getPropValueById('2:196'),),}, true),
              Visibility(
                visible: _getPropValueById('2:1525')?.visible ?? true,
                child: Text(_getPropValueById('2:1525')?.text ?? "Tab 1",
                  key: ValueKey("2:1525"),
                  textAlign: _getPropValueById('2:1525')?.textAlign ?? TextAlign.center,
                  style: TextStyle(color: _getPropValueById('2:1525')?.textGradient == null? _getPropValueById('2:1525')?.textColor ?? Color.fromRGBO(113, 114, 122,1): null, foreground: _getPropValueById('2:1525')?.textGradient != null? (Paint()..shader = _getPropValueById('2:1525')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:1525')?.left ?? 0.w, _getPropValueById('2:1525')?.top ?? 28.h, _getPropValueById('2:1525')?.width ?? 26.w, _getPropValueById('2:1525')?.height ?? 14.h))): null, fontFamily: _getPropValueById('2:1525')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:1525')?.fontSize ?? 9.5.sp, height: _getPropValueById('2:1525')?.lineHeight ?? 1.4, letterSpacing: _getPropValueById('2:1525')?.letterSpacing ?? 0.14999999664723873.w),),),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          height: _getPropValueById('2:1523')?.height ?? 42.h,
          child: child
        )
      : Positioned(
          height: _getPropValueById('2:1523')?.height ?? 42.h,
          left: _getPropValueById('2:1523')?.left ?? 74.w,
          top: _getPropValueById('2:1523')?.top ?? 24.h,
          child: child
        );
  }
}

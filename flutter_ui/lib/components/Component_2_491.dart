import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_194.dart';

class Component_2_491 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_491(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_491> createState() => _Component_2_491State();
}

class _Component_2_491State extends State<Component_2_491> {


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
      visible: _getPropValueById('2:491')?.visible ?? true,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('2:491')?.width ?? 71.w, minHeight: _getPropValueById('2:491')?.height ?? 40.h),
          padding: EdgeInsets.only(left: 16.w,right: 16.w),
          decoration: BoxDecoration(color: _getPropValueById('2:491')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),borderRadius: _getPropValueById('2:491')?.borderRadius ?? BorderRadius.circular(12.h),),
          clipBehavior: Clip.hardEdge,
          child: Row(
            key: ValueKey("2:491"),
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8.w,
            children: [
              Component_2_194({"2:194":PixFlutterInterface(width:12.w,height:12.w,left:16.75.w,top:15.h,supInterface:_getPropValueById('2:194'),),"2:195":PixFlutterInterface(backgroundColor:Color.fromRGBO(255, 255, 255,1),width:11.w,height:11.w,left:0.5.w,top:0.5.h,supInterface:_getPropValueById('2:195'),),"2:196":PixFlutterInterface(backgroundColor:Color.fromRGBO(255, 255, 255,1),width:12.w,height:12.w,supInterface:_getPropValueById('2:196'),),}, true),
              Visibility(
                visible: _getPropValueById('2:493')?.visible ?? true,
                child: Text(_getPropValueById('2:493')?.text ?? "Button",
                  key: ValueKey("2:493"),
                  style: TextStyle(color: _getPropValueById('2:493')?.textGradient == null? _getPropValueById('2:493')?.textColor ?? Color.fromRGBO(255, 255, 255,1): null, foreground: _getPropValueById('2:493')?.textGradient != null? (Paint()..shader = _getPropValueById('2:493')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:493')?.left ?? 16.w, _getPropValueById('2:493')?.top ?? 12.5.h, _getPropValueById('2:493')?.width ?? 39.w, _getPropValueById('2:493')?.height ?? 15.h))): null, fontFamily: _getPropValueById('2:493')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:493')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:493')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('2:493')?.letterSpacing ?? 0.w),),),
              Component_2_194({"2:194":PixFlutterInterface(width:12.w,height:12.w,left:83.75.w,top:15.h,supInterface:_getPropValueById('2:194'),),"2:195":PixFlutterInterface(backgroundColor:Color.fromRGBO(255, 255, 255,1),width:11.w,height:11.w,left:0.5.w,top:0.5.h,supInterface:_getPropValueById('2:195'),),"2:196":PixFlutterInterface(backgroundColor:Color.fromRGBO(255, 255, 255,1),width:12.w,height:12.w,supInterface:_getPropValueById('2:196'),),}, true),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:491')?.width ?? 71.w,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:491')?.width ?? 71.w,
          left: _getPropValueById('2:491')?.left ?? -7392.08.w,
          top: _getPropValueById('2:491')?.top ?? 683.h,
          child: child
        );
  }
}

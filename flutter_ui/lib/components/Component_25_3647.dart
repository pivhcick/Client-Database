import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Search.dart';

class Component_25_3647 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_25_3647(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_25_3647> createState() => _Component_25_3647State();
}

class _Component_25_3647State extends State<Component_25_3647> {


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
      visible: _getPropValueById('25:3647')?.visible ?? true,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('25:3647')?.width ?? 311.w, minHeight: _getPropValueById('25:3647')?.height ?? 44.h),
          padding: EdgeInsets.only(left: 16.w,right: 16.w),
          decoration: BoxDecoration(color: _getPropValueById('25:3647')?.backgroundColor ?? Color.fromRGBO(248, 249, 254,1),borderRadius: _getPropValueById('25:3647')?.borderRadius ?? BorderRadius.circular(24.h),),
          clipBehavior: Clip.hardEdge,
          child: Row(
            key: ValueKey("25:3647"),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 16.w,
            children: [
              Search({"2:2231":PixFlutterInterface(width:16.w,height:16.w,left:16.w,top:16.h,supInterface:_getPropValueById('2:2231'),),"2:2232":PixFlutterInterface(width:15.33.w,height:15.33.w,left:0.33.w,top:0.33.h,supInterface:_getPropValueById('2:2232'),),"2:2233":PixFlutterInterface(backgroundColor:Color.fromRGBO(47, 48, 54,1),width:16.w,height:16.w,supInterface:_getPropValueById('2:2233'),),}, true),
              Visibility(
                visible: _getPropValueById('25:3649')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('25:3649')?.width ?? 247.w,
                  height: _getPropValueById('25:3649')?.height ?? 20.h,
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('25:3649')?.width ?? 247.w, minHeight: _getPropValueById('25:3649')?.height ?? 20.h),
                      child: Row(
                        key: ValueKey("25:3649"),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 1.w,
                        children: [
                          Visibility(
                            visible: _getPropValueById('25:3650')?.visible ?? true,
                            child: Text(_getPropValueById('25:3650')?.text ?? "Text",
                              key: ValueKey("25:3650"),
                              style: TextStyle(color: _getPropValueById('25:3650')?.textGradient == null? _getPropValueById('25:3650')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('25:3650')?.textGradient != null? (Paint()..shader = _getPropValueById('25:3650')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:3650')?.left ?? 0.w, _getPropValueById('25:3650')?.top ?? 0.h, _getPropValueById('25:3650')?.width ?? 29.w, _getPropValueById('25:3650')?.height ?? 20.h))): null, fontFamily: _getPropValueById('25:3650')?.fontFamily ?? "Inter", fontSize: _getPropValueById('25:3650')?.fontSize ?? 13.5.sp, height: _getPropValueById('25:3650')?.lineHeight ?? 1.4285714285714286, letterSpacing: _getPropValueById('25:3650')?.letterSpacing ?? 0.w),),),
                          Container(
                            width: 1.w,
                            height: 16.h,
                            child: Image(
                              key: ValueKey("25:3651"),
                              image: AssetImage("assets/images/Vector_25_3651.png"),),),
                        ],),),),),),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('25:3647')?.width ?? 311.w,
          child: child
        )
      : Positioned(
          width: _getPropValueById('25:3647')?.width ?? 311.w,
          left: _getPropValueById('25:3647')?.left ?? 20.w,
          top: _getPropValueById('25:3647')?.top ?? 80.h,
          child: child
        );
  }
}

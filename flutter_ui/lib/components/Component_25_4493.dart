import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_3271.dart';
import 'package:flutter_ui/components/Component_2_1532.dart';

class Component_25_4493 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_25_4493(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_25_4493> createState() => _Component_25_4493State();
}

class _Component_25_4493State extends State<Component_25_4493> {


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
      visible: _getPropValueById('25:4493')?.visible ?? true,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('25:4493')?.width ?? 102.w, minHeight: _getPropValueById('25:4493')?.height ?? 36.h),
          padding: EdgeInsets.only(left: 12.w,right: 8.w),
          decoration: BoxDecoration(borderRadius: _getPropValueById('25:4493')?.borderRadius ?? BorderRadius.circular(12.h),border: _getPropValueById('25:4493')?.border ?? Border.all(width: 0.5.w, color: Color.fromRGBO(197, 198, 204,1), ),),
          clipBehavior: Clip.hardEdge,
          child: Row(
            key: ValueKey("25:4493"),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12.w,
            children: [
              Visibility(
                visible: _getPropValueById('25:4494')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('25:4494')?.width ?? 50.w,
                  height: _getPropValueById('25:4494')?.height ?? 16.h,
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('25:4494')?.width ?? 50.w, minHeight: _getPropValueById('25:4494')?.height ?? 16.h),
                      child: Row(
                        key: ValueKey("25:4494"),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8.w,
                        children: [
                          Component_2_3271({"2:3271":PixFlutterInterface(width:12.w,height:12.w,left:0.w,top:2.h,supInterface:_getPropValueById('2:3271'),),"2:3272":PixFlutterInterface(width:10.w,height:9.1.w,left:1.w,top:1.5.h,supInterface:_getPropValueById('2:3272'),),"2:3273":PixFlutterInterface(backgroundColor:Color.fromRGBO(143, 144, 152,1),width:12.w,height:12.w,left:0.w,top:0.h,supInterface:_getPropValueById('2:3273'),),}, true),
                          Visibility(
                            visible: _getPropValueById('25:4496')?.visible ?? true,
                            child: Text(_getPropValueById('25:4496')?.text ?? "Filter",
                              key: ValueKey("25:4496"),
                              style: TextStyle(color: _getPropValueById('25:4496')?.textGradient == null? _getPropValueById('25:4496')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('25:4496')?.textGradient != null? (Paint()..shader = _getPropValueById('25:4496')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:4496')?.left ?? 20.w, _getPropValueById('25:4496')?.top ?? 0.h, _getPropValueById('25:4496')?.width ?? 30.w, _getPropValueById('25:4496')?.height ?? 16.h))): null, fontFamily: _getPropValueById('25:4496')?.fontFamily ?? "Inter", fontSize: _getPropValueById('25:4496')?.fontSize ?? 11.5.sp, height: _getPropValueById('25:4496')?.lineHeight ?? 1.3333333333333333, letterSpacing: _getPropValueById('25:4496')?.letterSpacing ?? 0.11999999731779099.w),),),
                        ],),),),),),
              Component_2_1532({"2:1532":PixFlutterInterface(width:20.w,height:20.w,left:74.w,top:8.h,supInterface:_getPropValueById('2:1532'),),"2:1533":PixFlutterInterface(left:6.5.w,top:4.h,supInterface:_getPropValueById('2:1533'),),}, true),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('25:4493')?.width ?? 102.w,
          child: child
        )
      : Positioned(
          width: _getPropValueById('25:4493')?.width ?? 102.w,
          left: _getPropValueById('25:4493')?.left ?? 20.w,
          top: _getPropValueById('25:4493')?.top ?? 64.5.h,
          child: child
        );
  }
}

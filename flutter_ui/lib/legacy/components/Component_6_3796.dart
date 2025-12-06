import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_175.dart';
import 'package:flutter_ui/components/Component_2_491.dart';

class Component_6_3796 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_6_3796(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_6_3796> createState() => _Component_6_3796State();
}

class _Component_6_3796State extends State<Component_6_3796> {


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
      visible: _getPropValueById('6:3796')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('6:3796')?.width ?? 300.w, minHeight: _getPropValueById('6:3796')?.height ?? 167.h),
          padding: EdgeInsets.only(left: 16.w,right: 16.w, top: 16.h,bottom: 16.h),
          decoration: BoxDecoration(color: _getPropValueById('6:3796')?.backgroundColor ?? Color.fromRGBO(255, 255, 255,1),borderRadius: _getPropValueById('6:3796')?.borderRadius ?? BorderRadius.circular(16.h),),
          child: Column(
            key: ValueKey("6:3796"),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20.h,
            children: [
              Visibility(
                visible: _getPropValueById('6:3797')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('6:3797')?.width ?? 268.w,
                  height: _getPropValueById('6:3797')?.height ?? 75.h,
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('6:3797')?.width ?? 268.w, minHeight: _getPropValueById('6:3797')?.height ?? 75.h),
                      padding: EdgeInsets.only(left: 8.w,right: 8.w, top: 8.h,bottom: 8.h),
                      child: Column(
                        key: ValueKey("6:3797"),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8.h,
                        children: [
                          Visibility(
                            visible: _getPropValueById('6:3798')?.visible ?? true,
                            child: Container(
                              width: _getPropValueById('6:3798')?.width ?? 252.w,
                              child: Text(_getPropValueById('6:3798')?.text ?? "Title",
                                key: ValueKey("6:3798"),
                                textAlign: _getPropValueById('6:3798')?.textAlign ?? TextAlign.center,
                                style: TextStyle(color: _getPropValueById('6:3798')?.textGradient == null? _getPropValueById('6:3798')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('6:3798')?.textGradient != null? (Paint()..shader = _getPropValueById('6:3798')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('6:3798')?.left ?? 8.w, _getPropValueById('6:3798')?.top ?? 8.h, _getPropValueById('6:3798')?.width ?? 252.w, _getPropValueById('6:3798')?.height ?? 19.h))): null, fontFamily: _getPropValueById('6:3798')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('6:3798')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('6:3798')?.fontSize ?? 15.5.sp, letterSpacing: _getPropValueById('6:3798')?.letterSpacing ?? 0.07999999821186066.w),),),),
                          Visibility(
                            visible: _getPropValueById('6:3799')?.visible ?? true,
                            child: Container(
                              width: _getPropValueById('6:3799')?.width ?? 252.w,
                              child: Text(_getPropValueById('6:3799')?.text ?? "Description. Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do.",
                                key: ValueKey("6:3799"),
                                textAlign: _getPropValueById('6:3799')?.textAlign ?? TextAlign.center,
                                style: TextStyle(color: _getPropValueById('6:3799')?.textGradient == null? _getPropValueById('6:3799')?.textColor ?? Color.fromRGBO(113, 114, 122,1): null, foreground: _getPropValueById('6:3799')?.textGradient != null? (Paint()..shader = _getPropValueById('6:3799')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('6:3799')?.left ?? 8.w, _getPropValueById('6:3799')?.top ?? 35.h, _getPropValueById('6:3799')?.width ?? 252.w, _getPropValueById('6:3799')?.height ?? 32.h))): null, fontFamily: _getPropValueById('6:3799')?.fontFamily ?? "Inter", fontSize: _getPropValueById('6:3799')?.fontSize ?? 11.5.sp, height: _getPropValueById('6:3799')?.lineHeight ?? 1.3333333333333333, letterSpacing: _getPropValueById('6:3799')?.letterSpacing ?? 0.11999999731779099.w),),),),
                        ],),),),),),
              Visibility(
                visible: _getPropValueById('6:3800')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('6:3800')?.width ?? 268.w,
                  height: _getPropValueById('6:3800')?.height ?? 40.h,
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('6:3800')?.width ?? 268.w, minHeight: _getPropValueById('6:3800')?.height ?? 40.h),
                      child: Row(
                        key: ValueKey("6:3800"),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8.w,
                        children: [
                          Component_2_175({"2:175":PixFlutterInterface(width:130.w,height:40.h,left:0.w,top:0.h,supInterface:_getPropValueById('2:175'),),"2:177":PixFlutterInterface(width:48.w,height:15.h,left:41.w,top:12.5.h,supInterface:_getPropValueById('2:177'),),}, true),
                          Component_2_491({"2:493":PixFlutterInterface(width:50.w,height:15.h,left:40.w,top:12.5.h,supInterface:_getPropValueById('2:493'),),"2:491":PixFlutterInterface(backgroundColor:Color.fromRGBO(245, 49, 120,1),width:130.w,height:40.h,left:138.w,top:0.h,supInterface:_getPropValueById('2:491'),),}, true),
                        ],),),),),),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          height: _getPropValueById('6:3796')?.height ?? 167.h,
          child: child
        )
      : Positioned(
          height: _getPropValueById('6:3796')?.height ?? 167.h,
          left: _getPropValueById('6:3796')?.left ?? -9167.29.w,
          top: _getPropValueById('6:3796')?.top ?? 570.h,
          child: child
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_504.dart';

class Component_25_5725 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_25_5725(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_25_5725> createState() => _Component_25_5725State();
}

class _Component_25_5725State extends State<Component_25_5725> {


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
      visible: _getPropValueById('25:5725')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('25:5725')?.width ?? 295.w, minHeight: _getPropValueById('25:5725')?.height ?? 71.h),
          child: Column(
            key: ValueKey("25:5725"),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              Visibility(
                visible: _getPropValueById('25:5726')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('25:5726')?.width ?? 295.w,
                  child: Text(_getPropValueById('25:5726')?.text ?? "Title",
                    key: ValueKey("25:5726"),
                    style: TextStyle(color: _getPropValueById('25:5726')?.textGradient == null? _getPropValueById('25:5726')?.textColor ?? Color.fromRGBO(47, 48, 54,1): null, foreground: _getPropValueById('25:5726')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5726')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5726')?.left ?? 0.w, _getPropValueById('25:5726')?.top ?? 0.h, _getPropValueById('25:5726')?.width ?? 295.w, _getPropValueById('25:5726')?.height ?? 15.h))): null, fontFamily: _getPropValueById('25:5726')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('25:5726')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('25:5726')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('25:5726')?.letterSpacing ?? 0.w),),),),
              Visibility(
                visible: _getPropValueById('25:5727')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('25:5727')?.width ?? 295.w,
                  height: _getPropValueById('25:5727')?.height ?? 48.h,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('25:5727')?.width ?? 295.w, minHeight: _getPropValueById('25:5727')?.height ?? 48.h),
                      padding: EdgeInsets.only(left: 16.w,right: 16.w, top: 12.h,bottom: 12.h),
                      decoration: BoxDecoration(borderRadius: _getPropValueById('25:5727')?.borderRadius ?? BorderRadius.circular(12.h),border: _getPropValueById('25:5727')?.border ?? Border.all(width: 1.w, color: Color.fromRGBO(197, 198, 204,1), ),),
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        key: ValueKey("25:5727"),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8.w,
                        children: [
                          Visibility(
                            visible: _getPropValueById('25:5728')?.visible ?? true,
                            child: SizedBox(
                              width: _getPropValueById('25:5728')?.width ?? 263.w,
                              height: _getPropValueById('25:5728')?.height ?? 20.h,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  constraints: BoxConstraints(minWidth: _getPropValueById('25:5728')?.width ?? 263.w, minHeight: _getPropValueById('25:5728')?.height ?? 20.h),
                                  child: Row(
                                    key: ValueKey("25:5728"),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 6.w,
                                    children: [
                                      Visibility(
                                        visible: _getPropValueById('25:5729')?.visible ?? true,
                                        child: Text(_getPropValueById('25:5729')?.text ?? "€",
                                          key: ValueKey("25:5729"),
                                          style: TextStyle(color: _getPropValueById('25:5729')?.textGradient == null? _getPropValueById('25:5729')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('25:5729')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5729')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5729')?.left ?? 0.w, _getPropValueById('25:5729')?.top ?? 0.h, _getPropValueById('25:5729')?.width ?? 10.w, _getPropValueById('25:5729')?.height ?? 18.h))): null, fontFamily: _getPropValueById('25:5729')?.fontFamily ?? "Inter", fontSize: _getPropValueById('25:5729')?.fontSize ?? 13.5.sp, height: _getPropValueById('25:5729')?.lineHeight ?? 1.2857142857142858, letterSpacing: _getPropValueById('25:5729')?.letterSpacing ?? 0.w),),),
                                      Visibility(
                                        visible: _getPropValueById('25:5730')?.visible ?? true,
                                        child: SizedBox(
                                          width: _getPropValueById('25:5730')?.width ?? 263.w,
                                          height: _getPropValueById('25:5730')?.height ?? 20.h,
                                          child: SingleChildScrollView(
                                            clipBehavior: Clip.none,
                                            physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              constraints: BoxConstraints(minWidth: _getPropValueById('25:5730')?.width ?? 263.w, minHeight: _getPropValueById('25:5730')?.height ?? 20.h),
                                              child: Row(
                                                key: ValueKey("25:5730"),
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                spacing: 1.w,
                                                children: [
                                                  Visibility(
                                                    visible: _getPropValueById('25:5731')?.visible ?? true,
                                                    child: Text(_getPropValueById('25:5731')?.text ?? "Text",
                                                      key: ValueKey("25:5731"),
                                                      style: TextStyle(color: _getPropValueById('25:5731')?.textGradient == null? _getPropValueById('25:5731')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('25:5731')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5731')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5731')?.left ?? 0.w, _getPropValueById('25:5731')?.top ?? 0.h, _getPropValueById('25:5731')?.width ?? 29.w, _getPropValueById('25:5731')?.height ?? 20.h))): null, fontFamily: _getPropValueById('25:5731')?.fontFamily ?? "Inter", fontSize: _getPropValueById('25:5731')?.fontSize ?? 13.5.sp, height: _getPropValueById('25:5731')?.lineHeight ?? 1.4285714285714286, letterSpacing: _getPropValueById('25:5731')?.letterSpacing ?? 0.w),),),
                                                  Visibility(
                                                    visible: false,
                                                    child: Container(
                                                      width: 1.w,
                                                      height: 16.h,
                                                      child: Image(
                                                        key: ValueKey("25:5732"),
                                                        image: AssetImage("assets/images/Vector_25_5732.png"),),),),
                                                ],),),),),),
                                    ],),),),),),
                          Component_2_504({"2:504":PixFlutterInterface(width:16.w,height:16.w,left:263.w,top:16.h,supInterface:_getPropValueById('2:504'),),"2:505":PixFlutterInterface(width:16.w,height:13.67.h,left:0.w,top:1.16.h,supInterface:_getPropValueById('2:505'),),"2:506":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.72.w,top:0.h,supInterface:_getPropValueById('2:506'),),"2:507":PixFlutterInterface(width:16.w,height:10.91.h,left:0.w,top:1.38.h,supInterface:_getPropValueById('2:507'),),"2:508":PixFlutterInterface(width:16.w,height:10.91.h,supInterface:_getPropValueById('2:508'),),"2:509":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.17.w,top:-2.55.h,supInterface:_getPropValueById('2:509'),),"2:510":PixFlutterInterface(backgroundColor:Color.fromRGBO(143, 144, 152,1),width:16.w,height:16.w,supInterface:_getPropValueById('2:510'),),}, true),
                        ],),),),),),
              Visibility(
                visible: _getPropValueById('25:5734')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('25:5734')?.width ?? 295.w,
                  child: Text(_getPropValueById('25:5734')?.text ?? "Support text",
                    key: ValueKey("25:5734"),
                    style: TextStyle(color: _getPropValueById('25:5734')?.textGradient == null? _getPropValueById('25:5734')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('25:5734')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5734')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5734')?.left ?? 0.w, _getPropValueById('25:5734')?.top ?? 75.h, _getPropValueById('25:5734')?.width ?? 295.w, _getPropValueById('25:5734')?.height ?? 14.h))): null, fontFamily: _getPropValueById('25:5734')?.fontFamily ?? "Inter", fontSize: _getPropValueById('25:5734')?.fontSize ?? 9.5.sp, height: _getPropValueById('25:5734')?.lineHeight ?? 1.4, letterSpacing: _getPropValueById('25:5734')?.letterSpacing ?? 0.14999999664723873.w),),),),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          height: _getPropValueById('25:5725')?.height ?? 71.h,
          child: child
        )
      : Positioned(
          height: _getPropValueById('25:5725')?.height ?? 71.h,
          left: _getPropValueById('25:5725')?.left ?? 24.w,
          top: _getPropValueById('25:5725')?.top ?? 214.h,
          child: child
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_504.dart';

class Component_25_5735 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_25_5735(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_25_5735> createState() => _Component_25_5735State();
}

class _Component_25_5735State extends State<Component_25_5735> {


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
      visible: _getPropValueById('25:5735')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('25:5735')?.width ?? 295.w, minHeight: _getPropValueById('25:5735')?.height ?? 71.h),
          child: Column(
            key: ValueKey("25:5735"),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              Visibility(
                visible: _getPropValueById('25:5736')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('25:5736')?.width ?? 295.w,
                  child: Text(_getPropValueById('25:5736')?.text ?? "Title",
                    key: ValueKey("25:5736"),
                    style: TextStyle(color: _getPropValueById('25:5736')?.textGradient == null? _getPropValueById('25:5736')?.textColor ?? Color.fromRGBO(47, 48, 54,1): null, foreground: _getPropValueById('25:5736')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5736')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5736')?.left ?? 0.w, _getPropValueById('25:5736')?.top ?? 0.h, _getPropValueById('25:5736')?.width ?? 295.w, _getPropValueById('25:5736')?.height ?? 15.h))): null, fontFamily: _getPropValueById('25:5736')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('25:5736')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('25:5736')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('25:5736')?.letterSpacing ?? 0.w),),),),
              Visibility(
                visible: _getPropValueById('25:5737')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('25:5737')?.width ?? 295.w,
                  height: _getPropValueById('25:5737')?.height ?? 48.h,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('25:5737')?.width ?? 295.w, minHeight: _getPropValueById('25:5737')?.height ?? 48.h),
                      padding: EdgeInsets.only(left: 16.w,right: 16.w, top: 12.h,bottom: 12.h),
                      decoration: BoxDecoration(borderRadius: _getPropValueById('25:5737')?.borderRadius ?? BorderRadius.circular(12.h),border: _getPropValueById('25:5737')?.border ?? Border.all(width: 1.5.w, color: Color.fromRGBO(255, 97, 109,1), ),),
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        key: ValueKey("25:5737"),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8.w,
                        children: [
                          Visibility(
                            visible: _getPropValueById('25:5738')?.visible ?? true,
                            child: SizedBox(
                              width: _getPropValueById('25:5738')?.width ?? 263.w,
                              height: _getPropValueById('25:5738')?.height ?? 20.h,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  constraints: BoxConstraints(minWidth: _getPropValueById('25:5738')?.width ?? 263.w, minHeight: _getPropValueById('25:5738')?.height ?? 20.h),
                                  child: Row(
                                    key: ValueKey("25:5738"),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 6.w,
                                    children: [
                                      Visibility(
                                        visible: _getPropValueById('25:5739')?.visible ?? true,
                                        child: Text(_getPropValueById('25:5739')?.text ?? "€",
                                          key: ValueKey("25:5739"),
                                          style: TextStyle(color: _getPropValueById('25:5739')?.textGradient == null? _getPropValueById('25:5739')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('25:5739')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5739')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5739')?.left ?? 0.w, _getPropValueById('25:5739')?.top ?? 0.h, _getPropValueById('25:5739')?.width ?? 10.w, _getPropValueById('25:5739')?.height ?? 18.h))): null, fontFamily: _getPropValueById('25:5739')?.fontFamily ?? "Inter", fontSize: _getPropValueById('25:5739')?.fontSize ?? 13.5.sp, height: _getPropValueById('25:5739')?.lineHeight ?? 1.2857142857142858, letterSpacing: _getPropValueById('25:5739')?.letterSpacing ?? 0.w),),),
                                      Visibility(
                                        visible: _getPropValueById('25:5740')?.visible ?? true,
                                        child: SizedBox(
                                          width: _getPropValueById('25:5740')?.width ?? 263.w,
                                          height: _getPropValueById('25:5740')?.height ?? 20.h,
                                          child: SingleChildScrollView(
                                            clipBehavior: Clip.none,
                                            physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              constraints: BoxConstraints(minWidth: _getPropValueById('25:5740')?.width ?? 263.w, minHeight: _getPropValueById('25:5740')?.height ?? 20.h),
                                              child: Row(
                                                key: ValueKey("25:5740"),
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                spacing: 1.w,
                                                children: [
                                                  Visibility(
                                                    visible: _getPropValueById('25:5741')?.visible ?? true,
                                                    child: Text(_getPropValueById('25:5741')?.text ?? "Text",
                                                      key: ValueKey("25:5741"),
                                                      style: TextStyle(color: _getPropValueById('25:5741')?.textGradient == null? _getPropValueById('25:5741')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('25:5741')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5741')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5741')?.left ?? 0.w, _getPropValueById('25:5741')?.top ?? 0.h, _getPropValueById('25:5741')?.width ?? 29.w, _getPropValueById('25:5741')?.height ?? 20.h))): null, fontFamily: _getPropValueById('25:5741')?.fontFamily ?? "Inter", fontSize: _getPropValueById('25:5741')?.fontSize ?? 13.5.sp, height: _getPropValueById('25:5741')?.lineHeight ?? 1.4285714285714286, letterSpacing: _getPropValueById('25:5741')?.letterSpacing ?? 0.w),),),
                                                  Visibility(
                                                    visible: false,
                                                    child: Container(
                                                      width: 1.w,
                                                      height: 16.h,
                                                      child: Image(
                                                        key: ValueKey("25:5742"),
                                                        image: AssetImage("assets/images/Vector_25_5742.png"),),),),
                                                ],),),),),),
                                    ],),),),),),
                          Component_2_504({"2:504":PixFlutterInterface(width:16.w,height:16.w,left:263.w,top:16.h,supInterface:_getPropValueById('2:504'),),"2:505":PixFlutterInterface(width:16.w,height:13.67.h,left:0.w,top:1.16.h,supInterface:_getPropValueById('2:505'),),"2:506":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.72.w,top:0.h,supInterface:_getPropValueById('2:506'),),"2:507":PixFlutterInterface(width:16.w,height:10.91.h,left:0.w,top:1.38.h,supInterface:_getPropValueById('2:507'),),"2:508":PixFlutterInterface(width:16.w,height:10.91.h,supInterface:_getPropValueById('2:508'),),"2:509":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.17.w,top:-2.55.h,supInterface:_getPropValueById('2:509'),),"2:510":PixFlutterInterface(backgroundColor:Color.fromRGBO(143, 144, 152,1),width:16.w,height:16.w,supInterface:_getPropValueById('2:510'),),}, true),
                        ],),),),),),
              Visibility(
                visible: _getPropValueById('25:5744')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('25:5744')?.width ?? 295.w,
                  child: Text(_getPropValueById('25:5744')?.text ?? "Support text",
                    key: ValueKey("25:5744"),
                    style: TextStyle(color: _getPropValueById('25:5744')?.textGradient == null? _getPropValueById('25:5744')?.textColor ?? Color.fromRGBO(237, 50, 65,1): null, foreground: _getPropValueById('25:5744')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5744')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5744')?.left ?? 0.w, _getPropValueById('25:5744')?.top ?? 75.h, _getPropValueById('25:5744')?.width ?? 295.w, _getPropValueById('25:5744')?.height ?? 14.h))): null, fontFamily: _getPropValueById('25:5744')?.fontFamily ?? "Inter", fontSize: _getPropValueById('25:5744')?.fontSize ?? 9.5.sp, height: _getPropValueById('25:5744')?.lineHeight ?? 1.4, letterSpacing: _getPropValueById('25:5744')?.letterSpacing ?? 0.14999999664723873.w),),),),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          height: _getPropValueById('25:5735')?.height ?? 71.h,
          child: child
        )
      : Positioned(
          height: _getPropValueById('25:5735')?.height ?? 71.h,
          left: _getPropValueById('25:5735')?.left ?? 24.w,
          top: _getPropValueById('25:5735')?.top ?? 309.h,
          child: child
        );
  }
}

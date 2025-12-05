import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_504.dart';

class Component_2_471 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_471(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_471> createState() => _Component_2_471State();
}

class _Component_2_471State extends State<Component_2_471> {


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
      visible: _getPropValueById('2:471')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('2:471')?.width ?? 295.w, minHeight: _getPropValueById('2:471')?.height ?? 71.h),
          child: Column(
            key: ValueKey("2:471"),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              Visibility(
                visible: _getPropValueById('2:472')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('2:472')?.width ?? 295.w,
                  child: Text(_getPropValueById('2:472')?.text ?? "Title",
                    key: ValueKey("2:472"),
                    style: TextStyle(color: _getPropValueById('2:472')?.textGradient == null? _getPropValueById('2:472')?.textColor ?? Color.fromRGBO(47, 48, 54,1): null, foreground: _getPropValueById('2:472')?.textGradient != null? (Paint()..shader = _getPropValueById('2:472')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:472')?.left ?? 0.w, _getPropValueById('2:472')?.top ?? 0.h, _getPropValueById('2:472')?.width ?? 295.w, _getPropValueById('2:472')?.height ?? 15.h))): null, fontFamily: _getPropValueById('2:472')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:472')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:472')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('2:472')?.letterSpacing ?? 0.w),),),),
              Visibility(
                visible: _getPropValueById('2:473')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('2:473')?.width ?? 295.w,
                  height: _getPropValueById('2:473')?.height ?? 48.h,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('2:473')?.width ?? 295.w, minHeight: _getPropValueById('2:473')?.height ?? 48.h),
                      padding: EdgeInsets.only(left: 16.w,right: 16.w, top: 12.h,bottom: 12.h),
                      decoration: BoxDecoration(borderRadius: _getPropValueById('2:473')?.borderRadius ?? BorderRadius.circular(12.h),border: _getPropValueById('2:473')?.border ?? Border.all(width: 1.5.w, color: Color.fromRGBO(255, 97, 109,1), ),),
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        key: ValueKey("2:473"),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8.w,
                        children: [
                          Visibility(
                            visible: _getPropValueById('2:474')?.visible ?? true,
                            child: SizedBox(
                              width: _getPropValueById('2:474')?.width ?? 263.w,
                              height: _getPropValueById('2:474')?.height ?? 20.h,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  constraints: BoxConstraints(minWidth: _getPropValueById('2:474')?.width ?? 263.w, minHeight: _getPropValueById('2:474')?.height ?? 20.h),
                                  child: Row(
                                    key: ValueKey("2:474"),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 6.w,
                                    children: [
                                      Visibility(
                                        visible: _getPropValueById('2:475')?.visible ?? true,
                                        child: Text(_getPropValueById('2:475')?.text ?? "€",
                                          key: ValueKey("2:475"),
                                          style: TextStyle(color: _getPropValueById('2:475')?.textGradient == null? _getPropValueById('2:475')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('2:475')?.textGradient != null? (Paint()..shader = _getPropValueById('2:475')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:475')?.left ?? 0.w, _getPropValueById('2:475')?.top ?? 0.h, _getPropValueById('2:475')?.width ?? 10.w, _getPropValueById('2:475')?.height ?? 18.h))): null, fontFamily: _getPropValueById('2:475')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:475')?.fontSize ?? 13.5.sp, height: _getPropValueById('2:475')?.lineHeight ?? 1.2857142857142858, letterSpacing: _getPropValueById('2:475')?.letterSpacing ?? 0.w),),),
                                      Visibility(
                                        visible: _getPropValueById('2:476')?.visible ?? true,
                                        child: SizedBox(
                                          width: _getPropValueById('2:476')?.width ?? 263.w,
                                          height: _getPropValueById('2:476')?.height ?? 20.h,
                                          child: SingleChildScrollView(
                                            clipBehavior: Clip.none,
                                            physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              constraints: BoxConstraints(minWidth: _getPropValueById('2:476')?.width ?? 263.w, minHeight: _getPropValueById('2:476')?.height ?? 20.h),
                                              child: Row(
                                                key: ValueKey("2:476"),
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                spacing: 1.w,
                                                children: [
                                                  Visibility(
                                                    visible: _getPropValueById('2:477')?.visible ?? true,
                                                    child: Text(_getPropValueById('2:477')?.text ?? "Text",
                                                      key: ValueKey("2:477"),
                                                      style: TextStyle(color: _getPropValueById('2:477')?.textGradient == null? _getPropValueById('2:477')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:477')?.textGradient != null? (Paint()..shader = _getPropValueById('2:477')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:477')?.left ?? 0.w, _getPropValueById('2:477')?.top ?? 0.h, _getPropValueById('2:477')?.width ?? 29.w, _getPropValueById('2:477')?.height ?? 20.h))): null, fontFamily: _getPropValueById('2:477')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:477')?.fontSize ?? 13.5.sp, height: _getPropValueById('2:477')?.lineHeight ?? 1.4285714285714286, letterSpacing: _getPropValueById('2:477')?.letterSpacing ?? 0.w),),),
                                                  Visibility(
                                                    visible: false,
                                                    child: Container(
                                                      width: 1.w,
                                                      height: 16.h,
                                                      child: Image(
                                                        key: ValueKey("2:478"),
                                                        image: AssetImage("assets/images/Vector_2_478.png"),),),),
                                                ],),),),),),
                                    ],),),),),),
                          Component_2_504({"2:504":PixFlutterInterface(width:16.w,height:16.w,left:263.w,top:16.h,supInterface:_getPropValueById('2:504'),),"2:505":PixFlutterInterface(width:16.w,height:13.67.h,left:0.w,top:1.16.h,supInterface:_getPropValueById('2:505'),),"2:506":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.72.w,top:0.h,supInterface:_getPropValueById('2:506'),),"2:507":PixFlutterInterface(width:16.w,height:10.91.h,left:0.w,top:1.38.h,supInterface:_getPropValueById('2:507'),),"2:508":PixFlutterInterface(width:16.w,height:10.91.h,supInterface:_getPropValueById('2:508'),),"2:509":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.17.w,top:-2.55.h,supInterface:_getPropValueById('2:509'),),"2:510":PixFlutterInterface(backgroundColor:Color.fromRGBO(143, 144, 152,1),width:16.w,height:16.w,supInterface:_getPropValueById('2:510'),),}, true),
                        ],),),),),),
              Visibility(
                visible: _getPropValueById('2:480')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('2:480')?.width ?? 295.w,
                  child: Text(_getPropValueById('2:480')?.text ?? "Support text",
                    key: ValueKey("2:480"),
                    style: TextStyle(color: _getPropValueById('2:480')?.textGradient == null? _getPropValueById('2:480')?.textColor ?? Color.fromRGBO(237, 50, 65,1): null, foreground: _getPropValueById('2:480')?.textGradient != null? (Paint()..shader = _getPropValueById('2:480')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:480')?.left ?? 0.w, _getPropValueById('2:480')?.top ?? 75.h, _getPropValueById('2:480')?.width ?? 295.w, _getPropValueById('2:480')?.height ?? 14.h))): null, fontFamily: _getPropValueById('2:480')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:480')?.fontSize ?? 9.5.sp, height: _getPropValueById('2:480')?.lineHeight ?? 1.4, letterSpacing: _getPropValueById('2:480')?.letterSpacing ?? 0.14999999664723873.w),),),),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          height: _getPropValueById('2:471')?.height ?? 71.h,
          child: child
        )
      : Positioned(
          height: _getPropValueById('2:471')?.height ?? 71.h,
          left: _getPropValueById('2:471')?.left ?? 24.w,
          top: _getPropValueById('2:471')?.top ?? 309.h,
          child: child
        );
  }
}

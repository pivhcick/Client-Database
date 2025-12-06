import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_504.dart';

class Component_2_461 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_461(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_461> createState() => _Component_2_461State();
}

class _Component_2_461State extends State<Component_2_461> {


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
      visible: _getPropValueById('2:461')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('2:461')?.width ?? 295.w, minHeight: _getPropValueById('2:461')?.height ?? 71.h),
          child: Column(
            key: ValueKey("2:461"),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              Visibility(
                visible: _getPropValueById('2:462')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('2:462')?.width ?? 295.w,
                  child: Text(_getPropValueById('2:462')?.text ?? "Title",
                    key: ValueKey("2:462"),
                    style: TextStyle(color: _getPropValueById('2:462')?.textGradient == null? _getPropValueById('2:462')?.textColor ?? Color.fromRGBO(47, 48, 54,1): null, foreground: _getPropValueById('2:462')?.textGradient != null? (Paint()..shader = _getPropValueById('2:462')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:462')?.left ?? 0.w, _getPropValueById('2:462')?.top ?? 0.h, _getPropValueById('2:462')?.width ?? 295.w, _getPropValueById('2:462')?.height ?? 15.h))): null, fontFamily: _getPropValueById('2:462')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:462')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:462')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('2:462')?.letterSpacing ?? 0.w),),),),
              Visibility(
                visible: _getPropValueById('2:463')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('2:463')?.width ?? 295.w,
                  height: _getPropValueById('2:463')?.height ?? 48.h,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('2:463')?.width ?? 295.w, minHeight: _getPropValueById('2:463')?.height ?? 48.h),
                      padding: EdgeInsets.only(left: 16.w,right: 16.w, top: 12.h,bottom: 12.h),
                      decoration: BoxDecoration(borderRadius: _getPropValueById('2:463')?.borderRadius ?? BorderRadius.circular(12.h),border: _getPropValueById('2:463')?.border ?? Border.all(width: 1.w, color: Color.fromRGBO(197, 198, 204,1), ),),
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        key: ValueKey("2:463"),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8.w,
                        children: [
                          Visibility(
                            visible: _getPropValueById('2:464')?.visible ?? true,
                            child: SizedBox(
                              width: _getPropValueById('2:464')?.width ?? 263.w,
                              height: _getPropValueById('2:464')?.height ?? 20.h,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  constraints: BoxConstraints(minWidth: _getPropValueById('2:464')?.width ?? 263.w, minHeight: _getPropValueById('2:464')?.height ?? 20.h),
                                  child: Row(
                                    key: ValueKey("2:464"),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 6.w,
                                    children: [
                                      Visibility(
                                        visible: _getPropValueById('2:465')?.visible ?? true,
                                        child: Text(_getPropValueById('2:465')?.text ?? "€",
                                          key: ValueKey("2:465"),
                                          style: TextStyle(color: _getPropValueById('2:465')?.textGradient == null? _getPropValueById('2:465')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('2:465')?.textGradient != null? (Paint()..shader = _getPropValueById('2:465')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:465')?.left ?? 0.w, _getPropValueById('2:465')?.top ?? 0.h, _getPropValueById('2:465')?.width ?? 10.w, _getPropValueById('2:465')?.height ?? 18.h))): null, fontFamily: _getPropValueById('2:465')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:465')?.fontSize ?? 13.5.sp, height: _getPropValueById('2:465')?.lineHeight ?? 1.2857142857142858, letterSpacing: _getPropValueById('2:465')?.letterSpacing ?? 0.w),),),
                                      Visibility(
                                        visible: _getPropValueById('2:466')?.visible ?? true,
                                        child: SizedBox(
                                          width: _getPropValueById('2:466')?.width ?? 263.w,
                                          height: _getPropValueById('2:466')?.height ?? 20.h,
                                          child: SingleChildScrollView(
                                            clipBehavior: Clip.none,
                                            physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              constraints: BoxConstraints(minWidth: _getPropValueById('2:466')?.width ?? 263.w, minHeight: _getPropValueById('2:466')?.height ?? 20.h),
                                              child: Row(
                                                key: ValueKey("2:466"),
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                spacing: 1.w,
                                                children: [
                                                  Visibility(
                                                    visible: _getPropValueById('2:467')?.visible ?? true,
                                                    child: Text(_getPropValueById('2:467')?.text ?? "Text",
                                                      key: ValueKey("2:467"),
                                                      style: TextStyle(color: _getPropValueById('2:467')?.textGradient == null? _getPropValueById('2:467')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:467')?.textGradient != null? (Paint()..shader = _getPropValueById('2:467')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:467')?.left ?? 0.w, _getPropValueById('2:467')?.top ?? 0.h, _getPropValueById('2:467')?.width ?? 29.w, _getPropValueById('2:467')?.height ?? 20.h))): null, fontFamily: _getPropValueById('2:467')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:467')?.fontSize ?? 13.5.sp, height: _getPropValueById('2:467')?.lineHeight ?? 1.4285714285714286, letterSpacing: _getPropValueById('2:467')?.letterSpacing ?? 0.w),),),
                                                  Visibility(
                                                    visible: false,
                                                    child: Container(
                                                      width: 1.w,
                                                      height: 16.h,
                                                      child: Image(
                                                        key: ValueKey("2:468"),
                                                        image: AssetImage("assets/images/Vector_2_468.png"),),),),
                                                ],),),),),),
                                    ],),),),),),
                          Component_2_504({"2:504":PixFlutterInterface(width:16.w,height:16.w,left:263.w,top:16.h,supInterface:_getPropValueById('2:504'),),"2:505":PixFlutterInterface(width:16.w,height:13.67.h,left:0.w,top:1.16.h,supInterface:_getPropValueById('2:505'),),"2:506":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.72.w,top:0.h,supInterface:_getPropValueById('2:506'),),"2:507":PixFlutterInterface(width:16.w,height:10.91.h,left:0.w,top:1.38.h,supInterface:_getPropValueById('2:507'),),"2:508":PixFlutterInterface(width:16.w,height:10.91.h,supInterface:_getPropValueById('2:508'),),"2:509":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.17.w,top:-2.55.h,supInterface:_getPropValueById('2:509'),),"2:510":PixFlutterInterface(backgroundColor:Color.fromRGBO(143, 144, 152,1),width:16.w,height:16.w,supInterface:_getPropValueById('2:510'),),}, true),
                        ],),),),),),
              Visibility(
                visible: _getPropValueById('2:470')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('2:470')?.width ?? 295.w,
                  child: Text(_getPropValueById('2:470')?.text ?? "Support text",
                    key: ValueKey("2:470"),
                    style: TextStyle(color: _getPropValueById('2:470')?.textGradient == null? _getPropValueById('2:470')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('2:470')?.textGradient != null? (Paint()..shader = _getPropValueById('2:470')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:470')?.left ?? 0.w, _getPropValueById('2:470')?.top ?? 75.h, _getPropValueById('2:470')?.width ?? 295.w, _getPropValueById('2:470')?.height ?? 14.h))): null, fontFamily: _getPropValueById('2:470')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:470')?.fontSize ?? 9.5.sp, height: _getPropValueById('2:470')?.lineHeight ?? 1.4, letterSpacing: _getPropValueById('2:470')?.letterSpacing ?? 0.14999999664723873.w),),),),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          height: _getPropValueById('2:461')?.height ?? 71.h,
          child: child
        )
      : Positioned(
          height: _getPropValueById('2:461')?.height ?? 71.h,
          left: _getPropValueById('2:461')?.left ?? 24.w,
          top: _getPropValueById('2:461')?.top ?? 214.h,
          child: child
        );
  }
}

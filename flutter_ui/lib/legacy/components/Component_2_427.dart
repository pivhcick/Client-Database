import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'dart:ui';

class Component_2_427 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_427(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_427> createState() => _Component_2_427State();
}

class _Component_2_427State extends State<Component_2_427> {


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
      visible: _getPropValueById('2:427')?.visible ?? true,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(
            decoration: BoxDecoration(color: _getPropValueById('2:427')?.backgroundColor ?? Color.fromRGBO(255, 255, 255,1),),
            child: Stack(
              key: ValueKey("2:427"),
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  width: _getPropValueById('2:428')?.width ?? 53.71.w,
                  height: _getPropValueById('2:428')?.height ?? 18.h,
                  left: _getPropValueById('2:428')?.left ?? 19.89.w,
                  top: _getPropValueById('2:428')?.top ?? 14.h,
                  child: Visibility(
                    visible: _getPropValueById('2:428')?.visible ?? true,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(),
                      child: Stack(
                        key: ValueKey("2:428"),
                        children: [
                          Positioned(
                            width: _getPropValueById('2:429')?.width ?? 54.w,
                            left: _getPropValueById('2:429')?.left ?? 0.w,
                            top: _getPropValueById('2:429')?.top ?? 0.h,
                            child: Visibility(
                              visible: _getPropValueById('2:429')?.visible ?? true,
                              child: Text(_getPropValueById('2:429')?.text ?? "9:41",
                                key: ValueKey("2:429"),
                                textAlign: _getPropValueById('2:429')?.textAlign ?? TextAlign.center,
                                style: TextStyle(color: _getPropValueById('2:429')?.textGradient == null? _getPropValueById('2:429')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:429')?.textGradient != null? (Paint()..shader = _getPropValueById('2:429')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:429')?.left ?? 0.w, _getPropValueById('2:429')?.top ?? 0.h, _getPropValueById('2:429')?.width ?? 54.w, _getPropValueById('2:429')?.height ?? 18.h))): null, fontFamily: _getPropValueById('2:429')?.fontFamily ?? "SF Pro Text", fontWeight: _getPropValueById('2:429')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:429')?.fontSize ?? 14.5.sp, letterSpacing: _getPropValueById('2:429')?.letterSpacing ?? -0.17.w),),),),
                        ],),),),),
                Positioned(
                  width: _getPropValueById('2:430')?.width ?? 68.w,
                  height: _getPropValueById('2:430')?.height ?? 14.h,
                  left: _getPropValueById('2:430')?.left ?? 293.w,
                  top: _getPropValueById('2:430')?.top ?? 16.h,
                  child: Visibility(
                    visible: _getPropValueById('2:430')?.visible ?? true,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(),
                      child: Stack(
                        key: ValueKey("2:430"),
                        children: [
                          Positioned(
                            left: _getPropValueById('2:431')?.left ?? 41.w,
                            top: _getPropValueById('2:431')?.top ?? -3.h,
                            child: Visibility(
                              visible: _getPropValueById('2:431')?.visible ?? true,
                              child: Text(_getPropValueById('2:431')?.text ?? "􀛨",
                                key: ValueKey("2:431"),
                                style: TextStyle(color: _getPropValueById('2:431')?.textGradient == null? _getPropValueById('2:431')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:431')?.textGradient != null? (Paint()..shader = _getPropValueById('2:431')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:431')?.left ?? 41.w, _getPropValueById('2:431')?.top ?? -3.h, _getPropValueById('2:431')?.width ?? 29.w, _getPropValueById('2:431')?.height ?? 20.h))): null, fontFamily: _getPropValueById('2:431')?.fontFamily ?? "SF Pro Text", fontSize: _getPropValueById('2:431')?.fontSize ?? 16.5.sp),),),),
                          Positioned(
                            width: 17.1.w,
                            height: 10.7.h,
                            left: 0.5.w,
                            top: 1.6.h,
                            child: Image(
                              key: ValueKey("2:432"),
                              image: AssetImage("assets/images/Boolean_operation_2_432.png"),),),
                          Positioned(
                            left: _getPropValueById('2:437')?.left ?? 21.w,
                            top: _getPropValueById('2:437')?.top ?? -1.h,
                            child: Visibility(
                              visible: _getPropValueById('2:437')?.visible ?? true,
                              child: Text(_getPropValueById('2:437')?.text ?? "􀙇",
                                key: ValueKey("2:437"),
                                style: TextStyle(color: _getPropValueById('2:437')?.textGradient == null? _getPropValueById('2:437')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:437')?.textGradient != null? (Paint()..shader = _getPropValueById('2:437')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:437')?.left ?? 21.w, _getPropValueById('2:437')?.top ?? -1.h, _getPropValueById('2:437')?.width ?? 19.w, _getPropValueById('2:437')?.height ?? 17.h))): null, fontFamily: _getPropValueById('2:437')?.fontFamily ?? "SF Pro Text", fontSize: _getPropValueById('2:437')?.fontSize ?? 13.5.sp),),),),
                        ],),),),),
              ],),),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:427')?.width ?? 375.w,
          height: _getPropValueById('2:427')?.height ?? 44.h,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:427')?.width ?? 375.w,
          height: _getPropValueById('2:427')?.height ?? 44.h,
          left: _getPropValueById('2:427')?.left ?? 12690.w,
          top: _getPropValueById('2:427')?.top ?? 538.h,
          child: child
        );
  }
}

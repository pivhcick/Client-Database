import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Size.dart';
import 'package:flutter_ui/components/ArrowRight.dart';

class Component_25_1789 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_25_1789(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_25_1789> createState() => _Component_25_1789State();
}

class _Component_25_1789State extends State<Component_25_1789> {


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
      visible: _getPropValueById('25:1789')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('25:1789')?.width ?? 327.w, minHeight: _getPropValueById('25:1789')?.height ?? 90.h),
          padding: EdgeInsets.only(left: 16.w,right: 16.w, top: 16.h,bottom: 16.h),
          decoration: BoxDecoration(color: _getPropValueById('25:1789')?.backgroundColor ?? Color.fromRGBO(245, 246, 250,1),borderRadius: _getPropValueById('25:1789')?.borderRadius ?? BorderRadius.circular(12.h),),
          child: Row(
            key: ValueKey("25:1789"),
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16.w,
            children: [
              Visibility(
                visible: _getPropValueById('25:1790')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('25:1790')?.width ?? 40.w,
                  height: _getPropValueById('25:1790')?.height ?? 58.h,
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('25:1790')?.width ?? 40.w, minHeight: _getPropValueById('25:1790')?.height ?? 58.h),
                      child: Column(
                        key: ValueKey("25:1790"),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10.h,
                        children: [
                          Size({"2:180":PixFlutterInterface(width:40.w,height:40.w,left:0.w,top:0.h,supInterface:_getPropValueById('2:180'),),}, true),
                        ],),),),),),
              Visibility(
                visible: _getPropValueById('25:1792')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('25:1792')?.width ?? 199.w,
                  height: _getPropValueById('25:1792')?.height ?? 58.h,
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('25:1792')?.width ?? 199.w, minHeight: _getPropValueById('25:1792')?.height ?? 58.h),
                      child: Column(
                        key: ValueKey("25:1792"),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4.h,
                        children: [
                          Visibility(
                            visible: _getPropValueById('25:1793')?.visible ?? true,
                            child: Container(
                              width: _getPropValueById('25:1793')?.width ?? 199.w,
                              child: Text(_getPropValueById('25:1793')?.text ?? "Фамилия Имя Отчество",
                                key: ValueKey("25:1793"),
                                style: TextStyle(color: _getPropValueById('25:1793')?.textGradient == null? _getPropValueById('25:1793')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('25:1793')?.textGradient != null? (Paint()..shader = _getPropValueById('25:1793')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:1793')?.left ?? 0.w, _getPropValueById('25:1793')?.top ?? 0.h, _getPropValueById('25:1793')?.width ?? 199.w, _getPropValueById('25:1793')?.height ?? 18.h))): null, fontFamily: _getPropValueById('25:1793')?.fontFamily ?? "Sora", fontSize: _getPropValueById('25:1793')?.fontSize ?? 13.5.sp, height: _getPropValueById('25:1793')?.lineHeight ?? 0.07142857142857142, letterSpacing: _getPropValueById('25:1793')?.letterSpacing ?? 0.w),),),),
                          Visibility(
                            visible: _getPropValueById('25:1794')?.visible ?? true,
                            child: Container(
                              width: _getPropValueById('25:1794')?.width ?? 199.w,
                              child: Text(_getPropValueById('25:1794')?.text ?? "+7 925 232 83 73 beer_andrey@mail.ru",
                                key: ValueKey("25:1794"),
                                style: TextStyle(color: _getPropValueById('25:1794')?.textGradient == null? _getPropValueById('25:1794')?.textColor ?? Color.fromRGBO(113, 114, 122,1): null, foreground: _getPropValueById('25:1794')?.textGradient != null? (Paint()..shader = _getPropValueById('25:1794')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:1794')?.left ?? 0.w, _getPropValueById('25:1794')?.top ?? 22.h, _getPropValueById('25:1794')?.width ?? 199.w, _getPropValueById('25:1794')?.height ?? 36.h))): null, fontFamily: _getPropValueById('25:1794')?.fontFamily ?? "Sora", fontSize: _getPropValueById('25:1794')?.fontSize ?? 13.5.sp, height: _getPropValueById('25:1794')?.lineHeight ?? 0.07142857142857142, letterSpacing: _getPropValueById('25:1794')?.letterSpacing ?? 0.14.w),),),),
                        ],),),),),),
              Visibility(
                visible: _getPropValueById('25:1795')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('25:1795')?.width ?? 12.w,
                  height: _getPropValueById('25:1795')?.height ?? 12.h,
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('25:1795')?.width ?? 12.w, minHeight: _getPropValueById('25:1795')?.height ?? 12.h),
                      child: Column(
                        key: ValueKey("25:1795"),
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8.h,
                        children: [
                          ArrowRight({"2:197":PixFlutterInterface(width:12.w,height:12.w,left:0.w,top:0.h,supInterface:_getPropValueById('2:197'),),"2:198":PixFlutterInterface(width:7.w,height:11.5.h,left:9.5.w,top:0.25.h,supInterface:_getPropValueById('2:198'),),"2:199":PixFlutterInterface(width:12.w,height:12.w,left:0.w,top:0.h,supInterface:_getPropValueById('2:199'),),}, true),
                        ],),),),),),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('25:1789')?.width ?? 327.w,
          child: child
        )
      : Positioned(
          width: _getPropValueById('25:1789')?.width ?? 327.w,
          left: _getPropValueById('25:1789')?.left ?? 0.w,
          top: _getPropValueById('25:1789')?.top ?? 0.h,
          child: child
        );
  }
}

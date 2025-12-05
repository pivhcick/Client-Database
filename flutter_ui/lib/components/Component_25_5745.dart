import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_504.dart';

class Component_25_5745 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_25_5745(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_25_5745> createState() => _Component_25_5745State();
}

class _Component_25_5745State extends State<Component_25_5745> {


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
      visible: _getPropValueById('25:5745')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('25:5745')?.width ?? 295.w, minHeight: _getPropValueById('25:5745')?.height ?? 71.h),
          child: Column(
            key: ValueKey("25:5745"),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              Visibility(
                visible: _getPropValueById('25:5746')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('25:5746')?.width ?? 295.w,
                  child: Text(_getPropValueById('25:5746')?.text ?? "Title",
                    key: ValueKey("25:5746"),
                    style: TextStyle(color: _getPropValueById('25:5746')?.textGradient == null? _getPropValueById('25:5746')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('25:5746')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5746')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5746')?.left ?? 0.w, _getPropValueById('25:5746')?.top ?? 0.h, _getPropValueById('25:5746')?.width ?? 295.w, _getPropValueById('25:5746')?.height ?? 15.h))): null, fontFamily: _getPropValueById('25:5746')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('25:5746')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('25:5746')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('25:5746')?.letterSpacing ?? 0.w),),),),
              Visibility(
                visible: _getPropValueById('25:5747')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('25:5747')?.width ?? 295.w,
                  height: _getPropValueById('25:5747')?.height ?? 48.h,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('25:5747')?.width ?? 295.w, minHeight: _getPropValueById('25:5747')?.height ?? 48.h),
                      padding: EdgeInsets.only(left: 16.w,right: 16.w, top: 12.h,bottom: 12.h),
                      decoration: BoxDecoration(color: _getPropValueById('25:5747')?.backgroundColor ?? Color.fromRGBO(248, 249, 254,1),borderRadius: _getPropValueById('25:5747')?.borderRadius ?? BorderRadius.circular(12.h),border: _getPropValueById('25:5747')?.border ?? Border.all(width: 1.w, color: Color.fromRGBO(197, 198, 204,1), ),),
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        key: ValueKey("25:5747"),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8.w,
                        children: [
                          Visibility(
                            visible: _getPropValueById('25:5748')?.visible ?? true,
                            child: SizedBox(
                              width: _getPropValueById('25:5748')?.width ?? 263.w,
                              height: _getPropValueById('25:5748')?.height ?? 20.h,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  constraints: BoxConstraints(minWidth: _getPropValueById('25:5748')?.width ?? 263.w, minHeight: _getPropValueById('25:5748')?.height ?? 20.h),
                                  child: Row(
                                    key: ValueKey("25:5748"),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 6.w,
                                    children: [
                                      Visibility(
                                        visible: _getPropValueById('25:5749')?.visible ?? true,
                                        child: Text(_getPropValueById('25:5749')?.text ?? "€",
                                          key: ValueKey("25:5749"),
                                          style: TextStyle(color: _getPropValueById('25:5749')?.textGradient == null? _getPropValueById('25:5749')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('25:5749')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5749')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5749')?.left ?? 0.w, _getPropValueById('25:5749')?.top ?? 0.h, _getPropValueById('25:5749')?.width ?? 10.w, _getPropValueById('25:5749')?.height ?? 18.h))): null, fontFamily: _getPropValueById('25:5749')?.fontFamily ?? "Inter", fontSize: _getPropValueById('25:5749')?.fontSize ?? 13.5.sp, height: _getPropValueById('25:5749')?.lineHeight ?? 1.2857142857142858, letterSpacing: _getPropValueById('25:5749')?.letterSpacing ?? 0.w),),),
                                      Visibility(
                                        visible: _getPropValueById('25:5750')?.visible ?? true,
                                        child: SizedBox(
                                          width: _getPropValueById('25:5750')?.width ?? 263.w,
                                          height: _getPropValueById('25:5750')?.height ?? 20.h,
                                          child: SingleChildScrollView(
                                            clipBehavior: Clip.none,
                                            physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              constraints: BoxConstraints(minWidth: _getPropValueById('25:5750')?.width ?? 263.w, minHeight: _getPropValueById('25:5750')?.height ?? 20.h),
                                              child: Row(
                                                key: ValueKey("25:5750"),
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                spacing: 1.w,
                                                children: [
                                                  Visibility(
                                                    visible: _getPropValueById('25:5751')?.visible ?? true,
                                                    child: Text(_getPropValueById('25:5751')?.text ?? "Text",
                                                      key: ValueKey("25:5751"),
                                                      style: TextStyle(color: _getPropValueById('25:5751')?.textGradient == null? _getPropValueById('25:5751')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('25:5751')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5751')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5751')?.left ?? 0.w, _getPropValueById('25:5751')?.top ?? 0.h, _getPropValueById('25:5751')?.width ?? 29.w, _getPropValueById('25:5751')?.height ?? 20.h))): null, fontFamily: _getPropValueById('25:5751')?.fontFamily ?? "Inter", fontSize: _getPropValueById('25:5751')?.fontSize ?? 13.5.sp, height: _getPropValueById('25:5751')?.lineHeight ?? 1.4285714285714286, letterSpacing: _getPropValueById('25:5751')?.letterSpacing ?? 0.w),),),
                                                  Visibility(
                                                    visible: false,
                                                    child: Container(
                                                      width: 1.w,
                                                      height: 16.h,
                                                      child: Image(
                                                        key: ValueKey("25:5752"),
                                                        image: AssetImage("assets/images/Vector_25_5752.png"),),),),
                                                ],),),),),),
                                    ],),),),),),
                          Component_2_504({"2:504":PixFlutterInterface(width:16.w,height:16.w,left:263.w,top:16.h,supInterface:_getPropValueById('2:504'),),"2:505":PixFlutterInterface(width:16.w,height:13.67.h,left:0.w,top:1.16.h,supInterface:_getPropValueById('2:505'),),"2:506":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.72.w,top:0.h,supInterface:_getPropValueById('2:506'),),"2:507":PixFlutterInterface(width:16.w,height:10.91.h,left:0.w,top:1.38.h,supInterface:_getPropValueById('2:507'),),"2:508":PixFlutterInterface(width:16.w,height:10.91.h,supInterface:_getPropValueById('2:508'),),"2:509":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.17.w,top:-2.55.h,supInterface:_getPropValueById('2:509'),),"2:510":PixFlutterInterface(backgroundColor:Color.fromRGBO(143, 144, 152,1),width:16.w,height:16.w,supInterface:_getPropValueById('2:510'),),}, true),
                        ],),),),),),
              Visibility(
                visible: _getPropValueById('25:5754')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('25:5754')?.width ?? 295.w,
                  child: Text(_getPropValueById('25:5754')?.text ?? "Support text",
                    key: ValueKey("25:5754"),
                    style: TextStyle(color: _getPropValueById('25:5754')?.textGradient == null? _getPropValueById('25:5754')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('25:5754')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5754')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5754')?.left ?? 0.w, _getPropValueById('25:5754')?.top ?? 75.h, _getPropValueById('25:5754')?.width ?? 295.w, _getPropValueById('25:5754')?.height ?? 14.h))): null, fontFamily: _getPropValueById('25:5754')?.fontFamily ?? "Inter", fontSize: _getPropValueById('25:5754')?.fontSize ?? 9.5.sp, height: _getPropValueById('25:5754')?.lineHeight ?? 1.4, letterSpacing: _getPropValueById('25:5754')?.letterSpacing ?? 0.14999999664723873.w),),),),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          height: _getPropValueById('25:5745')?.height ?? 71.h,
          child: child
        )
      : Positioned(
          height: _getPropValueById('25:5745')?.height ?? 71.h,
          left: _getPropValueById('25:5745')?.left ?? 24.w,
          top: _getPropValueById('25:5745')?.top ?? 404.h,
          child: child
        );
  }
}

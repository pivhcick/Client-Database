import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_504.dart';

class Component_25_5715 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_25_5715(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_25_5715> createState() => _Component_25_5715State();
}

class _Component_25_5715State extends State<Component_25_5715> {


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
      visible: _getPropValueById('25:5715')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('25:5715')?.width ?? 295.w, minHeight: _getPropValueById('25:5715')?.height ?? 71.h),
          child: Column(
            key: ValueKey("25:5715"),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              Visibility(
                visible: _getPropValueById('25:5716')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('25:5716')?.width ?? 295.w,
                  child: Text(_getPropValueById('25:5716')?.text ?? "Title",
                    key: ValueKey("25:5716"),
                    style: TextStyle(color: _getPropValueById('25:5716')?.textGradient == null? _getPropValueById('25:5716')?.textColor ?? Color.fromRGBO(47, 48, 54,1): null, foreground: _getPropValueById('25:5716')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5716')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5716')?.left ?? 0.w, _getPropValueById('25:5716')?.top ?? 0.h, _getPropValueById('25:5716')?.width ?? 295.w, _getPropValueById('25:5716')?.height ?? 15.h))): null, fontFamily: _getPropValueById('25:5716')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('25:5716')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('25:5716')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('25:5716')?.letterSpacing ?? 0.w),),),),
              Visibility(
                visible: _getPropValueById('25:5717')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('25:5717')?.width ?? 295.w,
                  height: _getPropValueById('25:5717')?.height ?? 48.h,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('25:5717')?.width ?? 295.w, minHeight: _getPropValueById('25:5717')?.height ?? 48.h),
                      padding: EdgeInsets.only(left: 16.w,right: 16.w, top: 12.h,bottom: 12.h),
                      decoration: BoxDecoration(borderRadius: _getPropValueById('25:5717')?.borderRadius ?? BorderRadius.circular(12.h),border: _getPropValueById('25:5717')?.border ?? Border.all(width: 1.5.w, color: Color.fromRGBO(0, 111, 253,1), ),),
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        key: ValueKey("25:5717"),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8.w,
                        children: [
                          Visibility(
                            visible: _getPropValueById('25:5718')?.visible ?? true,
                            child: SizedBox(
                              width: _getPropValueById('25:5718')?.width ?? 263.w,
                              height: _getPropValueById('25:5718')?.height ?? 20.h,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  constraints: BoxConstraints(minWidth: _getPropValueById('25:5718')?.width ?? 263.w, minHeight: _getPropValueById('25:5718')?.height ?? 20.h),
                                  child: Row(
                                    key: ValueKey("25:5718"),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 6.w,
                                    children: [
                                      Visibility(
                                        visible: _getPropValueById('25:5719')?.visible ?? true,
                                        child: Text(_getPropValueById('25:5719')?.text ?? "€",
                                          key: ValueKey("25:5719"),
                                          style: TextStyle(color: _getPropValueById('25:5719')?.textGradient == null? _getPropValueById('25:5719')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('25:5719')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5719')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5719')?.left ?? 0.w, _getPropValueById('25:5719')?.top ?? 0.h, _getPropValueById('25:5719')?.width ?? 10.w, _getPropValueById('25:5719')?.height ?? 18.h))): null, fontFamily: _getPropValueById('25:5719')?.fontFamily ?? "Inter", fontSize: _getPropValueById('25:5719')?.fontSize ?? 13.5.sp, height: _getPropValueById('25:5719')?.lineHeight ?? 1.2857142857142858, letterSpacing: _getPropValueById('25:5719')?.letterSpacing ?? 0.w),),),
                                      Visibility(
                                        visible: _getPropValueById('25:5720')?.visible ?? true,
                                        child: SizedBox(
                                          width: _getPropValueById('25:5720')?.width ?? 263.w,
                                          height: _getPropValueById('25:5720')?.height ?? 20.h,
                                          child: SingleChildScrollView(
                                            clipBehavior: Clip.none,
                                            physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              constraints: BoxConstraints(minWidth: _getPropValueById('25:5720')?.width ?? 263.w, minHeight: _getPropValueById('25:5720')?.height ?? 20.h),
                                              child: Row(
                                                key: ValueKey("25:5720"),
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                spacing: 1.w,
                                                children: [
                                                  Visibility(
                                                    visible: _getPropValueById('25:5721')?.visible ?? true,
                                                    child: Text(_getPropValueById('25:5721')?.text ?? "Text",
                                                      key: ValueKey("25:5721"),
                                                      style: TextStyle(color: _getPropValueById('25:5721')?.textGradient == null? _getPropValueById('25:5721')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('25:5721')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5721')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5721')?.left ?? 0.w, _getPropValueById('25:5721')?.top ?? 0.h, _getPropValueById('25:5721')?.width ?? 29.w, _getPropValueById('25:5721')?.height ?? 20.h))): null, fontFamily: _getPropValueById('25:5721')?.fontFamily ?? "Inter", fontSize: _getPropValueById('25:5721')?.fontSize ?? 13.5.sp, height: _getPropValueById('25:5721')?.lineHeight ?? 1.4285714285714286, letterSpacing: _getPropValueById('25:5721')?.letterSpacing ?? 0.w),),),
                                                  Container(
                                                    width: 1.w,
                                                    height: 16.h,
                                                    child: Image(
                                                      key: ValueKey("25:5722"),
                                                      image: AssetImage("assets/images/Vector_25_5722.png"),),),
                                                ],),),),),),
                                    ],),),),),),
                          Component_2_504({"2:504":PixFlutterInterface(width:16.w,height:16.w,left:263.w,top:16.h,supInterface:_getPropValueById('2:504'),),"2:505":PixFlutterInterface(width:16.w,height:13.67.h,left:0.w,top:1.16.h,supInterface:_getPropValueById('2:505'),),"2:506":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.72.w,top:0.h,supInterface:_getPropValueById('2:506'),),"2:507":PixFlutterInterface(width:16.w,height:10.91.h,left:0.w,top:1.38.h,supInterface:_getPropValueById('2:507'),),"2:508":PixFlutterInterface(width:16.w,height:10.91.h,supInterface:_getPropValueById('2:508'),),"2:509":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.17.w,top:-2.55.h,supInterface:_getPropValueById('2:509'),),"2:510":PixFlutterInterface(backgroundColor:Color.fromRGBO(143, 144, 152,1),width:16.w,height:16.w,supInterface:_getPropValueById('2:510'),),}, true),
                        ],),),),),),
              Visibility(
                visible: _getPropValueById('25:5724')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('25:5724')?.width ?? 295.w,
                  child: Text(_getPropValueById('25:5724')?.text ?? "Support text",
                    key: ValueKey("25:5724"),
                    style: TextStyle(color: _getPropValueById('25:5724')?.textGradient == null? _getPropValueById('25:5724')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('25:5724')?.textGradient != null? (Paint()..shader = _getPropValueById('25:5724')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('25:5724')?.left ?? 0.w, _getPropValueById('25:5724')?.top ?? 75.h, _getPropValueById('25:5724')?.width ?? 295.w, _getPropValueById('25:5724')?.height ?? 14.h))): null, fontFamily: _getPropValueById('25:5724')?.fontFamily ?? "Inter", fontSize: _getPropValueById('25:5724')?.fontSize ?? 9.5.sp, height: _getPropValueById('25:5724')?.lineHeight ?? 1.4, letterSpacing: _getPropValueById('25:5724')?.letterSpacing ?? 0.14999999664723873.w),),),),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          height: _getPropValueById('25:5715')?.height ?? 71.h,
          child: child
        )
      : Positioned(
          height: _getPropValueById('25:5715')?.height ?? 71.h,
          left: _getPropValueById('25:5715')?.left ?? 24.w,
          top: _getPropValueById('25:5715')?.top ?? 119.h,
          child: child
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_504.dart';

class Component_2_441 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_441(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_441> createState() => _Component_2_441State();
}

class _Component_2_441State extends State<Component_2_441> {


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
      visible: _getPropValueById('2:441')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('2:441')?.width ?? 295.w, minHeight: _getPropValueById('2:441')?.height ?? 71.h),
          child: Column(
            key: ValueKey("2:441"),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              Visibility(
                visible: _getPropValueById('2:442')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('2:442')?.width ?? 295.w,
                  child: Text(_getPropValueById('2:442')?.text ?? "Title",
                    key: ValueKey("2:442"),
                    style: TextStyle(color: _getPropValueById('2:442')?.textGradient == null? _getPropValueById('2:442')?.textColor ?? Color.fromRGBO(47, 48, 54,1): null, foreground: _getPropValueById('2:442')?.textGradient != null? (Paint()..shader = _getPropValueById('2:442')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:442')?.left ?? 0.w, _getPropValueById('2:442')?.top ?? 0.h, _getPropValueById('2:442')?.width ?? 295.w, _getPropValueById('2:442')?.height ?? 15.h))): null, fontFamily: _getPropValueById('2:442')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:442')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:442')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('2:442')?.letterSpacing ?? 0.w),),),),
              Visibility(
                visible: _getPropValueById('2:443')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('2:443')?.width ?? 295.w,
                  height: _getPropValueById('2:443')?.height ?? 48.h,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('2:443')?.width ?? 295.w, minHeight: _getPropValueById('2:443')?.height ?? 48.h),
                      padding: EdgeInsets.only(left: 16.w,right: 16.w, top: 12.h,bottom: 12.h),
                      decoration: BoxDecoration(borderRadius: _getPropValueById('2:443')?.borderRadius ?? BorderRadius.circular(12.h),border: _getPropValueById('2:443')?.border ?? Border.all(width: 1.w, color: Color.fromRGBO(197, 198, 204,1), ),),
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        key: ValueKey("2:443"),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8.w,
                        children: [
                          Visibility(
                            visible: _getPropValueById('2:444')?.visible ?? true,
                            child: SizedBox(
                              width: _getPropValueById('2:444')?.width ?? 263.w,
                              height: _getPropValueById('2:444')?.height ?? 20.h,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  constraints: BoxConstraints(minWidth: _getPropValueById('2:444')?.width ?? 263.w, minHeight: _getPropValueById('2:444')?.height ?? 20.h),
                                  child: Row(
                                    key: ValueKey("2:444"),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 6.w,
                                    children: [
                                      Visibility(
                                        visible: _getPropValueById('2:445')?.visible ?? true,
                                        child: Text(_getPropValueById('2:445')?.text ?? "€",
                                          key: ValueKey("2:445"),
                                          style: TextStyle(color: _getPropValueById('2:445')?.textGradient == null? _getPropValueById('2:445')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('2:445')?.textGradient != null? (Paint()..shader = _getPropValueById('2:445')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:445')?.left ?? 0.w, _getPropValueById('2:445')?.top ?? 0.h, _getPropValueById('2:445')?.width ?? 10.w, _getPropValueById('2:445')?.height ?? 18.h))): null, fontFamily: _getPropValueById('2:445')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:445')?.fontSize ?? 13.5.sp, height: _getPropValueById('2:445')?.lineHeight ?? 1.2857142857142858, letterSpacing: _getPropValueById('2:445')?.letterSpacing ?? 0.w),),),
                                      Visibility(
                                        visible: _getPropValueById('2:446')?.visible ?? true,
                                        child: SizedBox(
                                          width: _getPropValueById('2:446')?.width ?? 263.w,
                                          height: _getPropValueById('2:446')?.height ?? 20.h,
                                          child: SingleChildScrollView(
                                            clipBehavior: Clip.none,
                                            physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              constraints: BoxConstraints(minWidth: _getPropValueById('2:446')?.width ?? 263.w, minHeight: _getPropValueById('2:446')?.height ?? 20.h),
                                              child: Row(
                                                key: ValueKey("2:446"),
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                spacing: 1.w,
                                                children: [
                                                  Visibility(
                                                    visible: _getPropValueById('2:447')?.visible ?? true,
                                                    child: Text(_getPropValueById('2:447')?.text ?? "Placeholder",
                                                      key: ValueKey("2:447"),
                                                      style: TextStyle(color: _getPropValueById('2:447')?.textGradient == null? _getPropValueById('2:447')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('2:447')?.textGradient != null? (Paint()..shader = _getPropValueById('2:447')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:447')?.left ?? 0.w, _getPropValueById('2:447')?.top ?? 0.h, _getPropValueById('2:447')?.width ?? 79.w, _getPropValueById('2:447')?.height ?? 20.h))): null, fontFamily: _getPropValueById('2:447')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:447')?.fontSize ?? 13.5.sp, height: _getPropValueById('2:447')?.lineHeight ?? 1.4285714285714286, letterSpacing: _getPropValueById('2:447')?.letterSpacing ?? 0.w),),),
                                                  Visibility(
                                                    visible: false,
                                                    child: Container(
                                                      width: 1.w,
                                                      height: 16.h,
                                                      child: Image(
                                                        key: ValueKey("2:448"),
                                                        image: AssetImage("assets/images/Vector_2_448.png"),),),),
                                                ],),),),),),
                                    ],),),),),),
                          Component_2_504({"2:504":PixFlutterInterface(width:16.w,height:16.w,left:263.w,top:16.h,supInterface:_getPropValueById('2:504'),),"2:505":PixFlutterInterface(width:16.w,height:13.67.h,left:0.w,top:1.16.h,supInterface:_getPropValueById('2:505'),),"2:506":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.72.w,top:0.h,supInterface:_getPropValueById('2:506'),),"2:507":PixFlutterInterface(width:16.w,height:10.91.h,left:0.w,top:1.38.h,supInterface:_getPropValueById('2:507'),),"2:508":PixFlutterInterface(width:16.w,height:10.91.h,supInterface:_getPropValueById('2:508'),),"2:509":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.17.w,top:-2.55.h,supInterface:_getPropValueById('2:509'),),"2:510":PixFlutterInterface(backgroundColor:Color.fromRGBO(143, 144, 152,1),width:16.w,height:16.w,supInterface:_getPropValueById('2:510'),),}, true),
                        ],),),),),),
              Visibility(
                visible: _getPropValueById('2:450')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('2:450')?.width ?? 295.w,
                  child: Text(_getPropValueById('2:450')?.text ?? "Support text",
                    key: ValueKey("2:450"),
                    style: TextStyle(color: _getPropValueById('2:450')?.textGradient == null? _getPropValueById('2:450')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('2:450')?.textGradient != null? (Paint()..shader = _getPropValueById('2:450')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:450')?.left ?? 0.w, _getPropValueById('2:450')?.top ?? 75.h, _getPropValueById('2:450')?.width ?? 295.w, _getPropValueById('2:450')?.height ?? 14.h))): null, fontFamily: _getPropValueById('2:450')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:450')?.fontSize ?? 9.5.sp, height: _getPropValueById('2:450')?.lineHeight ?? 1.4, letterSpacing: _getPropValueById('2:450')?.letterSpacing ?? 0.14999999664723873.w),),),),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          height: _getPropValueById('2:441')?.height ?? 71.h,
          child: child
        )
      : Positioned(
          height: _getPropValueById('2:441')?.height ?? 71.h,
          left: _getPropValueById('2:441')?.left ?? 24.w,
          top: _getPropValueById('2:441')?.top ?? 24.h,
          child: child
        );
  }
}

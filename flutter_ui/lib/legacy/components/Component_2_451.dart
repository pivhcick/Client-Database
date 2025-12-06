import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_504.dart';

class Component_2_451 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_451(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_451> createState() => _Component_2_451State();
}

class _Component_2_451State extends State<Component_2_451> {


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
      visible: _getPropValueById('2:451')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('2:451')?.width ?? 295.w, minHeight: _getPropValueById('2:451')?.height ?? 71.h),
          child: Column(
            key: ValueKey("2:451"),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              Visibility(
                visible: _getPropValueById('2:452')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('2:452')?.width ?? 295.w,
                  child: Text(_getPropValueById('2:452')?.text ?? "Title",
                    key: ValueKey("2:452"),
                    style: TextStyle(color: _getPropValueById('2:452')?.textGradient == null? _getPropValueById('2:452')?.textColor ?? Color.fromRGBO(47, 48, 54,1): null, foreground: _getPropValueById('2:452')?.textGradient != null? (Paint()..shader = _getPropValueById('2:452')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:452')?.left ?? 0.w, _getPropValueById('2:452')?.top ?? 0.h, _getPropValueById('2:452')?.width ?? 295.w, _getPropValueById('2:452')?.height ?? 15.h))): null, fontFamily: _getPropValueById('2:452')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:452')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:452')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('2:452')?.letterSpacing ?? 0.w),),),),
              Visibility(
                visible: _getPropValueById('2:453')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('2:453')?.width ?? 295.w,
                  height: _getPropValueById('2:453')?.height ?? 48.h,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('2:453')?.width ?? 295.w, minHeight: _getPropValueById('2:453')?.height ?? 48.h),
                      padding: EdgeInsets.only(left: 16.w,right: 16.w, top: 12.h,bottom: 12.h),
                      decoration: BoxDecoration(borderRadius: _getPropValueById('2:453')?.borderRadius ?? BorderRadius.circular(12.h),border: _getPropValueById('2:453')?.border ?? Border.all(width: 1.5.w, color: Color.fromRGBO(0, 111, 253,1), ),),
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        key: ValueKey("2:453"),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8.w,
                        children: [
                          Visibility(
                            visible: _getPropValueById('2:454')?.visible ?? true,
                            child: SizedBox(
                              width: _getPropValueById('2:454')?.width ?? 263.w,
                              height: _getPropValueById('2:454')?.height ?? 20.h,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  constraints: BoxConstraints(minWidth: _getPropValueById('2:454')?.width ?? 263.w, minHeight: _getPropValueById('2:454')?.height ?? 20.h),
                                  child: Row(
                                    key: ValueKey("2:454"),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 6.w,
                                    children: [
                                      Visibility(
                                        visible: _getPropValueById('2:455')?.visible ?? true,
                                        child: Text(_getPropValueById('2:455')?.text ?? "€",
                                          key: ValueKey("2:455"),
                                          style: TextStyle(color: _getPropValueById('2:455')?.textGradient == null? _getPropValueById('2:455')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('2:455')?.textGradient != null? (Paint()..shader = _getPropValueById('2:455')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:455')?.left ?? 0.w, _getPropValueById('2:455')?.top ?? 0.h, _getPropValueById('2:455')?.width ?? 10.w, _getPropValueById('2:455')?.height ?? 18.h))): null, fontFamily: _getPropValueById('2:455')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:455')?.fontSize ?? 13.5.sp, height: _getPropValueById('2:455')?.lineHeight ?? 1.2857142857142858, letterSpacing: _getPropValueById('2:455')?.letterSpacing ?? 0.w),),),
                                      Visibility(
                                        visible: _getPropValueById('2:456')?.visible ?? true,
                                        child: SizedBox(
                                          width: _getPropValueById('2:456')?.width ?? 263.w,
                                          height: _getPropValueById('2:456')?.height ?? 20.h,
                                          child: SingleChildScrollView(
                                            clipBehavior: Clip.none,
                                            physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              constraints: BoxConstraints(minWidth: _getPropValueById('2:456')?.width ?? 263.w, minHeight: _getPropValueById('2:456')?.height ?? 20.h),
                                              child: Row(
                                                key: ValueKey("2:456"),
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                spacing: 1.w,
                                                children: [
                                                  Visibility(
                                                    visible: _getPropValueById('2:457')?.visible ?? true,
                                                    child: Text(_getPropValueById('2:457')?.text ?? "Text",
                                                      key: ValueKey("2:457"),
                                                      style: TextStyle(color: _getPropValueById('2:457')?.textGradient == null? _getPropValueById('2:457')?.textColor ?? Color.fromRGBO(31, 32, 36,1): null, foreground: _getPropValueById('2:457')?.textGradient != null? (Paint()..shader = _getPropValueById('2:457')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:457')?.left ?? 0.w, _getPropValueById('2:457')?.top ?? 0.h, _getPropValueById('2:457')?.width ?? 29.w, _getPropValueById('2:457')?.height ?? 20.h))): null, fontFamily: _getPropValueById('2:457')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:457')?.fontSize ?? 13.5.sp, height: _getPropValueById('2:457')?.lineHeight ?? 1.4285714285714286, letterSpacing: _getPropValueById('2:457')?.letterSpacing ?? 0.w),),),
                                                  Container(
                                                    width: 1.w,
                                                    height: 16.h,
                                                    child: Image(
                                                      key: ValueKey("2:458"),
                                                      image: AssetImage("assets/images/Vector_2_458.png"),),),
                                                ],),),),),),
                                    ],),),),),),
                          Component_2_504({"2:504":PixFlutterInterface(width:16.w,height:16.w,left:263.w,top:16.h,supInterface:_getPropValueById('2:504'),),"2:505":PixFlutterInterface(width:16.w,height:13.67.h,left:0.w,top:1.16.h,supInterface:_getPropValueById('2:505'),),"2:506":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.72.w,top:0.h,supInterface:_getPropValueById('2:506'),),"2:507":PixFlutterInterface(width:16.w,height:10.91.h,left:0.w,top:1.38.h,supInterface:_getPropValueById('2:507'),),"2:508":PixFlutterInterface(width:16.w,height:10.91.h,supInterface:_getPropValueById('2:508'),),"2:509":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.17.w,top:-2.55.h,supInterface:_getPropValueById('2:509'),),"2:510":PixFlutterInterface(backgroundColor:Color.fromRGBO(143, 144, 152,1),width:16.w,height:16.w,supInterface:_getPropValueById('2:510'),),}, true),
                        ],),),),),),
              Visibility(
                visible: _getPropValueById('2:460')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('2:460')?.width ?? 295.w,
                  child: Text(_getPropValueById('2:460')?.text ?? "Support text",
                    key: ValueKey("2:460"),
                    style: TextStyle(color: _getPropValueById('2:460')?.textGradient == null? _getPropValueById('2:460')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('2:460')?.textGradient != null? (Paint()..shader = _getPropValueById('2:460')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:460')?.left ?? 0.w, _getPropValueById('2:460')?.top ?? 75.h, _getPropValueById('2:460')?.width ?? 295.w, _getPropValueById('2:460')?.height ?? 14.h))): null, fontFamily: _getPropValueById('2:460')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:460')?.fontSize ?? 9.5.sp, height: _getPropValueById('2:460')?.lineHeight ?? 1.4, letterSpacing: _getPropValueById('2:460')?.letterSpacing ?? 0.14999999664723873.w),),),),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          height: _getPropValueById('2:451')?.height ?? 71.h,
          child: child
        )
      : Positioned(
          height: _getPropValueById('2:451')?.height ?? 71.h,
          left: _getPropValueById('2:451')?.left ?? 24.w,
          top: _getPropValueById('2:451')?.top ?? 119.h,
          child: child
        );
  }
}

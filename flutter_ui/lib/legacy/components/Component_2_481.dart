import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_504.dart';

class Component_2_481 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_481(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_481> createState() => _Component_2_481State();
}

class _Component_2_481State extends State<Component_2_481> {


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
      visible: _getPropValueById('2:481')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('2:481')?.width ?? 295.w, minHeight: _getPropValueById('2:481')?.height ?? 71.h),
          child: Column(
            key: ValueKey("2:481"),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              Visibility(
                visible: _getPropValueById('2:482')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('2:482')?.width ?? 295.w,
                  child: Text(_getPropValueById('2:482')?.text ?? "Title",
                    key: ValueKey("2:482"),
                    style: TextStyle(color: _getPropValueById('2:482')?.textGradient == null? _getPropValueById('2:482')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('2:482')?.textGradient != null? (Paint()..shader = _getPropValueById('2:482')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:482')?.left ?? 0.w, _getPropValueById('2:482')?.top ?? 0.h, _getPropValueById('2:482')?.width ?? 295.w, _getPropValueById('2:482')?.height ?? 15.h))): null, fontFamily: _getPropValueById('2:482')?.fontFamily ?? "Inter", fontWeight: _getPropValueById('2:482')?.fontWeight ?? FontWeight.bold, fontSize: _getPropValueById('2:482')?.fontSize ?? 11.5.sp, letterSpacing: _getPropValueById('2:482')?.letterSpacing ?? 0.w),),),),
              Visibility(
                visible: _getPropValueById('2:483')?.visible ?? true,
                child: SizedBox(
                  width: _getPropValueById('2:483')?.width ?? 295.w,
                  height: _getPropValueById('2:483')?.height ?? 48.h,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(minWidth: _getPropValueById('2:483')?.width ?? 295.w, minHeight: _getPropValueById('2:483')?.height ?? 48.h),
                      padding: EdgeInsets.only(left: 16.w,right: 16.w, top: 12.h,bottom: 12.h),
                      decoration: BoxDecoration(color: _getPropValueById('2:483')?.backgroundColor ?? Color.fromRGBO(248, 249, 254,1),borderRadius: _getPropValueById('2:483')?.borderRadius ?? BorderRadius.circular(12.h),border: _getPropValueById('2:483')?.border ?? Border.all(width: 1.w, color: Color.fromRGBO(197, 198, 204,1), ),),
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        key: ValueKey("2:483"),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8.w,
                        children: [
                          Visibility(
                            visible: _getPropValueById('2:484')?.visible ?? true,
                            child: SizedBox(
                              width: _getPropValueById('2:484')?.width ?? 263.w,
                              height: _getPropValueById('2:484')?.height ?? 20.h,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  constraints: BoxConstraints(minWidth: _getPropValueById('2:484')?.width ?? 263.w, minHeight: _getPropValueById('2:484')?.height ?? 20.h),
                                  child: Row(
                                    key: ValueKey("2:484"),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 6.w,
                                    children: [
                                      Visibility(
                                        visible: _getPropValueById('2:485')?.visible ?? true,
                                        child: Text(_getPropValueById('2:485')?.text ?? "€",
                                          key: ValueKey("2:485"),
                                          style: TextStyle(color: _getPropValueById('2:485')?.textGradient == null? _getPropValueById('2:485')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('2:485')?.textGradient != null? (Paint()..shader = _getPropValueById('2:485')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:485')?.left ?? 0.w, _getPropValueById('2:485')?.top ?? 0.h, _getPropValueById('2:485')?.width ?? 10.w, _getPropValueById('2:485')?.height ?? 18.h))): null, fontFamily: _getPropValueById('2:485')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:485')?.fontSize ?? 13.5.sp, height: _getPropValueById('2:485')?.lineHeight ?? 1.2857142857142858, letterSpacing: _getPropValueById('2:485')?.letterSpacing ?? 0.w),),),
                                      Visibility(
                                        visible: _getPropValueById('2:486')?.visible ?? true,
                                        child: SizedBox(
                                          width: _getPropValueById('2:486')?.width ?? 263.w,
                                          height: _getPropValueById('2:486')?.height ?? 20.h,
                                          child: SingleChildScrollView(
                                            clipBehavior: Clip.none,
                                            physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              constraints: BoxConstraints(minWidth: _getPropValueById('2:486')?.width ?? 263.w, minHeight: _getPropValueById('2:486')?.height ?? 20.h),
                                              child: Row(
                                                key: ValueKey("2:486"),
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                spacing: 1.w,
                                                children: [
                                                  Visibility(
                                                    visible: _getPropValueById('2:487')?.visible ?? true,
                                                    child: Text(_getPropValueById('2:487')?.text ?? "Text",
                                                      key: ValueKey("2:487"),
                                                      style: TextStyle(color: _getPropValueById('2:487')?.textGradient == null? _getPropValueById('2:487')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('2:487')?.textGradient != null? (Paint()..shader = _getPropValueById('2:487')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:487')?.left ?? 0.w, _getPropValueById('2:487')?.top ?? 0.h, _getPropValueById('2:487')?.width ?? 29.w, _getPropValueById('2:487')?.height ?? 20.h))): null, fontFamily: _getPropValueById('2:487')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:487')?.fontSize ?? 13.5.sp, height: _getPropValueById('2:487')?.lineHeight ?? 1.4285714285714286, letterSpacing: _getPropValueById('2:487')?.letterSpacing ?? 0.w),),),
                                                  Visibility(
                                                    visible: false,
                                                    child: Container(
                                                      width: 1.w,
                                                      height: 16.h,
                                                      child: Image(
                                                        key: ValueKey("2:488"),
                                                        image: AssetImage("assets/images/Vector_2_488.png"),),),),
                                                ],),),),),),
                                    ],),),),),),
                          Component_2_504({"2:504":PixFlutterInterface(width:16.w,height:16.w,left:263.w,top:16.h,supInterface:_getPropValueById('2:504'),),"2:505":PixFlutterInterface(width:16.w,height:13.67.h,left:0.w,top:1.16.h,supInterface:_getPropValueById('2:505'),),"2:506":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.72.w,top:0.h,supInterface:_getPropValueById('2:506'),),"2:507":PixFlutterInterface(width:16.w,height:10.91.h,left:0.w,top:1.38.h,supInterface:_getPropValueById('2:507'),),"2:508":PixFlutterInterface(width:16.w,height:10.91.h,supInterface:_getPropValueById('2:508'),),"2:509":PixFlutterInterface(width:13.67.w,height:13.67.w,left:1.17.w,top:-2.55.h,supInterface:_getPropValueById('2:509'),),"2:510":PixFlutterInterface(backgroundColor:Color.fromRGBO(143, 144, 152,1),width:16.w,height:16.w,supInterface:_getPropValueById('2:510'),),}, true),
                        ],),),),),),
              Visibility(
                visible: _getPropValueById('2:490')?.visible ?? true,
                child: Container(
                  width: _getPropValueById('2:490')?.width ?? 295.w,
                  child: Text(_getPropValueById('2:490')?.text ?? "Support text",
                    key: ValueKey("2:490"),
                    style: TextStyle(color: _getPropValueById('2:490')?.textGradient == null? _getPropValueById('2:490')?.textColor ?? Color.fromRGBO(143, 144, 152,1): null, foreground: _getPropValueById('2:490')?.textGradient != null? (Paint()..shader = _getPropValueById('2:490')?.textGradient!.createShader(Rect.fromLTWH(_getPropValueById('2:490')?.left ?? 0.w, _getPropValueById('2:490')?.top ?? 75.h, _getPropValueById('2:490')?.width ?? 295.w, _getPropValueById('2:490')?.height ?? 14.h))): null, fontFamily: _getPropValueById('2:490')?.fontFamily ?? "Inter", fontSize: _getPropValueById('2:490')?.fontSize ?? 9.5.sp, height: _getPropValueById('2:490')?.lineHeight ?? 1.4, letterSpacing: _getPropValueById('2:490')?.letterSpacing ?? 0.14999999664723873.w),),),),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          height: _getPropValueById('2:481')?.height ?? 71.h,
          child: child
        )
      : Positioned(
          height: _getPropValueById('2:481')?.height ?? 71.h,
          left: _getPropValueById('2:481')?.left ?? 24.w,
          top: _getPropValueById('2:481')?.top ?? 404.h,
          child: child
        );
  }
}

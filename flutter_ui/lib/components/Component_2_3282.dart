import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_3290.dart';

class Component_2_3282 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_3282(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_3282> createState() => _Component_2_3282State();
}

class _Component_2_3282State extends State<Component_2_3282> {


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
      visible: _getPropValueById('2:3282')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("2:3282"),
          children: [
            Component_2_3290({"2:3290":PixFlutterInterface(width:264.w,height:264.w,left:0.w,top:0.h,supInterface:_getPropValueById('2:3290'),),"2:3291":PixFlutterInterface(width:264.w,height:264.w,supInterface:_getPropValueById('2:3291'),),}, false),
            Positioned(
              width: _getPropValueById('2:3284')?.width ?? 198.minPx,
              height: _getPropValueById('2:3284')?.height ?? 198.minPx,
              left: _getPropValueById('2:3284')?.left ?? 33.w,
              top: _getPropValueById('2:3284')?.top ?? 33.h,
              child: Visibility(
                visible: _getPropValueById('2:3284')?.visible ?? true,
                child: Stack(
                  key: ValueKey("2:3284"),
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      width: 198.w,
                      height: 198.h,
                      left: 0.w,
                      top: 0.h,
                      child: Image(
                        key: ValueKey("2:3285"),
                        image: AssetImage("assets/images/Vector_2_3285.png"),),),
                  ],),),),
            Positioned(
              width: _getPropValueById('2:3286')?.width ?? 132.w,
              height: _getPropValueById('2:3286')?.height ?? 93.5.h,
              left: _getPropValueById('2:3286')?.left ?? 66.w,
              top: _getPropValueById('2:3286')?.top ?? 85.25.h,
              child: Visibility(
                visible: _getPropValueById('2:3286')?.visible ?? true,
                child: Stack(
                  key: ValueKey("2:3286"),
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      width: 132.w,
                      height: 93.5.h,
                      left: 0.w,
                      top: 0.h,
                      child: Image(
                        key: ValueKey("2:3287"),
                        image: AssetImage("assets/images/Vector_2_3287.png"),),),
                  ],),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:3282')?.width ?? 264.minPx,
          height: _getPropValueById('2:3282')?.height ?? 264.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:3282')?.width ?? 264.minPx,
          height: _getPropValueById('2:3282')?.height ?? 264.minPx,
          left: _getPropValueById('2:3282')?.left ?? 55.w,
          top: _getPropValueById('2:3282')?.top ?? 94.h,
          child: child
        );
  }
}

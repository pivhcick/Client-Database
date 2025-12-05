import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_194 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_194(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_194> createState() => _Component_2_194State();
}

class _Component_2_194State extends State<Component_2_194> {


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
      visible: _getPropValueById('2:194')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("2:194"),
          children: [
            Positioned(
              width: 22.w,
              height: 22.h,
              left: 1.w,
              top: 1.h,
              child: Image(
                key: ValueKey("2:195"),
                image: AssetImage("assets/images/Vector_2_195.png"),),),
            Positioned(
              width: _getPropValueById('2:196')?.width ?? 24.minPx,
              height: _getPropValueById('2:196')?.height ?? 24.minPx,
              left: _getPropValueById('2:196')?.left ?? 0.w,
              top: _getPropValueById('2:196')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('2:196')?.visible ?? true,
                child: Container(
                  key: ValueKey("2:196"),
                  decoration: BoxDecoration(color: _getPropValueById('2:196')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:194')?.width ?? 24.minPx,
          height: _getPropValueById('2:194')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:194')?.width ?? 24.minPx,
          height: _getPropValueById('2:194')?.height ?? 24.minPx,
          left: _getPropValueById('2:194')?.left ?? -12175.36.w,
          top: _getPropValueById('2:194')?.top ?? 282.h,
          child: child
        );
  }
}

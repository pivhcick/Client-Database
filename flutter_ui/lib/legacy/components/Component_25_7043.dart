import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_25_7043 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_25_7043(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_25_7043> createState() => _Component_25_7043State();
}

class _Component_25_7043State extends State<Component_25_7043> {


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
      visible: _getPropValueById('25:7043')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("25:7043"),
          children: [
            Positioned(
              width: _getPropValueById('25:7044')?.width ?? 22.minPx,
              height: _getPropValueById('25:7044')?.height ?? 22.minPx,
              left: _getPropValueById('25:7044')?.left ?? 1.w,
              top: _getPropValueById('25:7044')?.top ?? 1.h,
              child: Visibility(
                visible: _getPropValueById('25:7044')?.visible ?? true,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(),
                  child: Stack(
                    key: ValueKey("25:7044"),
                    children: [
                      Positioned(
                        width: 22.w,
                        height: 22.h,
                        left: 0.w,
                        top: 0.h,
                        child: Image(
                          key: ValueKey("25:7045"),
                          image: AssetImage("assets/images/Ellipse_25_7045.png"),),),
                      Positioned(
                        width: _getPropValueById('25:7046')?.width ?? 24.minPx,
                        height: _getPropValueById('25:7046')?.height ?? 24.minPx,
                        left: _getPropValueById('25:7046')?.left ?? -1.w,
                        top: _getPropValueById('25:7046')?.top ?? -1.h,
                        child: Visibility(
                          visible: _getPropValueById('25:7046')?.visible ?? true,
                          child: Container(
                            key: ValueKey("25:7046"),
                            decoration: BoxDecoration(color: _getPropValueById('25:7046')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
                    ],),),),),
            Positioned(
              width: 6.41.w,
              height: 10.94.h,
              left: 8.79.w,
              top: 6.53.h,
              child: Image(
                key: ValueKey("25:7047"),
                image: AssetImage("assets/images/Vector_25_7047.png"),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('25:7043')?.width ?? 24.minPx,
          height: _getPropValueById('25:7043')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('25:7043')?.width ?? 24.minPx,
          height: _getPropValueById('25:7043')?.height ?? 24.minPx,
          left: _getPropValueById('25:7043')?.left ?? 0.w,
          top: _getPropValueById('25:7043')?.top ?? 0.h,
          child: child
        );
  }
}

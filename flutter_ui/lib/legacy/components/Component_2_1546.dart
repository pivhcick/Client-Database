import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Component_2_1546 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_1546(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_1546> createState() => _Component_2_1546State();
}

class _Component_2_1546State extends State<Component_2_1546> {


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
      visible: _getPropValueById('2:1546')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("2:1546"),
          children: [
            Positioned(
              width: 20.w,
              height: 24.h,
              left: 2.w,
              top: 0.h,
              child: Image(
                key: ValueKey("2:1547"),
                image: AssetImage("assets/images/Vector_2_1547.png"),),),
            Positioned(
              width: _getPropValueById('2:1548')?.width ?? 24.minPx,
              height: _getPropValueById('2:1548')?.height ?? 24.minPx,
              left: _getPropValueById('2:1548')?.left ?? 0.w,
              top: _getPropValueById('2:1548')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('2:1548')?.visible ?? true,
                child: Container(
                  key: ValueKey("2:1548"),
                  decoration: BoxDecoration(color: _getPropValueById('2:1548')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:1546')?.width ?? 24.minPx,
          height: _getPropValueById('2:1546')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:1546')?.width ?? 24.minPx,
          height: _getPropValueById('2:1546')?.height ?? 24.minPx,
          left: _getPropValueById('2:1546')?.left ?? -11815.36.w,
          top: _getPropValueById('2:1546')?.top ?? 282.h,
          child: child
        );
  }
}

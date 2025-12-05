import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';

class Search2 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Search2(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Search2> createState() => _Search2State();
}

class _Search2State extends State<Search2> {


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
      visible: _getPropValueById('2:2231')?.visible ?? true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          key: ValueKey("2:2231"),
          children: [
            Positioned(
              width: 23.w,
              height: 23.h,
              left: 0.5.w,
              top: 0.5.h,
              child: Image(
                key: ValueKey("2:2232"),
                image: AssetImage("assets/images/Vector_2_2232.png"),),),
            Positioned(
              width: _getPropValueById('2:2233')?.width ?? 24.minPx,
              height: _getPropValueById('2:2233')?.height ?? 24.minPx,
              left: _getPropValueById('2:2233')?.left ?? 0.w,
              top: _getPropValueById('2:2233')?.top ?? 0.h,
              child: Visibility(
                visible: _getPropValueById('2:2233')?.visible ?? true,
                child: Container(
                  key: ValueKey("2:2233"),
                  decoration: BoxDecoration(color: _getPropValueById('2:2233')?.backgroundColor ?? Color.fromRGBO(0, 111, 253,1),),),),),
          ],),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          width: _getPropValueById('2:2231')?.width ?? 24.minPx,
          height: _getPropValueById('2:2231')?.height ?? 24.minPx,
          child: child
        )
      : Positioned(
          width: _getPropValueById('2:2231')?.width ?? 24.minPx,
          height: _getPropValueById('2:2231')?.height ?? 24.minPx,
          left: _getPropValueById('2:2231')?.left ?? -11671.36.w,
          top: _getPropValueById('2:2231')?.top ?? 282.h,
          child: child
        );
  }
}

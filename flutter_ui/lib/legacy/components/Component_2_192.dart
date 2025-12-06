import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_200.dart';

class Component_2_192 extends StatefulWidget {
  Map<dynamic, PixFlutterInterface> datas;
  bool isAutoLayout;
  Component_2_192(this.datas,this.isAutoLayout,{super.key,});
  @override
  State<Component_2_192> createState() => _Component_2_192State();
}

class _Component_2_192State extends State<Component_2_192> {


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
      visible: _getPropValueById('2:192')?.visible ?? true,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(minWidth: _getPropValueById('2:192')?.width ?? 120.w, minHeight: _getPropValueById('2:192')?.height ?? 120.h),
          padding: EdgeInsets.only(left: 40.w,right: 40.w, top: 40.h,bottom: 40.h),
          decoration: BoxDecoration(color: _getPropValueById('2:192')?.backgroundColor ?? Color.fromRGBO(234, 242, 255,1),),
          child: Column(
            key: ValueKey("2:192"),
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10.h,
            children: [
              Component_2_200({"2:200":PixFlutterInterface(width:32.w,height:32.w,left:44.w,top:44.h,supInterface:_getPropValueById('2:200'),),"2:201":PixFlutterInterface(backgroundColor:Color.fromRGBO(180, 219, 255,1),width:32.w,height:26.67.h,left:0.w,top:2.67.h,supInterface:_getPropValueById('2:201'),),"2:202":PixFlutterInterface(backgroundColor:Color.fromRGBO(180, 219, 255,1),width:32.w,height:32.w,supInterface:_getPropValueById('2:202'),),}, true),
            ],),),),);
    return widget.isAutoLayout == true
      ? SizedBox(
          height: _getPropValueById('2:192')?.height ?? 120.minPx,
          child: child
        )
      : Positioned(
          height: _getPropValueById('2:192')?.height ?? 120.minPx,
          left: _getPropValueById('2:192')?.left ?? -11128.58.w,
          top: _getPropValueById('2:192')?.top ?? 506.h,
          child: child
        );
  }
}

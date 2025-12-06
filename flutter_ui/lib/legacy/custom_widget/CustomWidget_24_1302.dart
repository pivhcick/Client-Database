import 'package:flutter/material.dart';
import 'package:flutter_ui/utils/pix_adapted_screen.dart';
import 'package:flutter_ui/components/Component_25_1789.dart';
import 'package:flutter_ui/utils/pix_flutter_interface.dart';
import 'package:flutter_ui/components/Component_2_427.dart';
import 'package:flutter_ui/components/Component_2_1376.dart';
import 'package:flutter_ui/components/Size3.dart';
import 'package:flutter_ui/components/Component_2_1476.dart';

class CustomWidget_24_1302 extends StatelessWidget {
  const CustomWidget_24_1302({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
          width: 375.w,
          height: 224.h,
          left: 0.w,
          top: 44.h,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(),
            child: Stack(
              key: ValueKey("24:1302"),
              children: [
                Positioned(
                  width: 291.w,
                  height: 164.h,
                  left: 42.w,
                  top: 60.h,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(),
                    child: Stack(
                      key: ValueKey("2:3564"),
                      children: [
                        Positioned(
                          height: 164.h,
                          left: 0.w,
                          top: 0.h,
                          child: SingleChildScrollView(
                            clipBehavior: Clip.none,
                            physics: NeverScrollableScrollPhysics(),
                            child: Container(
                              constraints: BoxConstraints(minWidth: 291.w, minHeight: 164.h),
                              child: Column(
                                key: ValueKey("2:3561"),
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 16.h,
                                children: [
                                  Container(
                                    width: 80.w,
                                    height: 80.h,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(),
                                    child: Stack(
                                      key: ValueKey("2:1357"),
                                      children: [
                                        Size3({"2:188":PixFlutterInterface(width:80.w,height:80.w,left:0.w,top:0.h,),"2:189":PixFlutterInterface(width:60.w,height:97.76.h,left:10.w,top:12.h,),"2:190":PixFlutterInterface(left:0.w,top:37.76.h,),"2:191":PixFlutterInterface(left:14.w,top:0.h,),}, false),
                                      ],),),
                                  SizedBox(
                                    width: 195.w,
                                    height: 68.h,
                                    child: SingleChildScrollView(
                                      clipBehavior: Clip.none,
                                      physics: NeverScrollableScrollPhysics(),
                                      child: Container(
                                        constraints: BoxConstraints(minWidth: 195.w, minHeight: 68.h),
                                        child: Column(
                                          key: ValueKey("2:1361"),
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          spacing: 4.h,
                                          children: [
                                            Text("Фамилия Имя Отчество",
                                              key: ValueKey("2:1362"),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Color.fromRGBO(31, 32, 36,1), fontFamily: "Inter", fontWeight: FontWeight.bold, fontSize: 15.5.sp, letterSpacing: 0.07999999821186066.w),),
                                            Container(
                                              width: 120.w,
                                              height: 20.h,
                                              child: Text("+79252328373",
                                                key: ValueKey("2:1363"),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(color: Color.fromRGBO(113, 114, 122,1), fontFamily: "Sora", fontSize: 13.5.sp, letterSpacing: 0.w),),),
                                            Container(
                                              width: 172.w,
                                              height: 20.h,
                                              child: Text("beer_andrey@mail.ru",
                                                key: ValueKey("22:1183"),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(color: Color.fromRGBO(113, 114, 122,1), fontFamily: "Sora", fontSize: 13.5.sp, letterSpacing: 0.w),),),
                                          ],),),),),
                                ],),),),),
                      ],),),),
              ],),),);
  }
}

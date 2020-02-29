import 'package:flutter/cupertino.dart';
import 'device_screen_type.dart';

class SizingInformation {
  SizingInformation({
    this.deviceScreenType, 
    this.screenSize, 
    this.localWidgetSize
  });
  
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  @override
  String toString() {
    return '''
      DeviceType:$deviceScreenType 
      ScreenSize:$screenSize 
      LocalWidgetSize:$localWidgetSize
    ''';
  }
 }
import 'package:flutter/cupertino.dart';

import '../../constants/dimens.dart';
import 'device_screen_type.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQueryData) {
  final double deviceWidth = mediaQueryData.size.shortestSide;

  if (deviceWidth > Dimens.minDesktopWidth) {
    return DeviceScreenType.Desktop;
  }
  if (deviceWidth > Dimens.minTabletWidth) {
    return DeviceScreenType.Tablet;
  }
  return DeviceScreenType.Mobile;
}
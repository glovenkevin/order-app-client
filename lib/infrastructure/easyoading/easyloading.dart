import 'package:flutter_easyloading/flutter_easyloading.dart';

void configEasyLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCube
    ..animationStyle = EasyLoadingAnimationStyle.scale
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..maskType = EasyLoadingMaskType.black
    ..loadingStyle = EasyLoadingStyle.light
    ..userInteractions = false
    ..dismissOnTap = true;
}

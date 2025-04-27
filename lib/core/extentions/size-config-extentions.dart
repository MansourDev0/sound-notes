// ignore_for_file: unnecessary_this
import '../responsive helper/size_config.dart';

extension SizeConfigExtension on num {
  double get h {
    return SizeConfig.scaleHeight(toDouble());
  }

  double get w {
    return SizeConfig.scaleWidth(toDouble());
  }
}

extension ScaleTextExtension on num {
  double get scaleFontSize {
    return SizeConfig.scaleTextFont(toDouble());
  }
}

import 'package:flutter_svg/flutter_svg.dart';

class BreweryImages {
  static String iconPath = 'icons/icon.svg';

  static Future preCacheAll() {
    return Future.wait([
      precachePicture(
          ExactAssetPicture(
            SvgPicture.svgStringDecoder,
            iconPath,
          ),
          null)
    ]);
  }
}

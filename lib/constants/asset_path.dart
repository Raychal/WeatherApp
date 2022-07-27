final String imageAssetsRoot = 'assets/images/';
final String fontAssetsRoot = 'assets/fonts/';
final String splash = _getImagePath('splash_image.png');
final String onBoarding1 = _getImagePath('onboarding_image_1.png');
final String onBoarding2 = _getImagePath('onboarding_image_2.png');
final String onBoarding3 = _getImagePath('onboarding_image_3.png');
final String onBoarding4 = _getImagePath('onboarding_image_4.png');
final String defaultPhoto = _getImagePath('nameless.png');
final String rainy = _getImagePath('rainy.png');
final String rainy2d = _getImagePath('rainy_2d.png');
final String snow = _getImagePath('snow.png');
final String snow2d = _getImagePath('snow_2d.png');
final String sunny = _getImagePath('sunny.png');
final String sunny2d = _getImagePath('sunny_2d.png');
final String thunder = _getImagePath('thunder.png');
final String thunder2d = _getImagePath('thunder_2d.png');
final String fontKlasikRegular = _getFontPath('Klasik_Regular.otf');

String _getImagePath(String fileName){
  return imageAssetsRoot + fileName;
}

String _getFontPath(String fileName) {
  return fontAssetsRoot + fileName;
}
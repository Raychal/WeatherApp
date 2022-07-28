import '../../constants/asset_path.dart';

String getWeatherIcon(String iconCode) {
  switch (iconCode) {
    case '01d':
      return day;

    case '01n':
      return night;

    case '02d':
      return cloudyDay;

    case '02n':
      return cloudyNight;

    case '03d':
    case '03n':
    case '04d':
    case '04n':
      return cloudy;

    case '09d':
    case '09n':
    case '10d':
    case '10n':
      return rainy;

    case '11d':
    case '11n':
      return thunderSvg;

    case '13d':
    case '13n':
      return snowy;

  // TODO: Add smog icon
  // case '50d':
  // case '50n':

    default:
      return 'assets/day.svg';
  }
}
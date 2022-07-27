import '../constants/asset_path.dart';

class WeatherModel {
  final int max;
  final int min;
  final int current;
  final String name;
  final String day;
  final int wind;
  final int humidity;
  final int chanceRain;
  final String image;
  final String time;
  final String location;

  WeatherModel(
      {required this.max,
        required this.min,
        required this.name,
        required this.day,
        required this.wind,
        required this.humidity,
        required this.chanceRain,
        required this.image,
        required this.current,
        required this.time,
        required this.location});
}

List<WeatherModel> todayWeather = [
  WeatherModel(max: 0, min: 0, name: '', day: '', wind: 0, humidity: 0, chanceRain: 0, image: rainy2d, current: 23, time: '10:00', location: ''),
  WeatherModel(max: 0, min: 0, name: '', day: '', wind: 0, humidity: 0, chanceRain: 0, image: thunder2d, current: 21, time: '11:00', location: ''),
  WeatherModel(max: 0, min: 0, name: '', day: '', wind: 0, humidity: 0, chanceRain: 0, image: rainy2d, current: 22, time: '20:00', location: ''),
  WeatherModel(max: 0, min: 0, name: '', day: '', wind: 0, humidity: 0, chanceRain: 0, image: sunny2d, current: 19, time: '01:00', location: ''),
];

WeatherModel currentTemp = WeatherModel(
    current: 21,
    image: thunder,
    name: "Thunderstorm",
    day: "Monday, 17 May",
    wind: 13,
    humidity: 24,
    chanceRain: 87,
    location: "Minsk",
    min: 0,
    max: 0,
    time: '',
);

WeatherModel tomorrowTemp = WeatherModel(
  max: 20,
  min: 17,
  image: sunny,
  name: "Sunny",
  wind: 9,
  humidity: 31,
  chanceRain: 20,
  location: '',
  current: 0,
  day: '',
  time: '',

);

List<WeatherModel> sevenDay = [
  WeatherModel(
      max: 20,
      min: 14,
      image: rainy2d,
      day: "Mon",
      name: "Rainy",
      chanceRain: 0,
      time: '',
      location: '',
      humidity: 0,
      current: 0,
      wind: 0,
  ),
  WeatherModel(
      max: 22,
      min: 16,
      image: thunder2d,
      day: "Tue",
      name: "Thunder",
      chanceRain: 0,
      time: '',
      location: '',
      humidity: 0,
      current: 0,
      wind: 0,
  ),
  WeatherModel(
      max: 19,
      min: 13,
      image: rainy2d,
      day: "Wed",
      name: "Rainy",
      chanceRain: 0,
      time: '',
      location: '',
      humidity: 0,
      current: 0,
      wind: 0,
  ),
  WeatherModel(
    max: 18, min: 12, image: snow2d, day: "Thu", name: "Snow",
    chanceRain: 0,
    time: '',
    location: '',
    humidity: 0,
    current: 0,
    wind: 0,
  ),
  WeatherModel(
      max: 23,
      min: 19,
      image: sunny2d,
      day: "Fri",
      name: "Sunny",
      chanceRain: 0,
      time: '',
      location: '',
      humidity: 0,
      current: 0,
      wind: 0,
  ),
  WeatherModel(
      max: 25,
      min: 17,
      image: rainy2d,
      day: "Sat",
      name: "Rainy",
      chanceRain: 0,
      time: '',
      location: '',
      humidity: 0,
      current: 0,
      wind: 0,
  ),
  WeatherModel(
      max: 21,
      min: 18,
      image: thunder2d,
      day: "Sun",
      name: "Thunder",
      chanceRain: 0,
      time: '',
      location: '',
      humidity: 0,
      current: 0,
      wind: 0,
  )
];

import 'dart:developer';

const Map<String, String> weatherIcons = {
  '01d': 'assets/weather_icons/clear_sky.png',
  '01n': 'assets/weather_icons/clear_sky.png',
  '02d': 'assets/weather_icons/few_clouds.png',
  '02n': 'assets/weather_icons/few_clouds.png',
  '03d': 'assets/weather_icons/scattered_clouds.png',
  '03n': 'assets/weather_icons/scattered_clouds.png',
  '04d': 'assets/weather_icons/broken_clouds.png',
  '04n': 'assets/weather_icons/broken_clouds.png',
  '09d': 'assets/weather_icons/shower_rain.png',
  '09n': 'assets/weather_icons/shower_rain.png',
  '10d': 'assets/weather_icons/rain.png',
  '10n': 'assets/weather_icons/rain.png',
  '11d': 'assets/weather_icons/thunderstorm.png',
  '11n': 'assets/weather_icons/thunderstorm.png',
  '13d': 'assets/weather_icons/snow.png',
  '13n': 'assets/weather_icons/snow.png',
  '50d': 'assets/weather_icons/mist.png',
  '50n': 'assets/weather_icons/mist.png',
};

// country list with its flags path
final List<Map<String, String>> countries = [
  {
    'name': 'United Kingdom',
    'searchName': 'London',
    'flag': 'assets/flags/uk.png',
  },
  {
    'name': 'France',
    'searchName': 'Paris',
    'flag': 'assets/flags/france.png',
  },
  {
    'name': 'Japan',
    'searchName': 'Tokyo',
    'flag': 'assets/flags/japan.png',
  },
  {
    'name': 'United States Of America',
    'searchName': 'Texas',
    'flag': 'assets/flags/usa.png',
  },
  {
    'name': 'Australia',
    'searchName': 'Sydney',
    'flag': 'assets/flags/australia.png',
  },
  {
    'name': 'Italy',
    'searchName': 'Rome',
    'flag': 'assets/flags/italy.png',
  },
  {
    'name': 'United Arab Emirates',
    'searchName': 'Dubai',
    'flag': 'assets/flags/uae.png',
  },
  {
    'name': 'South Africa',
    'searchName': 'Limpopo',
    'flag': 'assets/flags/south_africa.png',
  },
  {
    'name': 'Brazil',
    'searchName': 'Salvador',
    'flag': 'assets/flags/brazil.png',
  },
  {
    'name': 'Canada',
    'searchName': 'Toronto',
    'flag': 'assets/flags/canada.png',
  },
  {
    'name': 'Argentina',
    'searchName': 'Mendoza',
    'flag': 'assets/flags/argentina.png',
  },
  {
    'name': 'Portugal',
    'searchName': 'Lisbon',
    'flag': 'assets/flags/portugal.png',
  },
];

// custom function to fetch the country by index
Map<String, String> getCountryByIndex(int index) {
  if (index < 0 || index >= countries.length) {
    log("Error");
  }
  return countries[index];
}

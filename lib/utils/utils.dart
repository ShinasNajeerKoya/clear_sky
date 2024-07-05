const Map<String, String> weatherIcons = {
  '01d': 'assets/weather_icons/clear_sky.png',
  '02d': 'assets/weather_icons/few_clouds.png',
  '03d': 'assets/weather_icons/scattered_clouds.png',
  '04d': 'assets/weather_icons/broken_clouds.png',
  '09d': 'assets/weather_icons/shower_rain.png',
  '10d': 'assets/weather_icons/rain.png',
  '11d': 'assets/weather_icons/thunderstorm.png',
  '13d': 'assets/weather_icons/snow.png',
  '50d': 'assets/weather_icons/mist.png',
};

// country list with its flags path
final List<Map<String, String>> countries = [
  {
    'name': 'United Kingdom',
    'flag': 'assets/flags/uk.png',
  },
  {
    'name': 'France',
    'flag': 'assets/flags/france.png',
  },
  {
    'name': 'Japan',
    'flag': 'assets/flags/japan.png',
  },
  {
    'name': 'United States',
    'flag': 'assets/flags/usa.png',
  },
  {
    'name': 'Australia',
    'flag': 'assets/flags/australia.png',
  },
  {
    'name': 'Italy',
    'flag': 'assets/flags/italy.png',
  },
  {
    'name': 'United Arab Emirates',
    'flag': 'assets/flags/uae.png',
  },
  {
    'name': 'South Africa',
    'flag': 'assets/flags/south_africa.png',
  },
  {
    'name': 'Brazil',
    'flag': 'assets/flags/brazil.png',
  },
  {
    'name': 'Canada',
    'flag': 'assets/flags/canada.png',
  },
  {
    'name': 'Argentina',
    'flag': 'assets/flags/argentina.png',
  },
  {
    'name': 'Portugal',
    'flag': 'assets/flags/portugal.png',
  },
];

// custom function to fetch the country by index
Map<String, String> getCountryByIndex(int index) {
  if (index < 0 || index >= countries.length) {
    return {'name': 'Unknown', 'flag': ''}; // Return a default value if the index is out of bounds
  }
  return countries[index];
}

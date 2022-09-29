import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../exception/main_exception.dart';
import '../model/city.dart';
import '../model/weather.dart';
import 'api_client.dart';

class WeatherApi {
  String get appKey => dotenv.env['APPKEY'] ?? '';

  ApiClient client = ApiClient();

  Future<List<Weather>> getWeathers(String city) async {
    String url = '${client.endpoint}/data/2.5/forecast?'
        'q=$city'
        '&appid=$appKey'
        '&units=metric'
        '&lang=fr';

    var response = await client.get(
      url,
    );

    Map rawResult = response.data;

    List<Weather> result = [];

    if (rawResult.containsKey('list') && rawResult.containsKey('city')) {
      for (var item in rawResult['list']) {
        var newItem = Weather.fromJson({'city': rawResult['city'], ...item});

        // Add only for day time
        if (newItem.cityDateTime.hour >= 6 && newItem.cityDateTime.hour <= 18) {
          result.add(newItem);
        }
      }
    } else {
      throw MainException("Erreur");
    }

    return result;
  }
}


import 'package:iot_app/api/apirepo.dart';

class HumidityRepo {
  static Future<dynamic> getHumidityDataBySensorId(int id)async{
    final response = await ApiRepository.get(path: 'humidity-data?sensor-id=${id}');
    return response;
  }
}

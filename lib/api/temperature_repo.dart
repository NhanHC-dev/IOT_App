
import 'package:iot_app/api/apirepo.dart';

class TemperatureRepo {
  static Future<dynamic> getTemperatureDataBySensorId(int id)async{
    final response = await ApiRepository.get(path: '/temperature-data/?sensor-id=${id}');
    return response;
  }
}

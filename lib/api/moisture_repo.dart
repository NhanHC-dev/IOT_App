
import 'package:iot_app/api/apirepo.dart';

class MoistureRepo {
  static Future<dynamic> getMoistureDataBySensorId(int id)async{
    final response = await ApiRepository.get(path: '/moisture-data/?sensor-id=${id}');
    return response;
  }
}

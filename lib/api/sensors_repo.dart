
import 'package:iot_app/api/apirepo.dart';

class SensorsRepo {
  static void updateSensors(int id, Map<String, dynamic> options) async{
    final response = await ApiRepository.put(path: "/settings/${id}", options: options);
  }
  static Future<dynamic> getSensors()async{
    final response = await ApiRepository.get(path: '/sensors');
    return response;
  }

}
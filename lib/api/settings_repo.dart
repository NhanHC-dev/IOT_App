
import 'package:iot_app/api/apirepo.dart';

class SettingsRepo {
  static Future<dynamic> getSettingsById(int id)async{
    final response = await ApiRepository.get(path: '/settings/${id}');
    return response;
  }

  static Future<dynamic> updateSettingsById(int id, dynamic options)async{
    final response = await ApiRepository.put(path: '/settings/${id}', options:options );
    return response;
  }
}

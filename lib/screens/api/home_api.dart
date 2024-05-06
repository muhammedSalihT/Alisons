import 'dart:developer';

import 'package:alisons_task/constents/api_const.dart';
import 'package:alisons_task/screens/model/home_model.dart';
import 'package:alisons_task/service/dio_api_service.dart';

class HomeApi {
  static Future<HomeModel?> getHomeData() async {
    try {
      final responce = await ApiService.apiMethodSetup(
          method: ApiMethod.post,
          url:
              '${ApiConst.baseUrl}/home?id=${ApiConst.id}&token=${ApiConst.token}');
      if (responce?.statusCode == 200) {
        log(responce!.data.toString());
        return HomeModel.fromJson(responce.data);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

import 'package:alisons_task/screens/api/home_api.dart';
import 'package:alisons_task/screens/model/home_model.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  HomeModel? homeData;

  void getHomeData() async {
    try {
      final data = await HomeApi.getHomeData();
      if (data != null) {
        homeData = data;
        notifyListeners();
      }
    } catch (e) {}
  }
}

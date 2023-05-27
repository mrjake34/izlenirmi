import 'dart:io';

import 'package:dio/dio.dart';
import 'package:izlenirmi/constants/network/network.dart';
import 'package:izlenirmi/reporsitory/service/popular_film/popular_film_sevice_interface.dart';
import 'package:izlenirmi/screens/home_page/popular_film/model/popular_film_model.dart';

class PopularFilmsService extends IPopularFilmService {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));
  @override
  Future<PopularFilmModel?> fetchFilmList(int page) async {
    final response = await dio.get(
        // "https://api.themoviedb.org/3/${NetWorkEnums.movie.toString()}/${NetWorkEnums.popular.toString()}?language=tr-TR&page=$page",
        "https://api.themoviedb.org/3/movie/popular?language=tr-TR&page=$page",
        options: Options(method: 'GET', headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token",
        }));
    if (response.statusCode == HttpStatus.ok) {
      print(response.data.runtimeType);
      final model = PopularFilmModel.fromJson(response.data);

      return model;
    } else {
      return null;
    }
  }
}

import 'package:dio/dio.dart';

import '../../../screens/home_page/popular_film/model/popular_film_model.dart';

abstract class IPopularFilmService {
  Future<PopularFilmModel?> fetchFilmList(int page);
}

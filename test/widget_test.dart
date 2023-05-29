// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:izlenirmi/reporsitory/service/popular_film/popular_film_service.dart';

void main() {
  setUp(() {});

  test('fetctPopularFilms - Fetch All Popular Films', () async {
    final response = await PopularFilmsService().fetchFilmList(1);

    expect(response, isNotEmpty);
  });
}

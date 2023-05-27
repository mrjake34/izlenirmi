// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'popular_films_bloc.dart';

abstract class PopularFilmsEvent {}

class FetchPopularFilmsEvent extends PopularFilmsEvent {
  int page = 1;
  FetchPopularFilmsEvent({
    required this.page,
  });
}

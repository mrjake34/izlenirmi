import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:izlenirmi/constants/enums/emuns_bloc.dart';
import 'package:izlenirmi/reporsitory/service/popular_film/popular_film_service.dart';
import 'package:izlenirmi/screens/home_page/popular_film/model/popular_film_model.dart';

part 'popular_films_event.dart';
part 'popular_films_state.dart';

class PopularFilmsBloc extends Bloc<PopularFilmsEvent, PopularFilmsState> {
  PopularFilmsBloc() : super(const PopularFilmsState()) {
    on<FetchPopularFilmsEvent>((event, emit) async {
      int pageCount = event.page;
      emit(state.copyWith(status: Status.loading));
      await Future.delayed(const Duration(seconds: 2));
      final response = await PopularFilmsService().fetchFilmList(pageCount);
      print(response);
      if (response != null) {
        return emit(state.copyWith(
            status: Status.completed, popularFilmModel: response));
      } else {
        emit(state.copyWith(status: Status.failed));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'popular_film_context_event.dart';
part 'popular_film_context_state.dart';

class PopularFilmContextBloc extends Bloc<PopularFilmContextEvent, PopularFilmContextState> {
  PopularFilmContextBloc() : super(const PopularFilmContextState()) {
    on<PopularFilmContextEvent>((event, emit) {
      
    });
  }
}

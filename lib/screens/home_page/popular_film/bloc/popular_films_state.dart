// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'popular_films_bloc.dart';

@immutable
class PopularFilmsState extends Equatable {
  final PopularFilmModel? popularFilmModel;
  final Enum? status;


  const PopularFilmsState({
    this.popularFilmModel,
    this.status,
  });

  @override
  List<Object?> get props => [popularFilmModel, status];

  PopularFilmsState copyWith({
    PopularFilmModel? popularFilmModel,
    Enum? status,
 
  }) {
    return PopularFilmsState(
      popularFilmModel: popularFilmModel ?? this.popularFilmModel,
      status: status ?? this.status,
 
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../base/service/translation/locale_keys.g.dart';
import '../../../../constants/enums/emuns_bloc.dart';
import '../../../../constants/network/network.dart';
import '../bloc/popular_films_bloc.dart';
import '../model/popular_film_model.dart';

class PopularFilmsBuilder extends StatelessWidget {
  const PopularFilmsBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PopularFilmsBloc>(context)
        .add(FetchPopularFilmsEvent(page: 1));
    return BlocBuilder<PopularFilmsBloc, PopularFilmsState>(
      builder: (context, state) {
        int currentPage = state.popularFilmModel?.page ?? 1;
        return Column(
          children: [
            SizedBox(
              height: 450,
              child: BlocBuilder<PopularFilmsBloc, PopularFilmsState>(
                builder: (context, state) {
                  if (state.status == Status.failed) {
                    return Container();
                  } else if (state.status == Status.completed) {
                    return PopularFilms(
                      state: state,
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 30,
                    child: IconButton(
                        onPressed: () {
                          if (currentPage != 1) {
                            context
                                .read<PopularFilmsBloc>()
                                .add(FetchPopularFilmsEvent(page: 1));
                          }
                        },
                        icon: const Icon(Icons.first_page))),
                SizedBox(
                    width: 30,
                    child: IconButton(
                        onPressed: () {
                          if (currentPage != 1) {
                            context.read<PopularFilmsBloc>().add(
                                FetchPopularFilmsEvent(page: currentPage - 1));
                          }
                        },
                        icon: const Icon(Icons.chevron_left))),
                SizedBox(
                  width: 50,
                  child: TextButton(
                      onPressed: null,
                      child: Text(
                        "$currentPage",
                        style: const TextStyle(
                            decoration: TextDecoration.underline),
                      )),
                ),
                const Text("-"),
                SizedBox(
                  width: 50,
                  child: TextButton(
                      onPressed: () {
                        if (currentPage != 100) {
                          context
                              .read<PopularFilmsBloc>()
                              .add(FetchPopularFilmsEvent(page: 100));
                        }
                      },
                      child: const Text(
                        "100",
                        style: TextStyle(decoration: TextDecoration.underline),
                      )),
                ),
                SizedBox(
                  width: 30,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputAction: TextInputAction.go,
                    onFieldSubmitted: (value) {
                      if (int.parse(value) <= 100) {
                        context.read<PopularFilmsBloc>().add(
                            FetchPopularFilmsEvent(page: int.parse(value)));
                      }
                    },
                    decoration: const InputDecoration(
                        filled: true,
                        isCollapsed: true,
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                SizedBox(
                    width: 30,
                    child: IconButton(
                        onPressed: () {
                          if (currentPage != 100) {
                            context.read<PopularFilmsBloc>().add(
                                FetchPopularFilmsEvent(page: currentPage + 1));
                          }
                        },
                        icon: const Icon(Icons.chevron_right))),
                SizedBox(
                    width: 30,
                    child: IconButton(
                        onPressed: () {
                          if (state.popularFilmModel?.page != 100) {
                            context
                                .read<PopularFilmsBloc>()
                                .add(FetchPopularFilmsEvent(page: 100));
                          }
                        },
                        icon: const Icon(Icons.last_page))),
              ],
            )
          ],
        );
      },
    );
  }
}

class PopularFilms extends StatelessWidget {
  final PopularFilmsState state;
  const PopularFilms({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: state.popularFilmModel?.results.length,
      itemBuilder: (context, index) {
        Result? result = state.popularFilmModel?.results[index];
        return SizedBox(
          width: 150,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  "$baseUrlImage500${result?.posterPath ?? ""}",
                  fit: BoxFit.fitHeight,
                  height: 230,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 228, 205, 3),
                            size: 20,
                          ),
                          Text(
                            "${result?.voteAverage ?? ""}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.star_border,
                                size: 20,
                              )),
                          Text(
                            "${result?.voteCount ?? ""}",
                            style: const TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                      SelectableText(
                        result?.title ?? "",
                        minLines: 2,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      result?.video == true
                          ? TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.play_arrow),
                              label: Text(
                                LocaleKeys.mainText_fragmanTrue.tr(),
                                maxLines: 1,
                                style: const TextStyle(),
                              ),
                            )
                          : TextButton.icon(
                              onPressed: null,
                              icon: const Icon(Icons.play_arrow),
                              label: Text(
                                LocaleKeys.mainText_fragmanFalse.tr(),
                                maxLines: 1,
                                style: const TextStyle(),
                              ),
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

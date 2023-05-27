import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:izlenirmi/base/service/translation/locale_keys.g.dart';

import '../popular_film/view/popular_film_widget.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.mainText_title.tr()),
        centerTitle: true,
      ),
      body: const PageBuilder(),
    );
  }
}

class PageBuilder extends StatelessWidget {
  const PageBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        PopularFilmsBuilder(),
      ],
    );
  }
}


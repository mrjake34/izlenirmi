import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izlenirmi/base/service/navigation/navigation_service.dart';
import 'package:izlenirmi/base/service/translation/locale_keys.g.dart';
import 'package:izlenirmi/base/service/translation/translation_service.dart';
import 'package:izlenirmi/base/service/utils/utils.dart';
import 'package:izlenirmi/screens/home_page/view/home_page_view.dart';
import 'package:izlenirmi/theme/theme_dark.dart';
import 'package:izlenirmi/theme/theme_light.dart';

import 'base/service/navigation/navigation_route.dart';
import 'screens/home_page/popular_film/bloc/popular_films_bloc.dart';

void main() {
  runApp(EasyLocalization(
      path: "assets/translation",
      supportedLocales: TranslationManager.instance!.supportedLocales,
      startLocale: TranslationManager.instance!.trLocale,
      child: MultiBlocProvider(providers: [
        BlocProvider(create: (context) => PopularFilmsBloc(),)
      ],
      child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: LocaleKeys.mainText_title.tr(),
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.instance.navigatorKey,
      scaffoldMessengerKey: UtilsService.instance.messengerKey,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      home: const HomePageView(),
    );
  }
}

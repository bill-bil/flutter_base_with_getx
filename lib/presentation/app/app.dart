import 'package:configurations/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_with_getx/commons/utils/utils.dart';
import 'package:flutter_base_with_getx/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'bindings/app_binding.dart';
import 'route/app_route.dart';
import 'styles/style.dart';

class Application extends StatelessWidget {
  final String title;
  final String locale;

  Application({required this.title, required this.locale});

  Widget _builder(BuildContext context, Widget? child) {
    return MediaQuery(
      ///Setting font does not change with system font size
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: child!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.unFocusField(context),
      child: GetMaterialApp(
        title: title,
        theme: AppThemes.defaultTheme(),
        initialBinding: AppBinding(),
        initialRoute: AppRoute.INITIAL,
        getPages: AppRoute.pages,
        builder: (context, widget) => _builder(context, widget),
        localizationsDelegates: [
          S.delegate,
          SConfig.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale(locale),
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}

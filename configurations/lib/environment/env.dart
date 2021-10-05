import 'dart:async';
import 'dart:io';

import 'package:configurations/di/di_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:configurations/network/http_overrides.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'build_config.dart';

abstract class Env {
  // Design size screen
  final Size sizeDesign = Size(375, 667);

  Env() {
    _init();
  }

  _init() {
    runZoned(() async {
      WidgetsFlutterBinding.ensureInitialized();

      await const MethodChannel('flavor')
          .invokeMethod<String>('getFlavor')
          .then((String? flavor) async {
        BuildConfig.init(flavor: flavor);
      }).catchError((error) {});

      /// Init external service
      await onInitExternalService();

      /// init session storage
      _onInitSessionStorage();

      /// Init local storage
      await onInitLocalStorage();

      /// DI
      await onInjection();

      HttpOverrides.global = MyHttpOverrides(); // use in run zone

      final StatelessWidget app = await onCreate(); // return init widget
      final wrapMultiScreen = ScreenUtilInit(
        designSize: sizeDesign,
        builder: () => app,
      );

      runApp(wrapMultiScreen);
      // ignore: deprecated_member_use
    }, onError: (Object obj, StackTrace stack) {
      print(obj);
      print(stack);
    });
  }

  Future? onInjection();

  Future? onInitLocalStorage();

  void _onInitSessionStorage() {
    getIt.registerSingletonAsync(() => SharedPreferences.getInstance());
  }

  Future? onInitExternalService();

  FutureOr<StatelessWidget> onCreate();
}

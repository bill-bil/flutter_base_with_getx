import 'package:configurations/di/di_module.dart';
import 'package:flutter_base_with_getx/commons/helpers/shared_prefs/shared_preferences_manager.dart';
import 'package:get/get.dart';

class LocalModule extends DIModule {
  @override
  provides() {
    Get.putAsync(()=> SharedPreferencesManager().init());
  }
}

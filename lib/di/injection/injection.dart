import 'package:flutter_base_with_getx/di/module/api_module.dart';
import 'package:flutter_base_with_getx/di/module/components_module.dart';
import 'package:flutter_base_with_getx/di/module/local_module.dart';
import 'package:flutter_base_with_getx/di/module/repo_module.dart';

class Injection {
  static Future inject() async {
    ComponentsModule().provides();
    LocalModule().provides();
    await ApiModule().provides();
    RepoModule().provides();
    // await UseCaseModule().provides();
  }
}

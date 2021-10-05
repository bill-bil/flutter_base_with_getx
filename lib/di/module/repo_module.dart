import 'package:configurations/di/di_module.dart';

class RepoModule extends DIModule {
  @override
  provides()  {
    // Get.lazyPut<AccountRepository>(() =>
    //     AccountRepoImplement(remoteSource: getIt.get<AccountRemoteSource>()));
  }
}

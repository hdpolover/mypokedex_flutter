import 'package:get/get.dart';
import 'package:mypokedex/app/bindings/local_source_bindings.dart';

import '../network/network_provider.dart';
import 'remote_source_bindings.dart';
import 'repository_bindings.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    RepositoryBindings().dependencies();
    RemoteSourceBindings().dependencies();
    LocalSourceBindings().dependencies();

    // network provider
    Get.put(NetworkProvider());
  }

  static void reinitializeDependencies() {
    InitialBinding().dependencies();
  }
}

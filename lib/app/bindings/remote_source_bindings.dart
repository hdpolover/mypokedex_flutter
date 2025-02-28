import 'package:get/get.dart';
import 'package:mypokedex/app/data/remote/pokemon_remote_data_source.dart';
import 'package:mypokedex/app/data/remote/pokemon_remote_data_source_impl.dart';

class RemoteSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PokemonRemoteDataSource>(
      () => PokemonRemoteDataSourceImpl(),
      tag: (PokemonRemoteDataSource).toString(),
    );
  }
}

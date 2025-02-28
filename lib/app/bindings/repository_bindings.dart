import 'package:get/get.dart';
import 'package:mypokedex/app/data/repository/pokemon_repository.dart';
import 'package:mypokedex/app/data/repository/pokemon_repository_impl.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PokemonRepository>(
      () => PokemonRepositoryImpl(),
      tag: (PokemonRepository).toString(),
    );
  }
}

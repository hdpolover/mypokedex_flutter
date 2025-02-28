import 'package:get/get.dart';
import 'package:mypokedex/app/data/repository/pokemon_repository.dart';
import 'package:mypokedex/app/data/repository/pokemon_repository_impl.dart';

import '../../../data/remote/pokemon_remote_data_source.dart';
import '../../../data/remote/pokemon_remote_data_source_impl.dart';
import '../../favorites/controllers/favorites_controller.dart';
import '../controllers/poke_details_controller.dart';

class PokeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PokeDetailsController>(
      () => PokeDetailsController(),
    );

    // pokemon repository
    Get.lazyPut<PokemonRepository>(
      () => PokemonRepositoryImpl(),
      tag: (PokemonRepository).toString(),
    );

    // remote data source
    Get.lazyPut<PokemonRemoteDataSource>(
      () => PokemonRemoteDataSourceImpl(),
      tag: (PokemonRemoteDataSource).toString(),
    );

    // favorites controller
    Get.lazyPut<FavoritesController>(
      () => FavoritesController(),
    );
  }
}

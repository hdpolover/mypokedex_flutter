import 'package:get/get.dart';
import 'package:mypokedex/app/core/models/damage_relation_model.dart';
import 'package:mypokedex/app/core/models/evolution_chain_model.dart';
import 'package:mypokedex/app/core/models/pokemon_model.dart';

import '../remote/pokemon_remote_data_source.dart';
import 'pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource =
      Get.find(tag: (PokemonRemoteDataSource).toString());

  @override
  Future<List<PokemonModel>> getAll(int offset, int limit) {
    return remoteDataSource.getPokemons(offset, limit);
  }

  @override
  Future<EvolutionChainModel> getEvolutionChain(String url) {
    int id = int.parse(url.split('/').reversed.elementAt(1));

    return remoteDataSource.getPokemonEvolutionChain(id);
  }

  @override
  Future<DamageRelationModel> getDamageRelations(String type) {
    return remoteDataSource.getPokemonDamageRelations(type);
  }

  @override
  Future<PokemonModel> getPokemonByName(String name) {
    return remoteDataSource.getPokemonByName(name);
  }
}

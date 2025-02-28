import 'package:mypokedex/app/core/models/damage_relation_model.dart';
import 'package:mypokedex/app/core/models/evolution_chain_model.dart';
import 'package:mypokedex/app/core/models/pokemon_model.dart';

abstract class PokemonRepository {
  Future<List<PokemonModel>> getAll(int offset, int limit);

  Future<PokemonModel> getPokemonByName(String name);

  Future<EvolutionChainModel> getEvolutionChain(String url);

  Future<DamageRelationModel> getDamageRelations(String type);
}

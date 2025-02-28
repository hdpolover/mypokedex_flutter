import 'package:mypokedex/app/core/models/damage_relation_model.dart';
import 'package:mypokedex/app/core/models/evolution_chain_model.dart';
import 'package:mypokedex/app/core/models/pokemon_detail_model.dart';
import 'package:mypokedex/app/core/models/pokemon_species_model.dart';

import '../../core/models/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonModel>> getPokemons(int offset, int limit);

  Future<PokemonDetailModel> getPokemonDetails(String name);

  Future<PokemonSpeciesModel> getPokemonSpecies(int id);

  Future<EvolutionChainModel> getPokemonEvolutionChain(int id);

  Future<DamageRelationModel> getPokemonDamageRelations(String type);

  Future<PokemonModel> getPokemonByName(String name);
}

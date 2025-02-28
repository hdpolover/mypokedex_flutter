import 'package:get/get.dart';
import 'package:mypokedex/app/core/models/damage_relation_model.dart';
import 'package:mypokedex/app/core/models/evolution_chain_model.dart';
import 'package:mypokedex/app/core/models/pokemon_detail_model.dart';
import 'package:mypokedex/app/core/models/pokemon_response_model.dart';
import 'package:mypokedex/app/core/models/pokemon_species_model.dart';
import 'package:mypokedex/app/core/values/app_strings.dart';

import '../../core/models/pokemon_model.dart';
import '../../network/network_provider.dart';
import 'pokemon_remote_data_source.dart';

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final NetworkProvider _networkProvider = Get.find<NetworkProvider>();

  @override
  Future<List<PokemonModel>> getPokemons(int offset, int limit) async {
    try {
      final response = await _networkProvider
          .getRequest('pokemon?offset=$offset&limit=$limit');

      // Check if response is valid
      if (response == null) {
        return [];
      }

      // Create the response model from JSON
      final PokemonResponseModel pokemonResponseModel =
          PokemonResponseModel.fromJson(response);

      // Extract the list of PokemonModel objects from the response
      List<PokemonModel> pokemons = pokemonResponseModel.results;
      List<PokemonModel> updatedPokemons = [];

      // Process each pokemon
      for (PokemonModel pokemon in pokemons) {
        try {
          String? name = pokemon.name;

          if (name != null) {
            // Get pokemon details
            try {
              PokemonDetailModel? pokemonDetailModel =
                  await getPokemonDetails(name);

              // Create new pokemon with details
              PokemonModel updatedPokemon =
                  pokemon.copyWith(details: pokemonDetailModel);
              updatedPokemons.add(updatedPokemon);
            } catch (e) {
              updatedPokemons.add(pokemon);
            }
          } else {
            // Just add the original pokemon if name is null
            updatedPokemons.add(pokemon);
          }
        } catch (e) {
          // Still add the original pokemon even if details fetch fails
          updatedPokemons.add(pokemon);
        }
      }

      return updatedPokemons;
    } catch (e) {
      // Return empty list instead of throwing to prevent app crashes
      return [];
    }
  }

  @override
  Future<PokemonDetailModel> getPokemonDetails(String name) async {
    try {
      final response = await _networkProvider.getRequest('pokemon/$name');

      // Create initial model
      PokemonDetailModel pokemonDetailModel =
          PokemonDetailModel.fromJson(response);

      // Get species data if ID is available
      if (pokemonDetailModel.id != null) {
        try {
          PokemonSpeciesModel? species =
              await getPokemonSpecies(pokemonDetailModel.id!);

          // Create a NEW model with the species data
          pokemonDetailModel = pokemonDetailModel.copyWith(species: species);
        } catch (e) {
          // Continue with null species
        }
      }

      return pokemonDetailModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PokemonSpeciesModel> getPokemonSpecies(int id) async {
    try {
      // Fetch the Pokemon species data
      final response = await _networkProvider.getRequest('pokemon-species/$id');

      final PokemonSpeciesModel pokemonSpeciesModel =
          PokemonSpeciesModel.fromJson(response);

      return pokemonSpeciesModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<EvolutionChainModel> getPokemonEvolutionChain(int id) async {
    try {
      // Fetch the Pokemon evolution chain data
      final response = await _networkProvider.getRequest('evolution-chain/$id');

      final EvolutionChainModel evolutionChainModel =
          EvolutionChainModel.fromJson(response);

      return evolutionChainModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DamageRelationModel> getPokemonDamageRelations(String type) async {
    try {
      // Fetch the Pokemon damage relations data
      final response = await _networkProvider.getRequest('type/$type');

      final DamageRelationModel damageRelationModel =
          DamageRelationModel.fromJson(response);

      return damageRelationModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PokemonModel> getPokemonByName(String name) async {
    try {
      // Fetch the Pokemon data by name
      final PokemonModel? pokemonModel;

      PokemonDetailModel? pokemonDetailModel = await getPokemonDetails(name);

      String url = '${AppStrings.baseUrl}/pokemon/$name';

      // Create a new PokemonModel with the details
      pokemonModel = PokemonModel(name, url, pokemonDetailModel);

      return pokemonModel;
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:mypokedex/app/core/models/pokemon_move_model.dart';
import 'package:mypokedex/app/core/models/pokemon_species_model.dart';
import 'package:mypokedex/app/core/models/pokemon_stats_model.dart';
import 'package:mypokedex/app/core/models/pokemon_type_model.dart';

class PokemonDetailModel {
  final int? id;
  final String? officialArtUrl;
  final List<String>? abilities;
  final List<PokemonStatsModel>? stats;
  final List<PokemonTypeModel>? types;
  final List<PokemonMoveModel>? moves;
  final int? weight;
  final int? height;
  final PokemonSpeciesModel? species;

  PokemonDetailModel(
    this.id,
    this.officialArtUrl,
    this.stats,
    this.types,
    this.weight,
    this.height,
    this.species,
    this.abilities,
    this.moves,
  );

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    // Safely access nested properties
    String? artworkUrl;
    try {
      artworkUrl =
          json['sprites']?['other']?['official-artwork']?['front_default'];
    } catch (_) {
      artworkUrl = null;
    }

    // Handle stats conversion safely
    List<PokemonStatsModel> stats = [];
    if (json['stats'] != null) {
      try {
        stats = (json['stats'] as List)
            .map((x) => PokemonStatsModel.fromMap(x as Map<String, dynamic>))
            .toList();
      } catch (e) {
        print('Error parsing stats: $e');
      }
    }

    // Handle types conversion safely
    List<PokemonTypeModel> types = [];
    if (json['types'] != null) {
      try {
        types = (json['types'] as List)
            .map((x) => PokemonTypeModel.fromMap(x as Map<String, dynamic>))
            .toList();
      } catch (e) {
        print('Error parsing types: $e');
      }
    }

    // abilities
    List<String> abilities = [];

    if (json['abilities'] != null) {
      try {
        abilities = (json['abilities'] as List)
            .map((x) => x['ability']['name'] as String)
            .toList();
      } catch (e) {
        print('Error parsing abilities: $e');
      }
    }

    // moves
    List<PokemonMoveModel> moves = [];

    if (json['moves'] != null) {
      try {
        moves = (json['moves'] as List)
            .map((x) => PokemonMoveModel.fromMap(x as Map<String, dynamic>))
            .toList();
      } catch (e) {
        print('Error parsing moves: $e');
      }
    }

    return PokemonDetailModel(
      json['id'] as int?,
      artworkUrl,
      stats,
      types,
      json['weight'], // Divide by 10 to get kg
      json['height'],
      null, // Species requires separate API call
      abilities,
      moves,
    );
  }

  PokemonDetailModel copyWith({
    int? id,
    String? officialArtUrl,
    List<PokemonStatsModel>? stats,
    List<PokemonTypeModel>? types,
    int? weight,
    int? height,
    PokemonSpeciesModel? species,
    List<String>? abilities,
    List<PokemonMoveModel>? moves,
  }) {
    return PokemonDetailModel(
      id ?? this.id,
      officialArtUrl ?? this.officialArtUrl,
      stats ?? this.stats,
      types ?? this.types,
      weight ?? this.weight,
      height ?? this.height,
      species ?? this.species,
      abilities ?? this.abilities,
      moves ?? this.moves,
    );
  }

  @override
  String toString() {
    return 'PokemonDetailModel(id: $id, officialArtUrl: $officialArtUrl, stats: $stats, types: $types, weight: $weight, height: $height, species: $species)';
  }
}

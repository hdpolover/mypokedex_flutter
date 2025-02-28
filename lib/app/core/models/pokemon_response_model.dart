import 'package:mypokedex/app/core/models/pokemon_model.dart';

class PokemonResponseModel {
  final int count;
  final String next;
  final String previous;
  final List<PokemonModel> results;

  PokemonResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PokemonResponseModel.fromJson(Map<String, dynamic> json) {
    final List<PokemonModel> results = [];

    if (json['results'] != null) {
      json['results'].forEach((pokemon) {
        results.add(PokemonModel.fromMap(pokemon));
      });
    }

    return PokemonResponseModel(
      count: json['count'] ?? 0,
      next: json['next'] ?? '',
      previous: json['previous'] ?? '',
      results: results,
    );
  }
}

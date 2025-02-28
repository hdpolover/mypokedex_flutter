import 'package:mypokedex/app/core/models/pokemon_detail_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PokemonModel {
  final String? name;
  final String? url;

  final PokemonDetailModel? details;

  PokemonModel(
    this.name,
    this.url,
    this.details,
  );

  // from json factory
  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      json['name'] as String,
      json['url'] as String,
      // at first, details is null
      null,
    );
  }

  // from map factory
  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    return PokemonModel(
      map['name'] as String,
      map['url'] as String,
      // at first, details is null
      null,
    );
  }

  PokemonModel copyWith({
    String? name,
    String? url,
    PokemonDetailModel? details,
  }) {
    return PokemonModel(
      name ?? this.name,
      url ?? this.url,
      details ?? this.details,
    );
  }

  @override
  String toString() =>
      'PokemonModel(name: $name, url: $url, details: $details)';

  @override
  bool operator ==(covariant PokemonModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.url == url && other.details == details;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode ^ details.hashCode;
}

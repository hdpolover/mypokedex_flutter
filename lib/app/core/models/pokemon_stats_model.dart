class PokemonStatsModel {
  final int? baseStat;
  final int? effort;
  final Stat? stat;

  PokemonStatsModel(
    this.baseStat,
    this.effort,
    this.stat,
  );

  // from json factory
  factory PokemonStatsModel.fromMap(Map<String, dynamic> map) {
    return PokemonStatsModel(
      map['base_stat'] as int?,
      map['effort'] as int?,
      Stat.fromMap(map['stat'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() =>
      'PokemonStatsModel(baseStat: $baseStat, effort: $effort, stat: $stat)';
}

class Stat {
  final String? name;
  final String? url;

  Stat(
    this.name,
    this.url,
  );

  // from json
  factory Stat.fromMap(Map<String, dynamic> map) {
    return Stat(
      map['name'] as String?,
      map['url'] as String?,
    );
  }

  @override
  String toString() => 'Stat(name: $name, url: $url)';
}

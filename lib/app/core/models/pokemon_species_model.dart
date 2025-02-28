class PokemonSpeciesModel {
  final double? baseHappiness;
  final double? captureRate;
  final String? color;
  final List<String>? eggGroups;
  final String? evolutionChainUrl;
  final String? flavorText;
  final int? genderRate;
  final String? shape;

  PokemonSpeciesModel(
    this.baseHappiness,
    this.captureRate,
    this.color,
    this.eggGroups,
    this.evolutionChainUrl,
    this.flavorText,
    this.genderRate,
    this.shape,
  );

  factory PokemonSpeciesModel.fromJson(Map<String, dynamic> json) {
    // Handle color object - the API returns color as an object with name property
    String? colorName;
    if (json['color'] != null && json['color'] is Map<String, dynamic>) {
      colorName = json['color']['name'];
    }

    // Handle egg groups - convert list of objects to list of strings
    List<String> eggGroups = [];
    if (json['egg_groups'] != null) {
      eggGroups = (json['egg_groups'] as List)
          .map((group) => group['name'] as String)
          .toList();
    }

    // Handle evolution chain URL
    String? evolutionChainUrl;
    if (json['evolution_chain'] != null && json['evolution_chain'] is Map) {
      evolutionChainUrl = json['evolution_chain']['url'];
    }

    // Handle flavor text - get the last English entry if available
    String? flavorText;
    if (json['flavor_text_entries'] != null) {
      var entries = json['flavor_text_entries'] as List;
      var englishEntry = entries.firstWhere(
        (entry) => entry['language']['name'] == 'en',
        orElse: () => entries.isNotEmpty ? entries.last : null,
      );

      if (englishEntry != null) {
        flavorText = englishEntry['flavor_text'];
      }
    }

    return PokemonSpeciesModel(
      json['base_happiness'] != null
          ? (json['base_happiness'] as int).toDouble()
          : null,
      json['capture_rate'] != null
          ? (json['capture_rate'] as int).toDouble()
          : null,
      colorName,
      eggGroups,
      evolutionChainUrl,
      flavorText,
      json['gender_rate'],
      json['shape']['name'],
    );
  }

  @override
  String toString() {
    return 'PokemonSpeciesModel(baseHappiness: $baseHappiness, captureRate: $captureRate, color: $color, eggGroups: $eggGroups, evolutionChainUrl: $evolutionChainUrl, flavorText: $flavorText)';
  }
}

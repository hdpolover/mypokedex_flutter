class EvolutionChainModel {
  final dynamic babyTriggerItem;
  final Chain? chain;
  final int? id;

  EvolutionChainModel({
    this.babyTriggerItem,
    this.chain,
    this.id,
  });

  factory EvolutionChainModel.fromJson(Map<String, dynamic> json) {
    return EvolutionChainModel(
      babyTriggerItem: json['baby_trigger_item'],
      chain: Chain.fromJson(json['chain']),
      id: json['id'],
    );
  }
}

class Chain {
  final List<EvolutionDetail> evolutionDetails;
  final List<Chain> evolvesTo;
  final bool isBaby;
  final Species species;

  Chain({
    required this.evolutionDetails,
    required this.evolvesTo,
    required this.isBaby,
    required this.species,
  });

  factory Chain.fromJson(Map<String, dynamic> json) {
    var evolvesToList = json['evolves_to'] as List;
    List<Chain> evolvesTo =
        evolvesToList.map((i) => Chain.fromJson(i)).toList();

    var evolutionDetailsList = json['evolution_details'] as List;
    List<EvolutionDetail> evolutionDetails =
        evolutionDetailsList.map((i) => EvolutionDetail.fromJson(i)).toList();

    return Chain(
      evolutionDetails: evolutionDetails,
      evolvesTo: evolvesTo,
      isBaby: json['is_baby'],
      species: Species.fromJson(json['species']),
    );
  }
}

class EvolutionDetail {
  final dynamic gender;
  final dynamic heldItem;
  final dynamic item;
  final dynamic knownMove;
  final dynamic knownMoveType;
  final dynamic location;
  final dynamic minAffection;
  final dynamic minBeauty;
  final dynamic minHappiness;
  final int? minLevel;
  final bool needsOverworldRain;
  final dynamic partySpecies;
  final dynamic partyType;
  final dynamic relativePhysicalStats;
  final String timeOfDay;
  final dynamic tradeSpecies;
  final Trigger trigger;
  final bool turnUpsideDown;

  EvolutionDetail({
    required this.gender,
    required this.heldItem,
    required this.item,
    required this.knownMove,
    required this.knownMoveType,
    required this.location,
    required this.minAffection,
    required this.minBeauty,
    required this.minHappiness,
    required this.minLevel,
    required this.needsOverworldRain,
    required this.partySpecies,
    required this.partyType,
    required this.relativePhysicalStats,
    required this.timeOfDay,
    required this.tradeSpecies,
    required this.trigger,
    required this.turnUpsideDown,
  });

  factory EvolutionDetail.fromJson(Map<String, dynamic> json) {
    return EvolutionDetail(
      gender: json['gender'],
      heldItem: json['held_item'],
      item: json['item'],
      knownMove: json['known_move'],
      knownMoveType: json['known_move_type'],
      location: json['location'],
      minAffection: json['min_affection'],
      minBeauty: json['min_beauty'],
      minHappiness: json['min_happiness'],
      minLevel: json['min_level'],
      needsOverworldRain: json['needs_overworld_rain'],
      partySpecies: json['party_species'],
      partyType: json['party_type'],
      relativePhysicalStats: json['relative_physical_stats'],
      timeOfDay: json['time_of_day'],
      tradeSpecies: json['trade_species'],
      trigger: Trigger.fromJson(json['trigger']),
      turnUpsideDown: json['turn_upside_down'],
    );
  }
}

class Trigger {
  final String name;
  final String url;

  Trigger({
    required this.name,
    required this.url,
  });

  factory Trigger.fromJson(Map<String, dynamic> json) {
    return Trigger(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Species {
  final String name;
  final String url;

  Species({
    required this.name,
    required this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      name: json['name'],
      url: json['url'],
    );
  }
}

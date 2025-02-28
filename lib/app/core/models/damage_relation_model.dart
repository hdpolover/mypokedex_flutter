class DamageRelation {
  final String? name;
  final String? url;

  DamageRelation({required this.name, required this.url});

  factory DamageRelation.fromJson(Map<String, dynamic> json) {
    return DamageRelation(
      name: json['name'],
      url: json['url'],
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }
}

class DamageRelations {
  final List<DamageRelation>? noDamageTo;
  final List<DamageRelation>? halfDamageTo;
  final List<DamageRelation>? doubleDamageTo;
  final List<DamageRelation>? noDamageFrom;
  final List<DamageRelation>? halfDamageFrom;
  final List<DamageRelation>? doubleDamageFrom;

  DamageRelations({
    required this.noDamageTo,
    required this.halfDamageTo,
    required this.doubleDamageTo,
    required this.noDamageFrom,
    required this.halfDamageFrom,
    required this.doubleDamageFrom,
  });

  factory DamageRelations.fromJson(Map<String, dynamic> json) {
    return DamageRelations(
      noDamageTo: (json['no_damage_to'] as List?)
          ?.map((i) => DamageRelation.fromJson(i))
          .toList(),
      halfDamageTo: (json['half_damage_to'] as List?)
          ?.map((i) => DamageRelation.fromJson(i))
          .toList(),
      doubleDamageTo: (json['double_damage_to'] as List?)
          ?.map((i) => DamageRelation.fromJson(i))
          .toList(),
      noDamageFrom: (json['no_damage_from'] as List?)
          ?.map((i) => DamageRelation.fromJson(i))
          .toList(),
      halfDamageFrom: (json['half_damage_from'] as List?)
          ?.map((i) => DamageRelation.fromJson(i))
          .toList(),
      doubleDamageFrom: (json['double_damage_from'] as List?)
          ?.map((i) => DamageRelation.fromJson(i))
          .toList(),
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'no_damage_to': noDamageTo?.map((e) => e.toMap()).toList(),
      'half_damage_to': halfDamageTo?.map((e) => e.toMap()).toList(),
      'double_damage_to': doubleDamageTo?.map((e) => e.toMap()).toList(),
      'no_damage_from': noDamageFrom?.map((e) => e.toMap()).toList(),
      'half_damage_from': halfDamageFrom?.map((e) => e.toMap()).toList(),
      'double_damage_from': doubleDamageFrom?.map((e) => e.toMap()).toList(),
    };
  }
}

class DamageRelationModel {
  final int? id;
  final String? name;
  final DamageRelations? damageRelations;

  DamageRelationModel({
    required this.id,
    required this.name,
    required this.damageRelations,
  });

  factory DamageRelationModel.fromJson(Map<String, dynamic> json) {
    return DamageRelationModel(
      id: json['id'],
      name: json['name'],
      damageRelations: DamageRelations.fromJson(json['damage_relations']),
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'damage_relations': damageRelations?.toMap(),
    };
  }
}

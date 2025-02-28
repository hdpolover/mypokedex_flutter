class PokemonMoveModel {
  final Move move;
  final List<VersionGroupDetail> versionGroupDetails;

  PokemonMoveModel({
    required this.move,
    required this.versionGroupDetails,
  });

  factory PokemonMoveModel.fromMap(Map<String, dynamic> map) {
    return PokemonMoveModel(
      move: Move.fromMap(map['move']),
      versionGroupDetails: (map['version_group_details'] as List)
          .map((detail) => VersionGroupDetail.fromMap(detail))
          .toList(),
    );
  }
}

class Move {
  final String name;
  final String url;

  Move({
    required this.name,
    required this.url,
  });

  factory Move.fromMap(Map<String, dynamic> map) {
    return Move(
      name: map['name'],
      url: map['url'],
    );
  }
}

class VersionGroupDetail {
  final int levelLearnedAt;
  final MoveLearnMethod moveLearnMethod;
  final VersionGroup versionGroup;

  VersionGroupDetail({
    required this.levelLearnedAt,
    required this.moveLearnMethod,
    required this.versionGroup,
  });

  factory VersionGroupDetail.fromMap(Map<String, dynamic> map) {
    return VersionGroupDetail(
      levelLearnedAt: map['level_learned_at'],
      moveLearnMethod: MoveLearnMethod.fromMap(map['move_learn_method']),
      versionGroup: VersionGroup.fromMap(map['version_group']),
    );
  }
}

class MoveLearnMethod {
  final String name;
  final String url;

  MoveLearnMethod({
    required this.name,
    required this.url,
  });

  factory MoveLearnMethod.fromMap(Map<String, dynamic> map) {
    return MoveLearnMethod(
      name: map['name'],
      url: map['url'],
    );
  }
}

class VersionGroup {
  final String name;
  final String url;

  VersionGroup({
    required this.name,
    required this.url,
  });

  factory VersionGroup.fromMap(Map<String, dynamic> map) {
    return VersionGroup(
      name: map['name'],
      url: map['url'],
    );
  }
}

extension PokemonMoveModelExtension on Map<String, dynamic> {
  PokemonMoveModel toPokemonMoveModel() {
    return PokemonMoveModel.fromMap(this);
  }
}

extension MoveExtension on Map<String, dynamic> {
  Move toMove() {
    return Move.fromMap(this);
  }
}

extension VersionGroupDetailExtension on Map<String, dynamic> {
  VersionGroupDetail toVersionGroupDetail() {
    return VersionGroupDetail.fromMap(this);
  }
}

extension MoveLearnMethodExtension on Map<String, dynamic> {
  MoveLearnMethod toMoveLearnMethod() {
    return MoveLearnMethod.fromMap(this);
  }
}

extension VersionGroupExtension on Map<String, dynamic> {
  VersionGroup toVersionGroup() {
    return VersionGroup.fromMap(this);
  }
}

class PokemonTypeModel {
  final int slot;
  final TypeInfo type;

  PokemonTypeModel({required this.slot, required this.type});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slot': slot,
      'type': type.toMap(),
    };
  }

  factory PokemonTypeModel.fromMap(Map<String, dynamic> map) {
    return PokemonTypeModel(
      slot: map['slot'] as int,
      type: TypeInfo.fromMap(map['type'] as Map<String, dynamic>),
    );
  }
}

class TypeInfo {
  final String name;
  final String url;

  TypeInfo({required this.name, required this.url});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory TypeInfo.fromMap(Map<String, dynamic> map) {
    return TypeInfo(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }
}

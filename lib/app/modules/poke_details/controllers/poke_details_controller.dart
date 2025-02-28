import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypokedex/app/core/models/damage_relation_model.dart';
import 'package:mypokedex/app/core/models/evolution_chain_model.dart';
import 'package:mypokedex/app/core/models/pokemon_model.dart';
import 'package:mypokedex/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:mypokedex/app/modules/poke_details/views/widgets/about_tab.dart';
import 'package:mypokedex/app/modules/poke_details/views/widgets/evo_tab.dart';
import 'package:mypokedex/app/modules/poke_details/views/widgets/moves_tab.dart';
import 'package:mypokedex/app/modules/poke_details/views/widgets/stats_tab.dart';

import '../../../data/repository/pokemon_repository.dart';

class PokeDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PokemonRepository _repository =
      Get.find(tag: (PokemonRepository).toString());

  // Initialize the observable with the passed Pokemon
  final Rx<PokemonModel> pokemonObs =
      Rx<PokemonModel>(Get.arguments as PokemonModel);

  final Rx<EvolutionChainModel> evolutionChain = EvolutionChainModel().obs;

  // damage relations
  final RxList<DamageRelationModel> damageRelations =
      <DamageRelationModel>[].obs;

  late TabController tabController;
  final List<String> tabs = ["About", "Base Stats", "Evolution", "Moves"];
  final RxInt currentTabIndex = 0.obs;

  late List<Widget> tabViews;

  @override
  void onInit() {
    super.onInit();

    // Initialize tab controller
    tabController = TabController(length: tabs.length, vsync: this);

    // Listen for tab changes
    tabController.addListener(() {
      currentTabIndex.value = tabController.index;
    });

    tabViews = [
      AboutTab(),
      StatsTab(),
      EvoTab(),
      MovesTab(),
    ];

    // get evo chain
    getEvoChain();
  }

  getEvoChain() {
    String url = pokemonObs.value.details!.species!.evolutionChainUrl!;

    _repository.getEvolutionChain(url).then((value) {
      evolutionChain.value = value;
    });
  }

  getDamageRelations() async {
    List<String> types = [];

    for (var element in pokemonObs.value.details!.types!) {
      types.add(element.type.name);
    }

    for (var type in types) {
      await _repository.getDamageRelations(type).then((value) {
        damageRelations.add(value);
      });
    }
  }

  // add favorite
  void toggleFavorite(PokemonModel pokemon) {
    FavoritesController favoritesController = Get.find<FavoritesController>();

    favoritesController.toggleFavorite(pokemon);
  }

  // check if pokemon is favorite
  bool isFavorite(PokemonModel pokemon) {
    FavoritesController favoritesController = Get.find<FavoritesController>();

    return favoritesController.isFavorite(pokemon);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

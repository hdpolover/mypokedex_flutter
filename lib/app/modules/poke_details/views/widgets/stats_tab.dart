import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypokedex/app/core/models/damage_relation_model.dart';
import 'package:mypokedex/app/core/models/pokemon_model.dart';
import 'package:mypokedex/app/core/utils/common_functions.dart';
import 'package:mypokedex/app/core/values/app_text_styles.dart';

import '../../controllers/poke_details_controller.dart';

class StatsTab extends StatelessWidget {
  const StatsTab({super.key});

  String getStatName(String name) {
    switch (name) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'Attack';
      case 'defense':
        return 'Defense';
      case 'special-attack':
        return 'Sp. Atk';
      case 'special-defense':
        return 'Sp. Def';
      case 'speed':
        return 'Speed';
      default:
        return name;
    }
  }

  buildStatItem(BuildContext context, String label, int value) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            getStatName(label),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            value.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        // add visual representation of the stat
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(
            value: value / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              value < 30
                  ? Colors.red
                  : value < 50
                      ? Colors.orange
                      : value < 70
                          ? Colors.yellow
                          : value < 90
                              ? Colors.lightGreen
                              : Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTypeEffectivenessGrid(
      BuildContext context, List<DamageRelationModel> damageRelations) {
    // Calculate effectiveness for each type against this Pokémon
    Map<String, double> typeEffectiveness =
        calculateTypeEffectiveness(damageRelations);

    return GridView.builder(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.isLandscape ? 6 : 3,
        childAspectRatio: context.isLandscape ? 3 : 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: typeEffectiveness.length,
      itemBuilder: (context, index) {
        String typeName = typeEffectiveness.keys.elementAt(index);
        double multiplier = typeEffectiveness[typeName]!;

        // Format multiplier for display
        String effectivenessText;
        Color effectivenessColor;

        if (multiplier == 0) {
          effectivenessText = "0x";
          effectivenessColor = Colors.grey;
        } else if (multiplier < 1) {
          effectivenessText = "½×";
          effectivenessColor = Colors.green;
        } else if (multiplier > 1) {
          effectivenessText = "2×";
          effectivenessColor = Colors.red;
        } else {
          effectivenessText = "1×";
          effectivenessColor = Colors.black54;
        }

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey[300]!,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Type icon or name
                Text(
                  CommonFunctions.capitalize(typeName),
                  style: AppTextStyles.bodySmall,
                ),
                // Effectiveness indicator
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                      color: effectivenessColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    effectivenessText,
                    style: TextStyle(
                      color: effectivenessColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Map<String, double> calculateTypeEffectiveness(
      List<DamageRelationModel> damageRelations) {
    // Initialize all types with normal effectiveness (1x)
    Map<String, double> effectiveness = {
      'normal': 1.0,
      'fire': 1.0,
      'water': 1.0,
      'electric': 1.0,
      'grass': 1.0,
      'ice': 1.0,
      'fighting': 1.0,
      'poison': 1.0,
      'ground': 1.0,
      'flying': 1.0,
      'psychic': 1.0,
      'bug': 1.0,
      'rock': 1.0,
      'ghost': 1.0,
      'dragon': 1.0,
      'dark': 1.0,
      'steel': 1.0,
      'fairy': 1.0
    };

    // Process each damage relation
    for (var relation in damageRelations) {
      // Double damage from these types (weakness)
      for (var type in relation.damageRelations!.doubleDamageFrom!) {
        effectiveness[type.name!] = effectiveness[type.name]! * 2;
      }

      // Half damage from these types (resistance)
      for (var type in relation.damageRelations!.halfDamageFrom!) {
        effectiveness[type.name!] = effectiveness[type.name]! * 0.5;
      }

      // No damage from these types (immunity)
      for (var type in relation.damageRelations!.noDamageFrom!) {
        effectiveness[type.name!] = 0;
      }
    }

    // Remove types with no effect
    effectiveness.removeWhere((key, value) => value == 1.0);

    // Sort by effectiveness (most to least effective)
    var sortedMap = Map.fromEntries(effectiveness.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value)));

    return sortedMap;
  }

  buildTypeEffectiveness(
      BuildContext context, List<DamageRelationModel> damageRelations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          "Damage Relations",
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "How effective this Pokémon is against other types",
          style: AppTextStyles.bodySmall,
        ),
        buildTypeEffectivenessGrid(context, damageRelations)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    PokeDetailsController controller = Get.find<PokeDetailsController>();

    return Obx(() {
      PokemonModel pokemon = controller.pokemonObs.value;

      List<Widget> stats = [];

      for (var stat in pokemon.details!.stats!) {
        stats.add(buildStatItem(context, stat.stat!.name!, stat.baseStat!));
      }

      List<DamageRelationModel> damageRelations = controller.damageRelations;

      if (damageRelations.isNotEmpty) {
        stats.add(
          buildTypeEffectiveness(context, damageRelations),
        );
      } else {
        controller.getDamageRelations();
      }

      return ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Base Stats",
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...stats,
            ],
          ),
        ],
      );
    });
  }
}

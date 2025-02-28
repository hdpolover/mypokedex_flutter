// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mypokedex/app/core/models/pokemon_model.dart';
import 'package:mypokedex/app/core/utils/common_functions.dart';
import 'package:mypokedex/app/modules/poke_details/controllers/poke_details_controller.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({
    super.key,
  });

  buildDescItem(BuildContext context, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  buildAboutText(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  getAbilities(PokemonModel pokemon) {
    List<String> abilities = [];
    for (var ability in pokemon.details!.abilities!) {
      abilities.add(CommonFunctions.capitalize(ability));
    }

    return abilities.join(", ");
  }

  Widget buildGenderRatio(BuildContext context, PokemonModel pokemon) {
    // Get gender rate from the Pokemon details
    // The gender rate indicates the chance of being female in eighths (0-8)
    // 0 = always male, 8 = always female, -1 = genderless
    int genderRate = pokemon.details?.species?.genderRate?.toInt() ?? -1;

    if (genderRate < 0) {
      // Pokemon is genderless
      return Row(
        children: [
          Icon(Icons.do_not_disturb, color: Colors.grey),
          SizedBox(width: 8),
          Text("Genderless", style: Theme.of(context).textTheme.bodyMedium),
        ],
      );
    }

    // Calculate percentages
    double femalePercentage = (genderRate / 8) * 100;
    double malePercentage = 100 - femalePercentage;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "Gender",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              // Male row

              Row(
                children: [
                  Icon(Icons.male, color: Colors.blue),
                  SizedBox(width: 8),
                  Text("${malePercentage.toStringAsFixed(1)}%",
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              // Female row
              Row(
                children: [
                  Icon(Icons.female, color: Colors.pink),
                  SizedBox(width: 8),
                  Text("${femalePercentage.toStringAsFixed(1)}%",
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    PokeDetailsController controller = Get.find<PokeDetailsController>();

    PokemonModel pokemon = controller.pokemonObs.value;

    String text =
        CommonFunctions.mergeText(pokemon.details!.species!.flavorText!);

    String eggGroups = "";

    for (var group in pokemon.details!.species!.eggGroups!) {
      eggGroups += "${CommonFunctions.capitalize(group)}, ";
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      children: [
        buildAboutText(context, text),
        const SizedBox(height: 20),
        Text(
          "Details",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 10),
        buildDescItem(context, "Shape",
            CommonFunctions.capitalize(pokemon.details!.species!.shape!)),
        SizedBox(height: 10),
        buildDescItem(context, "Height",
            CommonFunctions.showHeight(pokemon.details!.height!)),
        SizedBox(height: 10),
        buildDescItem(context, "Weight",
            CommonFunctions.showWeight(pokemon.details!.weight!)),
        SizedBox(height: 10),
        buildDescItem(context, "Abilities", getAbilities(pokemon)),
        SizedBox(height: 20),
        Text(
          "Breeeding",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 10),
        buildGenderRatio(context, pokemon),
        SizedBox(height: 10),
        buildDescItem(context, "Egg Groups",
            eggGroups.substring(0, eggGroups.length - 2)),
        SizedBox(height: 10),
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypokedex/app/core/models/evolution_chain_model.dart';
import 'package:mypokedex/app/core/utils/common_functions.dart';
import 'package:mypokedex/app/core/values/app_text_styles.dart';
import 'package:mypokedex/app/modules/home/controllers/home_controller.dart';
import 'package:mypokedex/app/modules/poke_details/controllers/poke_details_controller.dart';

import '../../../../core/widgets/poke_loading.dart';

class EvoTab extends StatelessWidget {
  const EvoTab({super.key});

  buildEvoList(BuildContext context, EvolutionChainModel chain) {
    List<Widget> evoCards = [];

    // Start with the base Pokemon
    if (chain.chain != null) {
      // Process the entire evolution chain recursively
      _processEvolutionChain(chain.chain!, evoCards, null);
    }

    return SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: context.isLandscape
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: evoCards,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: evoCards,
              ));
  }

// Recursive function to process the evolution chain
  void _processEvolutionChain(
      Chain currentChain, List<Widget> evoCards, String? evolutionDetail) {
    // Add the current species
    String speciesName = currentChain.species.name;
    evoCards.add(buildEvoCard(speciesName, evolutionDetail ?? ""));

    // Process all next evolutions
    for (var evolution in currentChain.evolvesTo) {
      // Get evolution details
      String detail = _getEvolutionDetail(evolution.evolutionDetails);

      // Process the next link in the chain
      _processEvolutionChain(evolution, evoCards, detail);
    }
  }

// Extract meaningful evolution details
  String _getEvolutionDetail(List<EvolutionDetail> details) {
    if (details.isEmpty) return "";

    // Get the first evolution detail (usually the main one)
    var detail = details[0];

    // Level-up evolution
    if (detail.trigger.name == "level-up") {
      if (detail.minLevel != null) {
        return "Level ${detail.minLevel}";
      }
      if (detail.minHappiness != null) {
        return "Happiness";
      }
      if (detail.minBeauty != null) {
        return "Beauty";
      }
      if (detail.minAffection != null) {
        return "Affection";
      }
    }

    // Item evolution
    if (detail.trigger.name == "use-item" && detail.item != null) {
      // get item name
      Map<String, dynamic> item = detail.item!;

      String itemName = "";

      // Check if item name is available
      if (item['name'] != null) {
        itemName = item['name'];
      }

      String formattedText = CommonFunctions.capitalize(itemName);

      return "Use $formattedText";
    }

    // Trade evolution
    if (detail.trigger.name == "trade") {
      if (detail.heldItem != null) {
        // get item name
        Map<String, dynamic> item = detail.heldItem!;

        String itemName = "";

        // Check if item name is available
        if (item['name'] != null) {
          itemName = item['name'];
        }

        String formattedText = CommonFunctions.capitalize(itemName);

        return "Trade holding $formattedText";
      }
      return "Trade";
    }

    // Other evolution types
    return detail.trigger.name;
  }

// Helper method to build an evolution card
  Widget buildEvoCard(String name, String evolutionDetail) {
    HomeController controller = Get.find<HomeController>();

    String pokemonImageUrl = controller.getPokemonImageUrl(name);

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: pokemonImageUrl,
            height: Get.height * 0.15,
            errorWidget: (context, url, error) => Image.asset(
              "assets/pokeball.png",
              color: Colors.grey[300],
              height: Get.height * 0.1,
            ),
          ),
          SizedBox(height: 8),
          Text(
            name.capitalize!,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (evolutionDetail.isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                evolutionDetail,
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.black,
                  fontSize: 10,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PokeDetailsController controller = Get.find<PokeDetailsController>();

    return Obx(() {
      EvolutionChainModel? evoChain = controller.evolutionChain.value;

      if (evoChain.chain == null) {
        return Center(
          child: PokeLoading(),
        );
      }

      return buildEvoList(context, evoChain);
    });
  }
}

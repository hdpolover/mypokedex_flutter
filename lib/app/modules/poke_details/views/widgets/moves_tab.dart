import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypokedex/app/core/models/pokemon_model.dart';
import 'package:mypokedex/app/core/models/pokemon_move_model.dart';
import 'package:mypokedex/app/core/utils/common_functions.dart';
import 'package:mypokedex/app/core/values/app_text_styles.dart';

import '../../controllers/poke_details_controller.dart';

class MovesTab extends StatelessWidget {
  const MovesTab({super.key});

  buildMoveDetaiItem(VersionGroupDetail versionGroupDetail) {
    String versionGroupName = CommonFunctions.capitalize(
      versionGroupDetail.versionGroup.name,
    );

    String moveLearnMethod =
        CommonFunctions.capitalize(versionGroupDetail.moveLearnMethod.name);

    String levelLearnedAt = versionGroupDetail.levelLearnedAt.toString();

    return Text(
      'By $moveLearnMethod at level $levelLearnedAt ($versionGroupName)',
      style: AppTextStyles.bodySmall,
    );
  }

  buildMoveItem(PokemonMoveModel move) {
    List<Widget> moveDetails = [];

    for (var versionGroupDetail in move.versionGroupDetails) {
      moveDetails.add(buildMoveDetaiItem(versionGroupDetail));
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CommonFunctions.capitalize(move.move.name),
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          ...moveDetails,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PokeDetailsController controller = Get.find<PokeDetailsController>();

    PokemonModel pokemon = controller.pokemonObs.value;

    return ListView.builder(
      primary: false,
      itemCount: pokemon.details!.moves!.length,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      itemBuilder: (context, index) {
        return buildMoveItem(pokemon.details!.moves![index]);
      },
    );
  }
}

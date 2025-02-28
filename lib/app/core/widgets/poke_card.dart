import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypokedex/app/core/models/pokemon_model.dart';
import 'package:mypokedex/app/core/values/app_text_styles.dart';
import 'package:mypokedex/app/core/widgets/pokeball_bg.dart';

import '../utils/common_functions.dart';
import 'poke_type_chip.dart';

class PokeCard extends StatelessWidget {
  final PokemonModel pokemon;
  final VoidCallback onTap;

  const PokeCard({super.key, required this.pokemon, required this.onTap});

  // Get color based on pokemon color
  Color get color =>
      CommonFunctions.getPokemonColor(pokemon.details!.species!.color!);

  @override
  Widget build(BuildContext context) {
    double localHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: -12,
              right: -12,
              child: PokeballBg(
                height:
                    context.isLandscape ? localHeight * 0.2 : localHeight * 0.1,
              ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Hero(
                tag: pokemon.details!.officialArtUrl!,
                child: CachedNetworkImage(
                  imageUrl: pokemon.details!.officialArtUrl!,
                  height: context.isLandscape
                      ? localHeight * 0.2
                      : localHeight * 0.1,
                  scale: 1.5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  SizedBox(height: 5),
                  // pokemon number
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "#${pokemon.details!.id.toString().padLeft(3, '0')}",
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    CommonFunctions.capitalize(pokemon.name!),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // pokemon types
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: pokemon.details!.types!
                        .map((type) => PokeTypeChip(
                              type: CommonFunctions.capitalize(type.type.name),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

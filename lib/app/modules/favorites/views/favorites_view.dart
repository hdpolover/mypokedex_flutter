import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mypokedex/app/core/models/pokemon_model.dart';
import 'package:mypokedex/app/core/values/app_text_styles.dart';
import 'package:mypokedex/app/core/widgets/custom_app_bar.dart';
import 'package:mypokedex/app/core/widgets/poke_card.dart';

import '../../../routes/app_pages.dart';
import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({super.key});

  buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            size: 50,
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          Text(
            'No favorite pokemons yet',
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  buildFavList(List<PokemonModel> favs) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: favs.length,
      itemBuilder: (context, index) {
        PokemonModel pokemon = favs[index];

        return PokeCard(
            pokemon: pokemon,
            onTap: () {
              Get.toNamed(Routes.POKE_DETAILS, arguments: pokemon);
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<PokemonModel> favoritePokemons = controller.favoritePokemons;

      return Scaffold(
        appBar: CustomAppBar(title: 'Favorite Pokemons'),
        body: favoritePokemons.isEmpty
            ? buildEmpty()
            : buildFavList(favoritePokemons),
      );
    });
  }
}

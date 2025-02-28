import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mypokedex/app/core/utils/common_functions.dart';
import 'package:mypokedex/app/core/values/app_colors.dart';
import 'package:mypokedex/app/core/values/app_text_styles.dart';
import 'package:mypokedex/app/core/widgets/poke_loading.dart';

import '../../../core/models/pokemon_model.dart';
import '../../../core/widgets/poke_type_chip.dart';
import '../controllers/poke_details_controller.dart';

class PokeDetailsView extends GetView<PokeDetailsController> {
  const PokeDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    PokemonModel pokemon = controller.pokemonObs.value;

    Color pokemonColor = CommonFunctions.getPokemonColor(
      pokemon.details!.species!.color!,
    );
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: Get.back,
              ),
              actions: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: IconButton(
                    key: ValueKey<bool>(controller.isFavorite(pokemon)),
                    icon: controller.isFavorite(pokemon)
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                blurRadius: 3,
                              ),
                            ],
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                    onPressed: () {
                      controller.toggleFavorite(pokemon);
                    },
                  ),
                ),
              ],
              stretch: true,
              backgroundColor: pokemonColor,
              surfaceTintColor: pokemonColor,
              title: Text(
                CommonFunctions.capitalize(controller.pokemonObs.value.name!),
                style: AppTextStyles.titleMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              expandedHeight: Get.height * 0.45,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                background: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: pokemonColor,
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      right: -12,
                      child: Image.asset(
                        "assets/pokeball.png",
                        height: Get.height * 0.25,
                        opacity: AlwaysStoppedAnimation(0.3),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: Get.height * 0.05,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        width: Get.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 5,
                                    children: [
                                      Text(
                                        CommonFunctions.capitalize(
                                          pokemon.name!,
                                        ),
                                        style:
                                            AppTextStyles.bodyMedium.copyWith(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        spacing: 5,
                                        children: pokemon.details!.types!
                                            .map(
                                              (type) => PokeTypeChip(
                                                type:
                                                    CommonFunctions.capitalize(
                                                        type.type.name),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "#${pokemon.details!.id.toString().padLeft(3, '0')}",
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: Colors.grey[300],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Hero(
                                tag: pokemon.details!.officialArtUrl!,
                                child: CachedNetworkImage(
                                  imageUrl: pokemon.details!.officialArtUrl!,
                                  placeholder: (context, url) => PokeLoading(
                                    isWithText: false,
                                  ),
                                  height: Get.height * 0.3,
                                  width: Get.height * 0.3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  indicatorColor: AppColors.colorPrimary,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                  labelStyle: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: AppTextStyles.bodySmall,
                  controller: controller.tabController,
                  tabs: controller.tabs.map((tab) => Tab(text: tab)).toList(),
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: controller.tabController,
                children: controller.tabViews,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

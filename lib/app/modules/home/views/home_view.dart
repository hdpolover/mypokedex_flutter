import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mypokedex/app/core/models/pokemon_model.dart';
import 'package:mypokedex/app/core/values/app_strings.dart';
import 'package:mypokedex/app/core/values/app_text_styles.dart';
import 'package:mypokedex/app/core/widgets/custom_poke_card_shimmer.dart';
import 'package:mypokedex/app/core/widgets/poke_card.dart';
import 'package:mypokedex/app/core/widgets/poke_loading.dart';
import 'package:mypokedex/app/core/widgets/pokeball_bg.dart';
import 'package:mypokedex/app/modules/home/views/widgets/filter_widget.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import 'widgets/home_drawer.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const HomeDrawer(),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Show modal bottom sheet and await result
          final selectedType = await showModalBottomSheet<String>(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => FilterWidget(),
          );

          // Apply filter
          if (selectedType != null) {
            controller.filterByType(selectedType);
          } else {
            controller.clearFilter();
          }
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.filter_alt),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          // Forward scroll position to main controller for pagination
          if (notification is ScrollUpdateNotification) {
            if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - 500) {
              if (!controller.isLoading.value &&
                  !controller.isEndOfList.value) {
                controller.loadMoreData();
              }
            }
          }
          return false;
        },
        child: RefreshIndicator(
          onRefresh: () async {
            controller.refreshData();
          },
          child: Obx(() => buildBody(context)),
        ),
      ),
    );
  }

  buildEmptyFilterPokemon() {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.filter_alt,
              size: 50,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            Text(
              'No Pokemon found with this filter',
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  buildShimmer() {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.4,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return CustomPokeCardShimmer();
        },
      ),
    );
  }

  buildBody(BuildContext context) {
    List<PokemonModel> displayedPokemons = controller.displayedPokemonList;

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          expandedHeight: Get.height * 0.25,
          pinned: true,
          actions: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            titlePadding: const EdgeInsets.only(left: 20, bottom: 10),
            title: Text(AppStrings.appName),
            background: Stack(
              children: [
                Positioned(
                  top: -Get.height * 0.1,
                  right: -Get.width * 0.4,
                  child: PokeballBg(
                    height: Get.height * 0.4,
                    width: Get.width,
                    isFront: true,
                  ),
                ),
              ],
            ),
          ),
        ),
        displayedPokemons.isEmpty && controller.isLoading.value == false
            ? buildEmptyFilterPokemon()
            : SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                sliver: SliverAnimatedGrid(
                  key: UniqueKey(),
                  initialItemCount: displayedPokemons.length,
                  itemBuilder: (context, index, animation) {
                    if (index >= displayedPokemons.length) {
                      return const SizedBox();
                    }

                    final pokemon = displayedPokemons[index];

                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: animation.drive(
                          Tween<double>(begin: 0.5, end: 1.0)
                              .chain(CurveTween(curve: Curves.elasticOut)),
                        ),
                        child: PokeCard(
                          pokemon: pokemon,
                          onTap: () {
                            Get.toNamed(Routes.POKE_DETAILS,
                                arguments: pokemon);
                          },
                        ),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: context.isPortrait ? 2 : 4,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
              ),
        SliverToBoxAdapter(
          child: Visibility(
            visible: displayedPokemons.isEmpty && controller.isLoading.value,
            child: buildShimmer(),
          ),
        ),
        SliverToBoxAdapter(
          child: Visibility(
            visible: controller.isLoading.value,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: PokeLoading(
                isWithText: false,
                isSmall: true,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Visibility(
            visible: controller.isEndOfList.value,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'No more Pokemon data',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

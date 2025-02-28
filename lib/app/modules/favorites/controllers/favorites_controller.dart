import 'package:get/get.dart';
import 'package:mypokedex/app/core/models/pokemon_model.dart';
import 'package:mypokedex/app/data/local/preference/preference_manager_impl.dart';

import '../../home/controllers/home_controller.dart';

class FavoritesController extends GetxController {
  final PreferenceManagerImpl _preferenceManager =
      Get.find<PreferenceManagerImpl>();
  final HomeController homeController = Get.find<HomeController>();

  // Store favorite Pokemon as a list of strings (names)
  final RxList<String> favoritePokemonNames = <String>[].obs;

  // Store actual Pokemon objects separately
  final RxList<PokemonModel> favoritePokemons = <PokemonModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavoritePokemons();
  }

  Future<void> loadFavoritePokemons() async {
    // Get favorite names from preferences
    List<String> localFavs = await getFavoritePokemonsFromLocal();

    // Clear existing lists
    favoritePokemonNames.clear();
    favoritePokemons.clear();

    // Add all names to the names list
    favoritePokemonNames.addAll(localFavs);

    // Load Pokemon objects
    for (String name in localFavs) {
      try {
        PokemonModel? pokemon;

        // Try to find in home controller first
        if (homeController.pokemonList.any((p) => p.name == name)) {
          pokemon =
              homeController.pokemonList.firstWhere((p) => p.name == name);

          favoritePokemons.add(pokemon);
        } else {
          // If not found, fetch from API
          await homeController.getSinglePokemonData(name).then(
            (value) {
              pokemon = value;

              favoritePokemons.add(pokemon!);
            },
          );
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  bool isFavorite(PokemonModel pokemon) {
    return favoritePokemonNames.contains(pokemon.name);
  }

  void toggleFavorite(PokemonModel pokemon) {
    if (pokemon.name == null) return;

    if (isFavorite(pokemon)) {
      removeFavorite(pokemon);
    } else {
      addFavorite(pokemon);
    }
  }

  void addFavorite(PokemonModel pokemon) {
    if (pokemon.name == null || pokemon.name!.isEmpty) return;

    if (!favoritePokemonNames.contains(pokemon.name)) {
      // Add to names list
      favoritePokemonNames.add(pokemon.name!);

      // Add to Pokemon objects list
      favoritePokemons.add(pokemon);

      // Save to preferences
      saveFavoritesToPreferences();
    }
  }

  void removeFavorite(PokemonModel pokemon) {
    if (pokemon.name == null) return;

    // Remove from names list
    favoritePokemonNames.remove(pokemon.name);

    // Remove from Pokemon objects list
    favoritePokemons.removeWhere((p) => p.name == pokemon.name);

    // Save to preferences
    saveFavoritesToPreferences();
  }

  void saveFavoritesToPreferences() {
    // Create a new list to avoid modifying an unmodifiable list
    List<String> favNames = List<String>.from(favoritePokemonNames);

    // Save to preferences
    _preferenceManager.setStringList("favorites", favNames);
  }

  void clearFavorites() {
    favoritePokemons.clear();
  }

  getFavoritePokemonsFromLocal() async {
    // Get from local storage
    List<String> favorites =
        await _preferenceManager.getStringList("favorites");

    return favorites;
  }
}

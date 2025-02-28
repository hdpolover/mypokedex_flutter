import 'package:get/get.dart';
import 'package:mypokedex/app/data/repository/pokemon_repository.dart';
import '../../../core/models/pokemon_model.dart';

class HomeController extends GetxController {
  final PokemonRepository _repository =
      Get.find(tag: (PokemonRepository).toString());

  final RxList<PokemonModel> pokemonList = <PokemonModel>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool isFirstInitialCall = false.obs;
  final RxBool isEndOfList = false.obs;
  final RxString errorMessage = ''.obs;

  final int itemsPerPage = 10;

  int _currentOffset = 0;

  final RxString currentFilter = ''.obs;
  final RxList<PokemonModel> filteredPokemonList = <PokemonModel>[].obs;

  void filterByType(String type) {
    currentFilter.value = type;
    filteredPokemonList.value = pokemonList
        .where((pokemon) =>
            pokemon.details?.types
                ?.any((t) => t.type.name.toLowerCase() == type.toLowerCase()) ??
            false)
        .toList();
  }

  void clearFilter() {
    currentFilter.value = '';
    filteredPokemonList.clear();
  }

// Use this getter in your view
  List<PokemonModel> get displayedPokemonList =>
      currentFilter.isEmpty ? pokemonList : filteredPokemonList;

  Future<void> loadInitialData() async {
    isLoading.value = true;
    errorMessage.value = '';
    _currentOffset = 0;

    try {
      final fetchedPokemons =
          await _repository.getAll(_currentOffset, itemsPerPage);

      if (fetchedPokemons.isEmpty) {
        isEndOfList.value = true;
      } else {
        pokemonList.assignAll(fetchedPokemons);

        _currentOffset += fetchedPokemons.length;
      }
    } catch (e) {
      errorMessage.value = 'Failed to load Pokemon data: $e';
    } finally {
      isLoading.value = false;
      isFirstInitialCall.value = true;
    }
  }

  Future<void> loadMoreData() async {
    if (isLoading.value || isEndOfList.value) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final fetchedPokemons =
          await _repository.getAll(_currentOffset, itemsPerPage);

      if (fetchedPokemons.isEmpty) {
        isEndOfList.value = true;
      } else {
        pokemonList.addAll(fetchedPokemons);
        _currentOffset += fetchedPokemons.length;
      }
    } catch (e) {
      errorMessage.value = 'Failed to load more Pokemon: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<PokemonModel?> getSinglePokemonData(String name) async {
    try {
      final pokemon = await _repository.getPokemonByName(name);

      return pokemon;
    } catch (e) {
      errorMessage.value = 'Failed to get Pokemon data: $e';
      return null;
    }
  }

  void refreshData() {
    isEndOfList.value = false;
    errorMessage.value = '';
    _currentOffset = 0;
    pokemonList.clear();
    clearFilter();
    loadInitialData();
  }

  String getPokemonImageUrl(String name) {
    String url = "";
    for (var i = 0; i < pokemonList.length; i++) {
      if (pokemonList[i].name == name) {
        url = pokemonList[i].details!.officialArtUrl!;
      }
    }

    return url;
  }
}

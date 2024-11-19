import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/provider/favorites_provider.dart';
import 'package:meals/provider/meal_provider.dart';


enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}


class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier() :super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  });
  void setFilters(Map<Filter,bool>chooseFilters){
    state=chooseFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state, filter: isActive,
    };
  }
}

final filtersProvider = StateNotifierProvider<FiltersNotifier,Map<Filter,bool>>((ref) => FiltersNotifier());

final filteredMealsProvider=Provider((ref){
  final meals=ref.watch(mealsProvider);
  final _selectedFilters=ref.watch(filtersProvider);
  return meals.where((meal){
    if(_selectedFilters[Filter.glutenFree]!&& !meal.isGlutenFree){
      return false;
    }
    if(_selectedFilters[Filter.lactoseFree]!&& !meal.isLactoseFree){
      return false;
    }
    if(_selectedFilters[Filter.vegetarian]!&& !meal.isVegetarian){
      return false;
    }
    if(_selectedFilters[Filter.vegan]!&& !meal.isVegan){
      return false;
    }
    return true;
  });

  });
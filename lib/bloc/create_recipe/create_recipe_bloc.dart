import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../base_bloc.dart';
import '../error_handling/index.dart';
import 'index.dart';

class CreateRecipeBloc extends BaseBloc<CreateRecipeEvent, CreateRecipeState> {
  // region Properties

  // endregion

  // region Lifecycle

  CreateRecipeBloc({@required ErrorHandlingBloc errorHandlingBloc})
      : super(
            initialState: CreateRecipeState.initial(),
            errorHandlingBloc: errorHandlingBloc);

  @override
  Stream<CreateRecipeState> mapEventToState(CreateRecipeEvent event) async* {
    if (event is BlocInit) {
    } else if (event is TitleChanged) {
      yield state.copy(title: event.text);
      yield state.copy(canCreateRecipe: _canCreateRecipe());
    } else if (event is PlusComplexity) {
      final complexity = min(state.complexity + 0.5, 5.0);
      yield state.copy(complexity: complexity);
    } else if (event is MinusComplexity) {
      final complexity = max(state.complexity - 0.5, 0.5);
      yield state.copy(complexity: complexity);
    } else if (event is DescriptionChanged) {
      yield state.copy(description: event.text);
      yield state.copy(canCreateRecipe: _canCreateRecipe());
    } else if (event is IngredientsChanged) {
      yield state.copy(ingredients: event.ingredients);
      yield state.copy(canCreateRecipe: _canCreateRecipe());
    } else if (event is CookingStepsChanged) {
      yield state.copy(cookingSteps: event.text);
      yield state.copy(canCreateRecipe: _canCreateRecipe());
    } else if (event is PhotoPicked) {
      final updatedPhotos = state.photos + [event.photo];
      yield state.copy(photos: updatedPhotos);
      yield state.copy(canCreateRecipe: _canCreateRecipe());
    } else if (event is PhotoDeleted) {
      final updatedPhotos = state.photos;
      updatedPhotos.removeWhere((e) => e == event.photo);
      yield state.copy(photos: updatedPhotos);
      yield state.copy(canCreateRecipe: _canCreateRecipe());
    } else if (event is CreateRecipe) {}
  }

  // endregion

  // region Private methods

  bool _canCreateRecipe() =>
      state.title.length > 3 &&
      state.description.isNotEmpty &&
      state.ingredients.isNotEmpty &&
      state.cookingSteps.length > 3 &&
      state.photos.isNotEmpty;

  // endregion
}

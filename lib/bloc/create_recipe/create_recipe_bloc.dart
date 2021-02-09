import 'dart:async';

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
    // TODO: handle bloc events
    if (event is BlocInit) {
    } else if (event is TitleChanged) {
    } else if (event is CreateRecipe) {}
  }

  // endregion
}

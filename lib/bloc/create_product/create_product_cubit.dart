import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hulk_store/auth_models/field_validator.dart';
import 'package:hulk_store/auth_models/url_validator.dart';

import 'create_products_state.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  CreateProductCubit() : super(const CreateProductState());

  void urlChanged(String value) {
    final url = UrlValidation.dirty(value);
    emit(state.copyWith(
      image: url,
      status: Formz.validate([
        url,
        state.price,
        state.quantity,
        state.name,
        state.description,
      ]),
    ));
  }

  void nameChanged(String value) {
    final name = FieldValidation.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.price,
        state.quantity,
        state.image,
        state.description,
      ]),
    ));
  }

  void descriptionChanged(String value) {
    final description = FieldValidation.dirty(value);
    emit(state.copyWith(
      description: description,
      status: Formz.validate([
        description,
        state.price,
        state.quantity,
        state.image,
        state.name,
      ]),
    ));
  }

  void priceChanged(String value) {
    final price = FieldValidation.dirty(value.trim().replaceAll(".", "").replaceAll(",", "").replaceAll("\$", ""));
    emit(state.copyWith(
      price: price,
      status: Formz.validate([
        price,
        state.description,
        state.quantity,
        state.image,
        state.name,
      ]),
    ));
  }

  void quantityChanged(String value) {
    final quantity = FieldValidation.dirty(value);
    emit(state.copyWith(
      quantity: quantity,
      status: Formz.validate([
        quantity,
        state.price,
        state.description,
        state.image,
        state.name,
      ]),
    ));
  }

  Future<void> validateCreateProduct() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await Future.delayed(Duration(milliseconds: 200));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, error: e.toString()));
    }
  }

}
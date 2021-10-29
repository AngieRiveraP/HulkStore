import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hulk_store/auth_models/url_validator.dart';

import '../../auth_models/field_validator.dart';

class CreateProductState extends Equatable {
  const CreateProductState({
    this.name = const FieldValidation.pure(),
    this.description = const FieldValidation.pure(),
    this.price = const FieldValidation.pure(),
    this.quantity = const FieldValidation.pure(),
    this.image = const UrlValidation.pure(),
    this.status = FormzStatus.pure,
    this.exceptionError = "",
  });

  final FieldValidation name;
  final FieldValidation description;
  final FieldValidation price;
  final FieldValidation quantity;
  final UrlValidation image;
  final FormzStatus status;
  final String exceptionError;

  CreateProductState copyWith({FieldValidation? name, FieldValidation? description, FieldValidation? price,
    FieldValidation? quantity, UrlValidation? image, FormzStatus? status,
    String? error}) {

    return CreateProductState(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      status: status ?? this.status,
      exceptionError: error ?? this.exceptionError,
    );
  }

  @override
  List<Object> get props => [name, description, price, quantity, image, status, exceptionError];
}
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hulk_store/db/database.dart';
import 'package:hulk_store/models/products_model.dart';
import 'package:hulk_store/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'products_events.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {

  final Repository repository;

  ProductsBloc({required this.repository})
      : assert(repository != null),
        super(ProductsState());

  @override
  void onTransition(Transition<ProductsEvent, ProductsState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event) async* {
    try {
      if (event is GetProductsEvent) {
        yield ProductsState.loading(state.items);
        List<ProductModel> products = await repository.getProducts();
        if (products.length == 0) {
          yield ProductsState.failure(state.items);
        } else {
          yield ProductsState.success(products);
        }
      } else if (event is UpdateProductEvent) {
        await repository.updateProduct(event.item);
        state.items[state.items.indexWhere(
                (element) => element.idProduct == event.item.idProduct)] =
            event.item;
        yield ProductsState.success(state.items);
      } else if (event is NewProductEvent) {
        yield ProductsState.loading(state.items);
        await repository.createProduct(event.item);
        state.items.add(event.item);
        yield ProductsState.success(state.items);
      } else if (event is BuyProductEvent) {
        yield ProductsState.loading(state.items);
        event.items.forEach((element) async {
          int position = state.items.indexWhere((product) => product.idProduct == element.idProduct);
          state.items[position].quantity =
              (int.parse(state.items[position].quantity) -
                      int.parse(element.quantityCart))
                  .toString();
          state.items[position].quantityCart = "0";
          await DataBaseProvider.instance.updateProduct(state.items[position]);
        });
        yield ProductsState.bought(state.items);
      }
    } catch (_) {
      yield ProductsState.failure(state.items);
    }
  }
}

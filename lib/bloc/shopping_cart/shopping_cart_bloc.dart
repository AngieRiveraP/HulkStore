import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hulk_store/bloc/products/products_bloc.dart';
import 'package:hulk_store/models/products_model.dart';
import 'package:equatable/equatable.dart';

part 'shopping_cart_events.dart';
part 'shopping_cart_state.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {

  ShoppingCartBloc() : super(ShoppingCartState());

   @override
  void onTransition(Transition<ShoppingCartEvent, ShoppingCartState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<ShoppingCartState> mapEventToState(ShoppingCartEvent event) async* {
     try {
        if (event is GetShoppingCartEvent) {
          yield ShoppingCartState.loading(state.items);
          if (state.items.length == 0) {
            yield ShoppingCartState.failure(state.items);
          } else {
            yield ShoppingCartState.success(state.items);
          }
        } else if (event is UpdateProductCartEvent) {
          yield ShoppingCartState.loading(state.items);
          state.items[state.items.indexWhere((element) => element.idProduct == event.item.idProduct)] = event.item;
            yield ShoppingCartState.success(state.items);
        } else if (event is NewProductCartEvent) {
          yield ShoppingCartState.loading(state.items);
          List<ProductModel> items = <ProductModel>[];
          if(state.items.isEmpty){
            items.add(event.item);
          }else{
            int position = state.items.indexWhere((element) => element.idProduct == event.item.idProduct);
            if(position == -1){
              items.addAll(state.items);
              items.add(event.item);
            } else {
              items.addAll(state.items);
              items[position].quantityCart = (int.parse(items[position].quantityCart) + 1).toString();
            }
          }
          yield ShoppingCartState.success(items);
        } else if(event is DeleteProductCartEvent) {
          yield ShoppingCartState.loading(state.items);
          int position = state.items.indexWhere((element) => element.idProduct == event.item.idProduct);
          state.items[position].quantityCart = "0";
          state.items.removeAt(state.items.indexWhere((element) => element.idProduct == event.item.idProduct));
          if (state.items.length == 0) {
            yield ShoppingCartState.failure(state.items);
          } else {
            yield ShoppingCartState.success(state.items);
          }
        } else if(event is BuyProductCartEvent) {
          state.items.clear();
        }
      } catch (_) {
       yield ShoppingCartState.failure(<ProductModel>[]);
      }
    }
  }



import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hulk_store/bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:hulk_store/models/products_model.dart';
import 'package:hulk_store/repository/repository.dart';
import 'package:mocktail/mocktail.dart';

class ShoppingCartBlocTest extends Mock implements Repository{}

void main (){

  final mockItems = [
    ProductModel(   image: "",
        quantity: "2",
        price: "10000",
        name: "prueba",
        description: "prueba",
        idProduct: "1",
        quantityCart: "0")];

  final mockProduct = ProductModel(   image: "",
        quantity: "2",
        price: "10000",
        name: "prueba",
        description: "prueba",
        idProduct: "1",
        quantityCart: "0");

  group('ShoppingCartState.success when add new product', (){
    blocTest<ShoppingCartBloc,ShoppingCartState>(
        'emit ShoppingCartState.success when NewProductEvent is added',
        build: () => ShoppingCartBloc(),
        act: (bloc) => bloc.add(NewProductCartEvent(mockProduct)),
        expect: () => <ShoppingCartState>[ShoppingCartState.loading([]),
          ShoppingCartState.success(mockItems)]
    );
  });

}
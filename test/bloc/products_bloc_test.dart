
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hulk_store/bloc/products/products_bloc.dart';
import 'package:hulk_store/models/products_model.dart';
import 'package:hulk_store/repository/repository.dart';
import 'package:mocktail/mocktail.dart';

class ProductsBlocTest extends Mock implements Repository{}

void main (){
  
  late Repository repository;
  final mockItems = [ ProductModel(   image: "",
        quantity: "2",
        price: "10000",
        name: "prueba",
        description: "prueba",
        idProduct: "1",
        quantityCart: "0")];
  
  setUp(() {
    repository = ProductsBlocTest();
  });

  group('ProductsState.success', (){
    blocTest<ProductsBloc,ProductsState>(
        'emit ProductsState.success when GetProductsEvent is added',
        setUp: () {
          when(repository.getProducts).thenAnswer((_) async => mockItems);
        },
        build: () => ProductsBloc(repository: repository),
        act: (bloc) => bloc.add(GetProductsEvent()),
        expect: () =>  <ProductsState>[ProductsState.loading([]),
          ProductsState.success(mockItems)]
    );
  });

  group('ProductsState.failure', (){
    blocTest<ProductsBloc,ProductsState>(
        'emit ProductsState.failure when GetProductsEvent is added',
        setUp: () {
          when(repository.getProducts).thenAnswer((_) async => []);
        },
        build: () => ProductsBloc(repository: repository),
        act: (bloc) => bloc.add(GetProductsEvent()),
        expect: () => const <ProductsState>[ProductsState.loading([]), ProductsState.failure([])]
    );
  });

}
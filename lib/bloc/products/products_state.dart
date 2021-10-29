part of 'products_bloc.dart';


enum ListStatus { loading, success, failure, update, bought }

class ProductsState extends Equatable {

  ProductsState({
    this.status = ListStatus.loading,
    this.items = const <ProductModel>[],
  });

  /* Status that indicates that the information is loading */
  const ProductsState.loading(this.items) : status =  ListStatus.loading;

  /* Status that indicates that the products was obtained correctly */
  const ProductsState.success(List<ProductModel> items)
      : status =  ListStatus.success, items = items;

  /* Status indicating that the products could not be obtained */
  const ProductsState.failure(this.items) : status = ListStatus.failure;

  /* Status indicates that the purchase was made*/
  const ProductsState.bought(this.items) : status = ListStatus.bought;

  final ListStatus status;
  final List<ProductModel> items;

  @override
  List<Object> get props => [status, items];
}

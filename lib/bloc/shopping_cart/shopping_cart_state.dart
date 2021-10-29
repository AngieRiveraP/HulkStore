part of 'shopping_cart_bloc.dart';


enum ListStatusCart { loading, success, failure, update, bought }

class ShoppingCartState extends Equatable {

  ShoppingCartState({
    this.status = ListStatusCart.loading,
    this.items = const <ProductModel>[]
  });

  /* Status that indicates that the information is loading */
  const ShoppingCartState.loading(this.items) : status =  ListStatusCart.loading;

  /* Status that indicates that the shopping cart was obtained correctly */
  const ShoppingCartState.success(List<ProductModel> items)
      : status =  ListStatusCart.success, items = items;

  /* Status indicating that the ShoppingCart could not be obtained */
  const ShoppingCartState.failure(this.items) : status = ListStatusCart.failure;

  /* Status indicates that the purchase was made*/
  const ShoppingCartState.bought(this.items) : status = ListStatusCart.bought;


  final ListStatusCart status;
  final List<ProductModel> items;

  @override
  List<Object> get props => [status, items];
}

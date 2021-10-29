
part of 'shopping_cart_bloc.dart';

@immutable
abstract class ShoppingCartEvent{}

/* Event to get the saved ShoppingCart */
class GetShoppingCartEvent extends ShoppingCartEvent{
  GetShoppingCartEvent();
}

/* Event to update a product and receives as parameter an object of type ProductModel */
class UpdateProductCartEvent extends ShoppingCartEvent{
  final ProductModel item;
  UpdateProductCartEvent(this.item);
}

/* Event to add new product and receives as parameter an object of type ProductModel */
class NewProductCartEvent extends ShoppingCartEvent{
  final ProductModel item;
  NewProductCartEvent(this.item);
}

/* Event to delete product and receives as parameter an object of type ProductModel */
class DeleteProductCartEvent extends ShoppingCartEvent{
  final ProductModel item;
  DeleteProductCartEvent(this.item);
}

/* Event to buy products*/
class BuyProductCartEvent extends ShoppingCartEvent{
  BuyProductCartEvent();
}
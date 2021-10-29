
part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent{}

/* Event to get the saved products */
class GetProductsEvent extends ProductsEvent{
  GetProductsEvent();
}

/* Event to update a product and receives as parameter an object of type ProductModel */
class UpdateProductEvent extends ProductsEvent{
  final ProductModel item;
  UpdateProductEvent(this.item);
}

/* Event to create new product and receives as parameter an object of type ProductModel */
class NewProductEvent extends ProductsEvent{
  final ProductModel item;
  NewProductEvent(this.item);
}

/* Event to buy products*/
class BuyProductEvent extends ProductsEvent{
  final List<ProductModel> items;
  BuyProductEvent(this.items);
}

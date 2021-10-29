import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
   ProductModel({
    this.name = "",
    this.description = "",
    this.price = "",
    this.quantity = "0",
    this.image = "",
    this.idProduct = "",
     this.quantityCart = "0",
  });

  final String name;
  final String description;
  final String price;
  late String quantity;
  final String image;
  final String idProduct;
  late  String quantityCart;

  ProductModel copyWith({String? name, String? description, String? price,
    String? quantity, String? image, String? idProduct, String? quantityCart}) {

    return ProductModel(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      idProduct: idProduct ?? this.idProduct,
      quantityCart: quantityCart ?? this.quantityCart,
    );
  }

  factory ProductModel.fromMap(Map<String, dynamic> json) => new ProductModel(
    name: json["name"],
    description: json["description"],
    price: json["price"],
    quantity: json["quantity"],
    image: json["image"],
    idProduct: json["idProduct"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "description": description,
    "price": price,
    "quantity": quantity,
    "image": image,
    "idProduct": idProduct,
  };

  @override
  List<Object> get props => [name, description, price, quantity, image , idProduct];
}
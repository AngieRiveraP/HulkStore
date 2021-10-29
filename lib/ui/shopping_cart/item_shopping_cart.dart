
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulk_store/bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:hulk_store/models/products_model.dart';
import 'package:hulk_store/utils/colors.dart';
import 'package:hulk_store/utils/strings.dart';
import 'package:hulk_store/utils/utils.dart';

/*
* View corresponding to a product item of the shopping cart
*/
class ItemShoppingCart extends StatelessWidget {

  final ProductModel dataProduct;
  final BuildContext contextContainer;
  final int index;

  ItemShoppingCart(this.dataProduct, this.contextContainer, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: double.infinity,
            height: 155,
            margin: EdgeInsets.only(left: 30, right: 15),
            padding: EdgeInsets.only(left: 70, right: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
             ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  dataProduct.name,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: CustomColors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Id: ${dataProduct.idProduct}",
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: CustomColors.black.withOpacity(0.7),
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "${Strings.stock} ${dataProduct.quantity} ${Strings.units}",
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: dataProduct.quantity != "0" ? CustomColors.black.withOpacity(0.7) : CustomColors.red,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "${utils.getFormatCurrencySymbol(dataProduct.price, "\$")}",
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: CustomColors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        if(dataProduct.quantityCart == "1"){
                          BlocProvider.of<ShoppingCartBloc>(context)
                              .add(DeleteProductCartEvent(dataProduct));
                        } else {
                          var product = dataProduct;
                          product.quantityCart = (int.parse(product.quantityCart) - 1).toString();
                          BlocProvider.of<ShoppingCartBloc>(context)
                              .add(UpdateProductCartEvent(product));
                        }
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: CustomColors.green,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Text(
                            "-",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: CustomColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      dataProduct.quantityCart,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: CustomColors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: CustomColors.green,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: InkWell(
                        onTap: (){
                          if(int.parse(dataProduct.quantityCart) < int.parse(dataProduct.quantity)){
                            var product = dataProduct;
                            product.quantityCart = (int.parse(product.quantityCart) + 1).toString();
                            BlocProvider.of<ShoppingCartBloc>(context).add(UpdateProductCartEvent(product));
                          }
                        },
                        child: Icon(Icons.add,
                            color: CustomColors.white,
                            size: 22
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(width: 2, color: CustomColors.white),
              boxShadow: [
                BoxShadow(
                  color: CustomColors.bgGray.withOpacity(0.8),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(
                      1, 3), // changes position of shadow
                ),
              ],
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(dataProduct.image)
              )
            )
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: CustomColors.red,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: InkWell(
                onTap: (){
                  BlocProvider.of<ShoppingCartBloc>(context).add(DeleteProductCartEvent(dataProduct));
                },
                child: Icon(Icons.delete_forever_outlined,
                    color: CustomColors.white,
                    size: 22
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulk_store/bloc/products/products_bloc.dart';
import 'package:hulk_store/bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:hulk_store/models/products_model.dart';
import 'package:hulk_store/utils/colors.dart';
import 'package:hulk_store/utils/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'item_shopping_cart.dart';

/*
* Page corresponding to shopping cart
*/

class ShoppingCartPage extends StatefulWidget {
  ShoppingCart createState() => ShoppingCart();
}

class ShoppingCart extends State<ShoppingCartPage>  {
  
  final GlobalKey<ScaffoldState> keyShoppingCart = new GlobalKey<ScaffoldState>();
  var productsShoppingCart = <ProductModel>[];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShoppingCartBloc>(context).add(GetShoppingCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyShoppingCart,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          Strings.shoppingPart,
          style: TextStyle(color: Colors.white, fontSize: 17.0),
        ),
        backgroundColor: CustomColors.green,
        leading: IconButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<ShoppingCartBloc,ShoppingCartState>(
        builder: ( _ , state) {
          switch (state.status) {
            case ListStatusCart.failure:
              return Center(child: emptyProducts());
            case ListStatusCart.success:
              productsShoppingCart = state.items;
              return _bodyProducts(context, state.items);
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _bodyProducts(BuildContext context, List<ProductModel> products){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: CustomColors.bgGray.withOpacity(0.3),
      child: Stack(
        alignment: Alignment.topCenter,
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(top: 30, bottom: 70),
              itemCount: products.isEmpty
                  ? 0
                  : products.length,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ItemShoppingCart(products[index], context, index);
              },
            ),
            Positioned(
              bottom: 20,
              child: CupertinoButton(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(Strings.buy,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CustomColors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    )),
                disabledColor: CustomColors.green.withOpacity(0.3),
                color: CustomColors.green,
                onPressed: (){
                  BlocProvider.of<ProductsBloc>(context).add(BuyProductEvent(productsShoppingCart));
                  Navigator.of(context).pop();
                }
              ),
            )
          ],
        )
    );
  }

  Widget emptyProducts(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(Strings.emptyCart,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: CustomColors.green,
            fontSize: 16.0,
          )),
    );
  }
}


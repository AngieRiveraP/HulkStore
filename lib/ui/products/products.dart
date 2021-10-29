import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hulk_store/bloc/products/products_bloc.dart';
import 'package:hulk_store/bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:hulk_store/interface/interface_products.dart';
import 'package:hulk_store/models/products_model.dart';
import 'package:hulk_store/ui/create_products/create_product.dart';
import 'package:hulk_store/ui/products/item_product.dart';
import 'package:hulk_store/ui/shopping_cart/shopping_cart.dart';
import 'package:hulk_store/utils/colors.dart';
import 'package:hulk_store/utils/snack_bar.dart';
import 'package:hulk_store/utils/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
* Page corresponding to the product list of the store
*/

class ProductsPage extends StatefulWidget {
  Products createState() => Products();
}

class Products extends State<ProductsPage> implements InterfaceProduct {
  
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsBloc>(context)
        .add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          Strings.appName,
          style: TextStyle(color: Colors.white, fontSize: 17.0),
        ),
        backgroundColor: CustomColors.green,
        leading: Visibility(
          visible: true,
          child: IconButton(
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShoppingCartPage()));
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateProductPage(isEdit: false, product: ProductModel())));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<ProductsBloc,ProductsState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: ( _ , state) {
          switch (state.status) {
            case ListStatus.failure:
              return Center(child: emptyProducts());
            case ListStatus.success:
              return _bodyProducts(context, state.items);
            case ListStatus.bought:
              BlocProvider.of<ShoppingCartBloc>(context).add(BuyProductCartEvent());
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Text(
                Strings.yourProducts,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CustomColors.green,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(top: 20),
              itemCount: products.isEmpty
                  ? 0
                  : products.length,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                    },
                    child: ItemProduct(products[index], context, index, this)
                );
              },
            )
          ],
        )
      ),
    );
  }

  Widget emptyProducts(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(Strings.emptyProducts,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: CustomColors.green,
            fontSize: 16.0,
          )),
    );
  }

  @override
  void addProduct(ProductModel product) {
    if(product.quantity == "0"){
      showSnackBar(
          scaffoldKey,
          CustomColors.black,
          Strings.addProductError,
          Duration(milliseconds: 2000));
    } else if(product.quantity == product.quantityCart){
      showSnackBar(
          scaffoldKey,
          CustomColors.black,
          Strings.addProductStock,
          Duration(milliseconds: 2000));
    }else{
      var newProduct = product;
      if(newProduct.quantityCart == "0"){
        newProduct.quantityCart = "1";
      }
      BlocProvider.of<ShoppingCartBloc>(context).add(NewProductCartEvent(newProduct));
      showSnackBar(
          scaffoldKey,
          CustomColors.black,
          Strings.addProductOk,
          Duration(milliseconds: 2000));
    }
  }

  @override
  void detailProduct(ProductModel product) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateProductPage(isEdit: true, product: product)));
  }

}


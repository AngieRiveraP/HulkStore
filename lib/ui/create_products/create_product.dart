import 'dart:async';
import 'dart:math';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulk_store/bloc/create_product/create_product_cubit.dart';
import 'package:hulk_store/bloc/create_product/create_products_state.dart';
import 'package:hulk_store/bloc/products/products_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hulk_store/db/database.dart';
import 'package:hulk_store/models/products_model.dart';
import 'package:hulk_store/utils/colors.dart';
import 'package:hulk_store/utils/custom_text_field.dart';
import 'package:hulk_store/utils/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
* Page corresponding to create a new product
*/

class CreateProductPage extends StatefulWidget {

  final isEdit;
  final product;

  CreateProductPage({required this.isEdit, required this.product}) : super();

  @override
  CreateProduct createState() => CreateProduct(isEdit: isEdit, product: product);
}

class CreateProduct extends State<CreateProductPage> {

  final GlobalKey<ScaffoldState> keyCreateProduct = new GlobalKey<ScaffoldState>();
  var _controllerName = TextEditingController();
  var _controllerDescription = TextEditingController();
  var _controllerImage = TextEditingController();
  var _controllerQuantity = TextEditingController();
  var _controllerPrice = new MoneyMaskedTextController(decimalSeparator: "", precision: 0,thousandSeparator: '.',leftSymbol: "\$");
  var isEdit = false;
  var product = ProductModel();

  CreateProduct({required this.isEdit, required this.product}) : super();

  @override
  void initState() {
    super.initState();
    if(isEdit){
      _controllerName.text = product.name;
      context.read<CreateProductCubit>().nameChanged(product.name);
      _controllerDescription.text = product.description;
      context.read<CreateProductCubit>().descriptionChanged(product.description);
      _controllerImage.text = product.image;
    context.read<CreateProductCubit>().urlChanged(product.image);
      _controllerPrice.text = product.price;
      context.read<CreateProductCubit>().priceChanged(product.price);
      _controllerQuantity.text = product.quantity;
    context.read<CreateProductCubit>().quantityChanged(product.quantity);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controllerName.dispose();
    _controllerDescription.dispose();
    _controllerPrice.dispose();
    _controllerImage.dispose();
    _controllerQuantity.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyCreateProduct,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          Strings.appName,
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
      body: BlocConsumer<CreateProductCubit, CreateProductState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              print('submission failure');
            } else if (state.status.isSubmissionSuccess) {
              print('success');
            }
          },
          builder: (_, state) => Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: CustomColors.bgGray.withOpacity(0.3),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _NameInputField(_controllerName),
                        _ImageInputField(_controllerImage),
                        Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              Strings.txImage,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: CustomColors.black.withOpacity(0.3),
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        _PriceInputField(_controllerPrice),
                        _QuantityInputField(_controllerQuantity),
                        _DescriptionInputField(_controllerDescription),
                        _CreateProductButton(isEdit, product.idProduct),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}

class _NameInputField extends StatelessWidget {

final TextEditingController controller;

_NameInputField(this.controller);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
     builder: (context, state) {
        return CustomTextField(
          controller: controller,
          hint: Strings.name,
          maxLines: 1,
          key: const Key('name_textField'),
          keyboardType: TextInputType.text,
          onChanged: (name) =>
              context.read<CreateProductCubit>().nameChanged(name),
        );
      },
    );
  }
}

class _ImageInputField extends StatelessWidget {

  final TextEditingController controller;

  _ImageInputField(this.controller);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        return CustomTextField(
          controller: controller,
          padding: EdgeInsets.only(top: 20),
          hint: Strings.image,
          maxLines: 1,
          key: const Key('image_textField'),
          keyboardType: TextInputType.url,
          onChanged: (image) =>
              context.read<CreateProductCubit>().urlChanged(image),
        );
      },
    );
  }
}

class _PriceInputField extends StatelessWidget {

  final TextEditingController controller;

  _PriceInputField(this.controller);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        return CustomTextField(
          controller: controller,
          padding: EdgeInsets.only(top: 20),
          hint: Strings.price,
          maxLines: 1,
          isPriceField: true,
          key: const Key('price_textField'),
          keyboardType: TextInputType.number,
          onChanged: (price) =>
              context.read<CreateProductCubit>().priceChanged(price),
        );
      },
    );
  }
}

class _QuantityInputField extends StatelessWidget {

  final TextEditingController controller;

  _QuantityInputField(this.controller);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        return CustomTextField(
          controller: controller,
          padding: EdgeInsets.only(top: 20),
          hint: Strings.quantity,
          maxLines: 1,
          isPriceField: true,
          key: const Key('quantity_textField'),
          keyboardType: TextInputType.number,
          onChanged: (quantity) =>
              context.read<CreateProductCubit>().quantityChanged(quantity),
        );
      },
    );
  }
}

class _DescriptionInputField extends StatelessWidget {

  final TextEditingController controller;

  _DescriptionInputField(this.controller);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        return CustomTextField(
          controller: controller,
          padding: EdgeInsets.only(top: 20),
          hint: Strings.description,
          maxLines: 5,
          key: const Key('description_textField'),
          keyboardType: TextInputType.text,
          onChanged: (description) => context
              .read<CreateProductCubit>()
              .descriptionChanged(description),
        );
      },
    );
  }
}

class _CreateProductButton extends StatelessWidget {

  final bool isEdit;
  final String idProduct;

  _CreateProductButton(this.isEdit, this.idProduct);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
     builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 30),
          child: CupertinoButton(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(isEdit ? Strings.editProduct : Strings.createProduct,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CustomColors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                )),
            disabledColor: CustomColors.green.withOpacity(0.3),
            color: CustomColors.green,
            onPressed: state.status.isValidated
                ? () async {
                    context.read<CreateProductCubit>().validateCreateProduct();
                    Random random = new Random();
                    int randomNumber = random.nextInt(100);
                    var product = new ProductModel(
                        name: state.name.value,
                        description: state.description.value,
                        idProduct: isEdit ? idProduct : randomNumber.toString(),
                        price: state.price.value,
                        quantity: state.quantity.value,
                        image: state.image.value);
                   createProduct(product, context);
                  }
                : null,
          ),
        );
      },
    );
  }

  Future<void> createProduct(ProductModel product, BuildContext context) async {
    if(isEdit){
      BlocProvider.of<ProductsBloc>(context)
          .add(UpdateProductEvent(product));
    }else{
      BlocProvider.of<ProductsBloc>(context)
          .add(NewProductEvent(product));
    }
    Navigator.of(context).pop();
  }

}


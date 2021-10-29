import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulk_store/bloc/products/products_bloc.dart';
import 'package:hulk_store/repository/repository.dart';
import 'package:hulk_store/ui/products/products.dart';

import 'bloc/create_product/create_product_cubit.dart';
import 'bloc/shopping_cart/shopping_cart_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  HomeMyApp createState() => HomeMyApp();
}

class HomeMyApp extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(providers: [
      BlocProvider(create: ( _ ) => ProductsBloc(repository: Repository())),
      BlocProvider(create: ( _ ) => CreateProductCubit()),
      BlocProvider(create: ( _ ) => ShoppingCartBloc())
    ],
        child: MaterialApp(
            builder: (context, child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            //  home: GetLocationWidget(),
            home: ProductsPage()
        )
    );
  }

}






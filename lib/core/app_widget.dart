import 'package:flutter/material.dart';
import 'package:food_app/core/app_colors.dart';
import 'package:food_app/page_view/pages.dart';
import 'package:food_app/page_view/pages_controller.dart';
import 'package:food_app/screens/cart/cart_controller.dart';
import 'package:food_app/screens/favourites/fave_controller.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PagesController>(create: (_) => PagesController()),
        Provider<CartController>(create: (_) => CartController()),
        Provider<FaveController>(create: (_) => FaveController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Food App",
        theme: ThemeData(
          primaryColor: AppColors.darkRed,
        ),
        home: Pages(),
      ),
    );
  }
}

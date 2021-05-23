import 'package:flutter/material.dart';

import 'package:food_app/core/app_colors.dart';
import 'package:food_app/core/app_text_styles.dart';
import 'package:food_app/models/product.dart';
import 'package:food_app/page_view/pages_controller.dart';
import 'package:food_app/screens/cart/cart_controller.dart';
import 'package:food_app/screens/favourites/fave_controller.dart';
import 'package:food_app/screens/order/order_controller.dart';
import 'package:food_app/screens/order/widgets/around_amount_widget.dart';
import 'package:food_app/screens/order/widgets/button_add_cart.dart';
import 'package:food_app/screens/order/widgets/button_shadow_widget.dart';
import 'package:food_app/screens/order/widgets/size_product_widget.dart';
import 'package:food_app/util/app_icons_icons.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  Product product;

  OrderScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late FaveController controllerFavorites;

  var like = 0;

  OrderController controller = OrderController();

  @override
  Widget build(BuildContext context) {
    controllerFavorites = Provider.of<FaveController>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonShadowWidget(
                          icon: Icon(Icons.arrow_back_ios_outlined),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ValueListenableBuilder(
                            valueListenable:
                                controllerFavorites.faveProductsNotifier,
                            builder: (context, value, _) {
                              if (widget.product.favorite == true) {
                                return ButtonShadowWidget(
                                  icon:
                                      Icon(AppIcons.like, color: AppColors.red),
                                  onTap: () {
                                    Provider.of<FaveController>(context,
                                            listen: false)
                                        .removeFavoriteProductId(
                                            id: widget.product);
                                    widget.product.favorite = false;
                                    setState(() {
                                      _OrderScreenState();
                                    });
                                  },
                                );
                              }
                              return ButtonShadowWidget(
                                icon: Icon(AppIcons.like_outline,
                                    color: AppColors.red),
                                onTap: () {
                                  Provider.of<FaveController>(context,
                                          listen: false)
                                      .addFavoriteProduct(
                                          product: widget.product);

                                  widget.product.favorite = true;
                                  print(widget.product.name);
                                  setState(() {
                                    _OrderScreenState();
                                  });
                                },
                              );
                            }),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 70, right: 70),
                      child: Text(
                        widget.product.name,
                        style: AppTextStyles.titleSemiBold,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 70, right: 70),
                      child: Text(
                        widget.product.description,
                        style: AppTextStyles.body,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Image.asset(widget.product.imageUrl),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ValueListenableBuilder(
                        valueListenable: controller.sizeNotifier,
                        builder: (context, value, _) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizeProductWidget(
                                title: "P",
                                selected: value == Sizes.P,
                                onTap: () {
                                  controller.size = Sizes.P;
                                },
                              ),
                              SizeProductWidget(
                                title: "M",
                                selected: value == Sizes.M,
                                onTap: () {
                                  controller.size = Sizes.M;
                                },
                              ),
                              SizeProductWidget(
                                title: "G",
                                selected: value == Sizes.G,
                                onTap: () {
                                  controller.size = Sizes.G;
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ValueListenableBuilder(
                          valueListenable: controller.quantityNotifier,
                          builder: (context, value, _) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AroundAmountWidget(
                                  icon: Icons.remove,
                                  onTap: () {
                                    if (controller.quantity >= 2) {
                                      controller.quantity -= 1;
                                    }
                                  },
                                ),
                                SizedBox(width: 50),
                                Text(
                                  "${controller.quantity}",
                                  style: AppTextStyles.letterAmount,
                                ),
                                SizedBox(width: 50),
                                AroundAmountWidget(
                                  icon: Icons.add,
                                  onTap: () {
                                    controller.quantity += 1;
                                  },
                                ),
                              ],
                            );
                          }),
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  height: 80,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, top: 19),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Preço",
                                style: AppTextStyles.heading,
                              ),
                              Text(
                                "R\$ ${widget.product.price}",
                                style: AppTextStyles.letterAmount,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ButtonAddCart(
                          onTap: () {
                            Provider.of<CartController>(context, listen: false)
                                .addProduct(
                                    product: widget.product,
                                    quantity: controller.quantity);

                            Navigator.pop(context);
                            Provider.of<PagesController>(context, listen: false)
                                .pageController
                                .jumpToPage(2);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

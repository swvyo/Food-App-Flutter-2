import 'package:flutter/material.dart';
import 'package:food_app/core/app_colors.dart';
import 'package:food_app/core/app_text_styles.dart';
import 'package:food_app/screens/order/widgets/button_shadow_widget.dart';
import 'package:food_app/util/app_icons_icons.dart';

class CardFavoritesWidget extends StatelessWidget {
  final String title;
  final double price;
  final String image;
  final String description;
  final Function onRemoveFavoriteProduct;
  final VoidCallback? onTap;

  const CardFavoritesWidget(
      {Key? key,
      required this.title,
      required this.price,
      required this.image,
      required this.description,
      required this.onRemoveFavoriteProduct,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black45.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(-4, -4), // changes position of shadow
          ),
          BoxShadow(
            color: Colors.black45.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(4, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Image.asset(this.image)),
          Expanded(
            flex: 9,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(this.title,
                                  style: AppTextStyles.titleFavorites),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(this.description,
                                  style: AppTextStyles.descriptionFavorites),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                  "R\$ ${this.price.toStringAsFixed(2)}",
                                  style: AppTextStyles.subtitle17),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                InkWell(
                  child: ButtonShadowWidget(
                    icon: Icon(
                      AppIcons.like,
                      color: AppColors.red,
                    ),
                    onTap: () => this.onRemoveFavoriteProduct(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

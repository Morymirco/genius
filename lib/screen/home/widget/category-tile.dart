import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/model/model.dart';
import 'package:coursenligne/util/util.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final Category ? category;

  const CategoryTile({
    Key ? key,
    this.category
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(75),
      decoration: BoxDecoration(
        border: Border.all(color: category!.isSelected == true ? AppColors.colorAccent : AppColors.colorTint400, width: category!.isSelected == true ? 0 : 1.5),
        color: category!.isSelected == true ? AppColors.colorAccent : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          category!.title!,
          style: TextStyle(
            color: category!.isSelected == true ? Colors.white : AppColors.colorTint500
          ),
        )
      ),
    );
  }
}
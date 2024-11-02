import 'package:coursenligne/model/model.dart';
import 'package:coursenligne/util/util.dart';
import 'package:flutter/material.dart';

import 'category-tile.dart';

class Categories extends StatefulWidget {
  const Categories({
    Key ? key
  }): super(key: key);

  @override
  State < Categories > createState() => _CategoriesState();
}

class _CategoriesState extends State < Categories > {

  List < Category > categories = [];

  @override
  void didChangeDependencies() {
    provideCategories();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6,
      child: Container(
        margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
        child: ListView.separated(
          itemCount: categories.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(8),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                setState(() {
                  for (var element in categories) {
                    element.isSelected = false;
                  }
                  categories[index].isSelected = true;
                });
              },
              child: CategoryTile(category: categories[index], )
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: getProportionateScreenWidth(10)
            );
          },
        ),
      ),
    );
  }


  Future < void > provideCategories() async {
    categories.add(Category(title: 'Tous', isSelected: true));
    categories.add(Category(title: 'Design', isSelected: false));
    categories.add(Category(title: 'Codage', isSelected: false));
    categories.add(Category(title: 'Business', isSelected: false));
    categories.add(Category(title: 'Marketing', isSelected: false));
  }
}
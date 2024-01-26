import 'package:flutter/material.dart';
import '../app_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 7 / 8,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      //لتحويل map الي list
      children: Categories_data.map(
        //للدخول الي CategoryItem   يجب اضافة ()=>
        (categoryData) => CategoryItem(
          title: categoryData.title,
          imageurl: categoryData.imageurl,
          id: categoryData.id,
        ),
      ).toList(),
    );
  }
}

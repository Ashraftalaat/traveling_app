import 'package:flutter/material.dart';
import '../screens/category_trips_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key,
      required this.title,
      required this.imageurl,
      required this.id});
  final String id;
  final String title;
  final String imageurl;

  void selectCategory(BuildContext ctx) {
    // navigator للتنقل بين الصفحات
    //.of لتوصل Navigator بال context
    //context بتحتوي علي المعلومات الخاصة بالwidget  وكذلك موقعها بشجرة ال widget
    //ctx = context
    //نستخدم MaterialPageRoute  للانتقال الي صفحة CategoryTripScreen
    //'/category-trips'هنستبدلها
    Navigator.of(ctx).pushNamed(CategoryTripsScreen.screenRoute, arguments: {
      'id': id,
      'title': title,
    });
    //push(القديم
    //MaterialPageRoute(
    //builder: (c) => CategoryTripsScreen(
    //categoryId: id,
    //categoryTitle: title,
    // ),
    // ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //inkwell لأمكانية الضغط علي stack
      //ontap للانتقال الي الصفحة
      //لكي نمرر او ندخل الي contextيجب أضافة()=>
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageurl,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}

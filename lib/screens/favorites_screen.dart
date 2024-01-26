import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../widgets/trip_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Trip> favoriteTrips;

  const FavoritesScreen(this.favoriteTrips, {super.key});

  @override
  Widget build(BuildContext context) {
    if (favoriteTrips.isEmpty) {
//لسنا بحاجة الي scafoldلانه هذه الصفحة جزء من صفحة tabs_screen
      return const Center(
        child: Text('ليس لديك اى رحلة في قائمة المفضلة'),
      );
      //اذا كانت الاجابة لا
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          //[index]لكل عنصر وداخل اقواس مربعة
          // return Text(filterdTrips[index].title);
          return TripItem(
            id: favoriteTrips[index].id,
            title: favoriteTrips[index].title,
            imageurl: favoriteTrips[index].imageurl,
            duration: favoriteTrips[index].duration.toString(),
            tripType: favoriteTrips[index].tripType.toString(),
            season: favoriteTrips[index].season.toString(),
            // removeItem: _removeTrip,
          );
        },
        //هنحصل علي عدد الرحلات الموجودين بكل تصنيف بعد ماعملت فلترة من خلالwhere
        itemCount: favoriteTrips.length,
      );
    }
  }
}
